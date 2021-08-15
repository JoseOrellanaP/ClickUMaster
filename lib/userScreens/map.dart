import 'dart:async';

import 'package:clikcus/tools/app_data.dart';
import 'package:clikcus/tools/getQueries.dart';
import 'package:clikcus/tools/lauchSocialN.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:floating_pullup_card/floating_pullup_card.dart';

class clickUMap extends StatefulWidget {

  String itemName;
  List listLatitude;
  List listLongitude;
  List listOwnerName;
  List listPhoneStore;
  BitmapDescriptor iconI;


  clickUMap({
      this.itemName,
    this.listLatitude,
    this.listLongitude,
    this.listOwnerName,
    this.listPhoneStore,
    this.iconI,
  });

  @override
  _clickUMapState createState() => _clickUMapState();
  
}

class _clickUMapState extends State<clickUMap> {


  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Completer<GoogleMapController> _controller = Completer();
  static final LatLng _center = const LatLng(-2.896040, -78.990754);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  var reviews;

  String messageC = "Hola, me gustaria coordinar el retiro de: ";


  @override
  void initState() {
    super.initState();


    List<double> lat = List();
    List<double> long = List();
    List<String> owner = List();
    List<String> phoneN = List();


    for (int i=0; i<widget.listLongitude.length; i++){
      lat.add(double.parse(widget.listLatitude[i]));
      long.add(double.parse(widget.listLongitude[i]));
      owner.add(widget.listOwnerName[i]);
      phoneN.add(widget.listPhoneStore[i]);
    }


    setState((){


      for (int i = 0; i<lat.length; i++){


        double lati = lat[i];
        double longi = long[i];
        String ownerN = owner[i];
        String phoneNu = phoneN[i];

        _markers.add(
          Marker(
            markerId: MarkerId(_lastMapPosition.toString()),
            //position: _lastMapPosition,
            //position: const LatLng(-2.917901,-79.0505308),
            position: LatLng(lati,longi),
            infoWindow: InfoWindow(
                onTap: (){
                  print("Tap $ownerN");
                },
                title: "Punto N ${i+1}",
                snippet: "Local $ownerN"
            ),
            //icon: BitmapDescriptor.defaultMarker,
            icon: widget.iconI,
          ),
        );
      }



    });

  }



  static final CameraPosition _position1 = CameraPosition(
    //bearing: 192.833,
    target: LatLng(-2.896040, -78.990754),
    tilt: 59.440,
    zoom: 14.0,
  );


  Future<void> _goToPosition1() async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  Future<void> _goToPositionMarker(double lat, double long) async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(lat, long),
        tilt: 59.440,
        zoom: 14.0,
      )
    ));
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position){
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed(){
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }


  Widget button(Function function, IconData icon, String heroTag){
    return FloatingActionButton(
      heroTag: "$heroTag",
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.orange,
      child: Icon(
        icon,
        size: 36.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    double dimension = 50;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Puntos de retiro'),
          backgroundColor: Colors.orange,
        ),
        
        body: FloatingPullUpCardLayout(
          child: Stack(
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                mapType: _currentMapType,
                markers: _markers,
                onCameraMove: _onCameraMove,
              ),

              Padding(
                padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      button(_onMapTypeButtonPressed, Icons.map, "btn1"),
                      SizedBox(
                        height: 16.0,
                      ),
                      button(_goToPosition1, Icons.location_searching, "btn3")
                    ],
                  ),
                ),
              ),

              




            ],
          ),
          body: Container(
            child: ListView.builder(
              itemCount: widget.listLongitude.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            double lat = double.parse(widget.listLatitude[index]);
                            double long = double.parse(widget.listLongitude[index]);
                            _goToPositionMarker(lat, long);
                          },
                          color: Colors.white60,
                          textColor: Colors.black,
                          child: Column(
                            children: [
                              /*
                              Icon(
                                Icons.store,
                                size: 80,
                              ),

                               */
                              Image.asset("assets/logo_co.png",
                              width: 80,
                              height: 80,),
                              Text("Buscar",
                              style: TextStyle(
                                fontSize: 20.0
                              ),)
                            ],
                          ),
                          padding: EdgeInsets.all(16),
                          shape: CircleBorder(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("Punto de retiro ${index+1}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                              SizedBox(height: 10.0,),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Nombre: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),),
                                    Text(widget.listOwnerName[index]),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Text("Contactar por: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    child: Image.asset("assets/whatsapp_icon.png",
                                      height: dimension,
                                    width: dimension,),
                                    onTap: (){
                                      lauchWhattsap(
                                          number: "+593${widget.listPhoneStore[index]}",
                                          message: "$messageC${widget.itemName}");
                                    },
                                  ),
                                  SizedBox(width: 15.0),
                                  GestureDetector(
                                    child: Image.asset("assets/call_icon.png",
                                      height: dimension*.5,
                                      width: dimension*.5,),
                                    onTap: (){
                                      launchPhone(number: widget.listPhoneStore[index]);
                                    },
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                );
              },
            ),
          ),
          width: MediaQuery.of(context).size.width*.95,
          cardColor: Colors.orange,
          borderRadius: BorderRadius.circular(25.0),
          state: FloatingPullUpState.collapsed,
          uncollpsedStateOffset: (maxHeight) => MediaQuery.of(context).size.height*.5,

        ),
      ),
    );
  }


  List<String> getData(String itemName, String nameC) {
    firestore.collection(storeLocations).where("ProductTitle", isEqualTo: itemName)
        .get().then((querySnapshot) {
      List list = List();
      querySnapshot.docs.forEach((element) {
        list.add(element.data()["$nameC"]);
      });

      //print("The lenght is ${list.length}");
    });
  }

  getDatas(datac) {
    print("Conte $datac");


  }



}
