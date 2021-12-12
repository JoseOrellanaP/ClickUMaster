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

class Landing_screen2 extends StatefulWidget {
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
  const Choice(title: 'Todos', icon: Icons.home, color: Colors.pink, index: 0),
  const Choice(
      title: 'Laptops', icon: Icons.laptop, color: Colors.black87, index: 1),
  const Choice(
      title: 'Accesorios',
      icon: Icons.headset_mic,
      color: Colors.purple,
      index: 2),
  const Choice(
      title: 'Gadgets', icon: Icons.gamepad, color: Colors.green, index: 3),
  const Choice(
      title: 'Phone/Tablets',
      icon: Icons.smartphone,
      color: Colors.red,
      index: 4),
  const Choice(
      title: 'Varios', icon: Icons.device_hub, color: Colors.brown, index: 5),
];

class _Landing_screenState extends State<Landing_screen2> {
  //var reviews;
  Map reviews;

  var trendingMap2, newest, soonStock, discount;

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
    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }

    getInitialData();

    setState(() {
      super.initState();
    });

    //_checkVersion();
  }

  getInitialData() async {
    trendingMap2 = await getDataFireBase().getUsers2("Trending");
    newest = await getDataFireBase().getUsers2("Nuevo");
    soonStock = await getDataFireBase().getUsers2("Proximamente");
    discount = await getDataFireBase().getUsers2("Descuento");

    setState(() {});
  }

  versionCheck(context) async {
    //Get current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion =
        double.parse(info.version.trim().replaceAll(".", ""));

    // Get latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      remoteConfig.getString('force_update_current_version');
      double newVersion = double.parse(remoteConfig
          .getString("force_update_current_version")
          .trim()
          .replaceAll(".", ""));

      if (newVersion > currentVersion) {
        _showVersionDialog(context);
      }
    } on FetchThrottledException catch (exception) {
      // Fetch throttled
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Catched or default values will be'
          'used');
    }
  }

  _showVersionDialog(context) async {
    await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
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
                      onPressed: () {
                        _launchURL(APP_STORE_URL);
                      },
                    ),
                    FlatButton(
                      child: Text(btnLabelCancel),
                      onPressed: () {
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
                      onPressed: () {
                        _launchURL(PLAY_STORE_URL);
                      },
                    ),
                    FlatButton(
                      child: Text(btnLabelCancel),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
        });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    int division = 8;

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
                onLongPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          clickULoginLogOutAdmin()));
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
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "ClickU",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.0),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              side:
                                  BorderSide(width: 10, color: Colors.orange)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/clicku_gif2.gif",
                              height: screen_height / 3,
                              width: screen_width,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),

/*
        Start horizontal list of options
*/

                      Text(
                        "Categorias",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    goToGroup(0);
                                  },
                                  elevation: 25.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: Colors.green[900],
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.home,
                                          size: 40,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "Todos",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RaisedButton(
                                  elevation: 25.0,
                                  onPressed: () {
                                    goToGroup(1);
                                  },
                                  color: Colors.blue[300],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.laptop,
                                          size: 40,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "Laptops",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RaisedButton(
                                  elevation: 25.0,
                                  onPressed: () {
                                    goToGroup(2);
                                  },
                                  color: Colors.orange[100],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.headphones,
                                          size: 40,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "Accesorios",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RaisedButton(
                                  elevation: 25.0,
                                  onPressed: () {
                                    goToGroup(3);
                                  },
                                  color: Colors.red[700],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.gamepad,
                                          size: 40,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "Gadgets",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RaisedButton(
                                  elevation: 25.0,
                                  onPressed: () {
                                    goToGroup(4);
                                  },
                                  color: Colors.yellow[700],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.phone_android,
                                          size: 40,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "Phone/Tablets",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RaisedButton(
                                  elevation: 25.0,
                                  onPressed: () {
                                    goToGroup(5);
                                  },
                                  color: Colors.purple[700],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.device_hub,
                                          size: 40,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "Varios",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

/*
            Ends categorical horizontal list
*/




                      SizedBox(height: 35,),
                      Text("Recomendaciones",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold
                        ),),

                      getCard("Lo mas vendido", trendingMap2),
                      getCard("Nuevas adquisiciones", newest),
                      getCard("Próximamente en ClickU", soonStock),
                      getCard("Hora del ahorro, precios reducidos", discount),
                      SizedBox(
                        height: 35.0,
                      ),



                      /*
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              side: BorderSide(width: 3, color: Colors.orange)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "Categorias disponibles",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: screen_width,
                                height: screen_height * .45,
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
                      
                      */

                      
                      SizedBox(
                        height: 35.0,
                      ),
                    ],
                  ),
                )
              ]),
            )
          ],
        ));
  }

  Widget getCard(String listName, stateC) {
    try {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              side: BorderSide(width: 3, color: Colors.orange)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  listName,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                //getImageC2(context, widget.newest),
                getImageC2(context, stateC),
              ],
            ),
          ),
        ),
      );
    } catch (error) {
      return Card();
    }
  }

  goToGroup(int index) {
    Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext) {
      return MyHomePage(index);
    }));
  }
}

getImageC2(context, imag) {
  return Container(
      height: MediaQuery.of(context).size.width * .6,
      child: Swiper(
        pagination: SwiperPagination(),
        autoplay: true,
        layout: SwiperLayout.DEFAULT,
        itemCount: imag.length,
        //itemCount: 2,
        itemBuilder: (context, index) {
          return Image.network(
            imag[index][productImages][0],
            fit: BoxFit.cover,
          );
        },

        itemHeight: 300.0,
        itemWidth: MediaQuery.of(context).size.width,

        onTap: (index) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => itemDetail(
                    itemImage: imag[index][productImages][0],
                    itemImages: imag[index][productImages] as List,
                    itemName: imag[index][productTitle],
                    itemSubname: imag[index][productCat],
                    itemPrice: imag[index][productPrice],
                    itemSize: imag[index][productSize],
                    itemColor: imag[index][productColor],
                    itemDescription: imag[index][productDesc],
                    itemSeller: imag[index][productSeller],
                    itemState: imag[index][productState],
                  )));
        },
      ));
}

logAdmin(context) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => clickULoginLogOutAdmin()));
}

getLists(BuildContext context, trendingMap, outStockMap, newestMap, soonMap,
    discountMap) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => fastLists2(
            trending: trendingMap,
            outStock: outStockMap,
            newest: newestMap,
            soon: soonMap,
            discount: discountMap,

            /*
            imageList: listImages,
            titleList: listTitle,
            listCategory: listCategory,
            listPrices: listPrices,
            listSizes: listSizes,
            listColor: listColor,
            listDesc: listDesc,
            listSeller: listSeller,
            listState: listState,

             */
          )));
}

class SelectCard extends StatelessWidget {
  const SelectCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(fontSize: 15.0);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 1.0, top: 1.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  print(choice.index);
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (BuildContext) {
                    return MyHomePage(choice.index);
                  }));
                },
                child: CircleAvatar(
                  radius: 35.0,
                  backgroundColor: choice.color,
                  child: Icon(
                    choice.icon,
                    size: 40.0,
                    color: textStyle.color,
                  ),
                ),
              )),
              SizedBox(
                height: 4.0,
              ),
              Text(choice.title, style: textStyle),
            ]),
      ),
    );
  }
}
