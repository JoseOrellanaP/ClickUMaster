
import 'dart:collection';
import 'dart:io';

import 'package:clikcus/adminScreens/loginLogoutAdmin.dart';
import 'package:clikcus/tools/app_data.dart';
import 'package:clikcus/tools/getQueries.dart';
import 'package:clikcus/userScreens/fastLists2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:new_version/new_version.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';


import 'itemsDetails.dart';
import 'myHomePage.dart';




class Landing_screen extends StatefulWidget {

  @override
  _Landing_screenState createState() => _Landing_screenState();
}


//final usersRef = FirebaseFirestore.instance.collection(appProducts);


class Choice {
  const Choice({this.title, this.icon, this.color, this.index});
  final String title;
  final IconData icon;
  final Color color;
  final int index;
}



const List<Choice> choices = const <Choice>[
  const Choice(title: 'Todos', icon: Icons.home, color: Colors.pink, index:0),
  const Choice(title: 'Laptops', icon: Icons.laptop, color: Colors.black87, index: 1),
  const Choice(title: 'Accesorios', icon: Icons.headset_mic, color: Colors.purple, index: 2),
  const Choice(title: 'Gadgets', icon: Icons.gamepad, color: Colors.green, index: 3),
  const Choice(title: 'Phone/Tablets', icon: Icons.smartphone, color: Colors.red, index: 4),
  const Choice(title: 'Varios', icon: Icons.device_hub, color: Colors.brown, index: 5),
];


class _Landing_screenState extends State<Landing_screen> {

  //var reviews;
  Map reviews;


  static const PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.store.clikcus';
  static const APP_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.store.clikcus';


  List<dynamic> listImages = List();
  List listTitle = List();
  List listCategory = List();
  List listPrices = List();
  List listSizes = List();
  List listColor = List();
  List listDesc = List();
  List listSeller = List();
  List listState = List();


  var outStockMap;


  @override
  void initState() {


    try{
      versionCheck(context);
    }catch(e){
      print(e);
    }
    super.initState();





    
    //_checkVersion();

  }

  versionCheck(context) async{
    //Get current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion =
        double.parse(info.version.trim().replaceAll(".", ""));

    // Get latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try{
      // Using default duration to force fetching from remote server
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      remoteConfig.getString('force_update_current_version');
      double newVersion = double.parse(remoteConfig
        .getString("force_update_current_version")
        .trim()
        .replaceAll(".", ""));

      if(newVersion>currentVersion){
        _showVersionDialog(context);
      }

    }on FetchThrottledException catch (exception){
      // Fetch throttled
      print(exception);
    }catch(exception){
      print('Unable to fetch remote config. Catched or default values will be'
      'used');
    }
  }


  _showVersionDialog(context) async{
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        String title = "New update available";
        String message =
          "There is a newer version of app available, please update it now.";
        String btnLabel = "Update now";
        String btnLabelCancel = "Later";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            FlatButton(
              child: Text(btnLabel),
              onPressed: (){
                _launchURL(APP_STORE_URL);
              },
            ),
            FlatButton(
              child: Text(btnLabelCancel),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        )
            : new AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            FlatButton(
              child: Text(btnLabel),
              onPressed: (){
                _launchURL(PLAY_STORE_URL);
              },
            ),
            FlatButton(
              child: Text(btnLabelCancel),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
    );
  }

  _launchURL(String url) async{
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }



  @override
  Widget build(BuildContext context) {

    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white.withAlpha(989),

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 10,
              centerTitle: true,
              title: GestureDetector(
                onLongPress:(){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => clickULoginLogOutAdmin()
                      )
                  );
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/logo_co.png"),
                      fit: BoxFit.contain,
                      color: Colors.black,
                      height: 62.0,
                    ),
                    SizedBox(width: 10.0,),
                    Text("ClickU",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0
                      ),)
                  ],
                ),

              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    child: Column(
                  children: [
                  SizedBox(height: 15.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          side: BorderSide(width: 10, color: Colors.orange)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/clicku_gif2.gif",
                          height: screen_height/3,
                          width: screen_width,),
                      ),
                    ),
                  ),
                  SizedBox(height: 35.0,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            child: Stack(
                              children: [
                                Image.asset("assets/listas.jpg",
                                ),
                                Positioned(
                                  top: 150,
                                  bottom: 12,
                                  left: 140,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: RaisedButton(
                                      color: Colors.purple[400],
                                      child: Text(
                                        "Ver Listas",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: ()async{


                                        var trendingMap = await getDataFireBase().getUsers2("Trending");

                                        var outStockMap = await getDataFireBase().getUsers2("Agotado");

                                        var newestMap = await getDataFireBase().getUsers2("Nuevo");

                                        var soonMap = await getDataFireBase().getUsers2("Proximamente");

                                        var discountMap = await getDataFireBase().getUsers2("Descuento");

                                        return getLists(context, trendingMap,
                                            outStockMap, newestMap, soonMap, discountMap);



                                      },
                                    ),
                                  ),
                                )
                              ],

                            ),
                            onTap: (){

                            }
                        ),
                      ],
                    ),
                  ),




                  SizedBox(height: 35.0,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          side: BorderSide(width: 3, color: Colors.orange)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("Categorias",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                          Container(
                            width: screen_width,
                            height: screen_height*.45,
                            child: GridView.count(
                              //padding: const EdgeInsets.all(1),
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              children:
                              List.generate(choices.length, (index) {
                                return Center(
                                  child: SelectCard(choice: choices[index]),
                                );
                              }),

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 35.0,),
                ],
              ),
                  )
                ]
              ),
            )
          ],

        )
    );
  }

}


logAdmin(context) {
  Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context) => clickULoginLogOutAdmin()
      )
  );

}

getLists(BuildContext context, trendingMap, outStockMap, newestMap,
    soonMap, discountMap){


  Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context) => fastLists2(


            trending: trendingMap,
            outStock: outStockMap,
            newest: newestMap,
            soon: soonMap,
            discount: discountMap,



          )
      )
  );


}


class SelectCard extends StatelessWidget {
  const SelectCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
        fontSize: 15.0
    );
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 1.0, top: 1.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: GestureDetector(
                    onTap: (){
                      print(choice.index);
                      Navigator.of(context).push(
                          CupertinoPageRoute(
                              builder: (BuildContext){
                                return MyHomePage(choice.index);
                              }
                          )
                      );

                    },
                    child: CircleAvatar(
                      radius: 35.0,
                      backgroundColor: choice.color,
                      child: Icon(choice.icon,
                        size:40.0,
                        color: textStyle.color,
                      ),
                    ),
                  )
              ),
              SizedBox(height: 4.0,),
              Text(choice.title, style: textStyle),

              

            ]
        ),
      ),
    );
  }

}



