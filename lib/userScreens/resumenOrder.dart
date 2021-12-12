import 'package:clikcus/tools/app_data.dart';
import 'package:clikcus/tools/getQueries.dart';
import 'package:clikcus/tools/lauchSocialN.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map.dart';

class clicUOrderNow extends StatefulWidget {

  String itemName;
  String itemImage;
  String itemPrice;
  String itemSize;
  String itemColor;




  clicUOrderNow(
      this.itemName,
      this.itemImage,
      this.itemPrice,
      this.itemSize,
      this.itemColor,
      );

  @override
  _clicUOrderNowState createState() => _clicUOrderNowState();
}

class _clicUOrderNowState extends State<clicUOrderNow> {



  String messageC = "Hola quisiera coordinar la entrega de: ";


  BitmapDescriptor iconLocation;
  var reviews;
  List<dynamic> listLatitude = List();
  List<dynamic> listLongitude = List();
  List<dynamic> listOwnerStore = List();
  List<dynamic> listPhoneStore = List();

  @override
  void initState() {
    super.initState();


    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        "assets/mark.png").then((value) {
      iconLocation = value;
    });


    getDataFireBase()
        .getDataFireBaseData(storeLocations, widget.itemName)
        .then((QuerySnapshot docs){
      if(docs.docs.isNotEmpty){

          for (int i = 0; i<docs.docs.length; i++){


            reviews = docs.docs[i].data();


            listLatitude.add(reviews["StoreLatitude"]);
            listLongitude.add(reviews["StoreLongitude"]);
            listOwnerStore.add(reviews["OwnerName"]);
            listPhoneStore.add(reviews["PhoneNumber"]);


          }



      }
    });


  }


  @override
  Widget build(BuildContext context) {

    int division = 8;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Resumen de la orden"
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          widget.itemImage
                      ),
                      fit: BoxFit.fitHeight
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(120.0),
                    bottomLeft: Radius.circular(120.0),
                  )
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  widget.itemName,
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Text(
              "USD ${widget.itemPrice}",
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 50.0,),
            Text(
              "Coordinar la compra con el vendedor por:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 35.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      RaisedButton(
                        onPressed: (){
                          lauchWhattsap(
                          number: "+593${widget.itemSize}",
                          message: "$messageC${widget.itemName}");
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        color: Colors.green[900],
                        child: Column(
                          children: [
                            Image.asset("assets/whatsapp_icon.png",
                            width: MediaQuery.of(context).size.width /division,),
                            SizedBox(height: 5.0,),
                            Text("Whatsapp",
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(height: 5.0,),

                          ],
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      RaisedButton(

                        onPressed: (){
                          launchPhone(number: widget.itemSize);
                        },
                        color: Colors.blue[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            Image.asset("assets/call_icon.png",
                              width: MediaQuery.of(context).size.width /division,),
                            SizedBox(height: 5.0,),
                            Text("Llamada",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),),
                            SizedBox(height: 5.0,),

                          ],
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      RaisedButton(

                        onPressed: (){
                          launchSMS(
                              number: widget.itemSize,
                              message: "$messageC${widget.itemName}");
                        },
                        color: Colors.white60,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            Image.asset("assets/sms_icon.png",
                              width: MediaQuery.of(context).size.width /division,),
                            SizedBox(height: 5.0,),
                            Text("Mensaje",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),),
                            SizedBox(height: 5.0,),

                          ],
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      RaisedButton(

                        onPressed: (){
                          launchEmail(
                              email: widget.itemColor,
                              message: "$messageC${widget.itemName}");
                        },
                        color: Colors.red[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            Image.asset("assets/gmail_icon.png",
                              width: MediaQuery.of(context).size.width /division,),
                            SizedBox(height: 5.0,),
                            Text("Email",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),),
                            SizedBox(height: 5.0,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 55.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "O revisar los diferentes puntos de retiro:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                color: Colors.white.withOpacity(.9),
                child: Column(
                  children: [
                    Image.asset("assets/map.png",
                      width: MediaQuery.of(context).size.width /division,),
                    SizedBox(height: 5.0,),
                    Text("Mapa",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),),
                    SizedBox(height: 5.0,),

                  ],
                ),
                onPressed: (){
                  
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => clickUMap(
                      itemName: widget.itemName,
                      listLatitude: listLatitude,
                      listLongitude: listLongitude,
                      listOwnerName: listOwnerStore,
                      listPhoneStore: listPhoneStore,
                      iconI: iconLocation,
                    ),
                  ));

                },
              ),
            ),
          ],
        ),
      ),
    );
  }


}
