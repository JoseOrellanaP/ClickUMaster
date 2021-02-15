import 'dart:developer';



import 'package:clikcus/adminScreens/admin_home.dart';
import 'package:clikcus/adminScreens/loginLogoutAdmin.dart';
import 'package:clikcus/tools/app_data.dart';
import 'package:clikcus/tools/app_methods.dart';
import 'package:clikcus/tools/app_tools.dart';
import 'package:clikcus/tools/firebase_methods.dart';
import 'package:clikcus/tools/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'favorites.dart';
import 'messages.dart';
import 'cart.dart';
import 'newsApp.dart';
import 'notification.dart';
import 'history.dart';
import 'settings.dart';
import 'address.dart';
import 'aboutUs.dart';
import 'loginLogout.dart';
import 'itemsDetails.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BuildContext context;
  String accName = "";
  String accEmail = "";
  String accPhotoURL = "";
  bool isLoggedIn;
  AppMethods appMethods = new FirebaseMethods();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  Future getCurrentUser() async{

    DocumentSnapshot userInfo =
    await appMethods.getUserInfo("H7yv1QXxJyV2Uv8sYupLt6z5okr2");
    print(userInfo[userEmail]);

    accName = await getStringDataLocally(key: fullNameL);
    accEmail = await getStringDataLocally(key: userEmail);
    print(accEmail);
    accPhotoURL = await getStringDataLocally(key: photoURL);
    isLoggedIn = await getBoolDataLocally(key: loggedIn);

    accName == null ? accName = "Guess User" : accName;
    accEmail == null ? accEmail = "guestUser@gmail.com" : accEmail;

    setState(() {});

  }




  @override
  Widget build(BuildContext context) {

    this.context = context;

    return DefaultTabController(
      length: 6,
      child: new Scaffold(
        appBar: new AppBar(
          bottom: TabBar(

            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicatorColor: Colors.white,

            onTap: (index){

            },
            tabs: [
              Tab(
              child: Text(
                "Todos",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              ),
              Tab(
                child: Text(
                  "Laptops",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Accesorios",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Gadgets",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Celulares/Tablets",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Varios",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
          title: GestureDetector(
            onLongPress: logAdmin,
            child: Text(
                "ClickU",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: <Widget>[
            /*
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.of(context).push(
                    CupertinoPageRoute(
                        builder: (BuildContext context) {
                          return clickUFavorities();
                        })
                );
              },
            ),

             */

            /*
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    Navigator.of(context).push(
                        CupertinoPageRoute(
                            builder: (BuildContext context){
                              return clickUMessages();
                            }
                        )
                    );
                  },
                ),
                CircleAvatar(
                  radius: 10.0,
                  backgroundColor: Colors.red,
                  child: Text(
                    "0",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                )
              ],
            )

             */

          ],
        ),
        body: TabBarView(
          children: [
            StreamBuilder(
                stream: firestore.collection(appProducts).snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor
                        ),
                      ),
                    );
                  }else{
                    final int dataCount = snapshot.data.docs.length;
                    print("data count $dataCount");
                    if(dataCount == 0){
                      return noDataFound();
                    }else{
                      String cat = "Laptops";
                      //final DocumentSnapshot document = snapshot.data.docs;


                      return createList(dataCount, snapshot);
                    }
                  }
                }),
            StreamBuilder(
              //stream: firestore.collection(appProducts).snapshots(),
                stream: firestore.collection(appProducts).where("ProductCat",
                    isEqualTo: "Laptops").snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor
                        ),
                      ),
                    );
                  }else{
                    final int dataCount = snapshot.data.docs.length;
                    print("data count $dataCount");
                    if(dataCount == 0){
                      return noDataFound();
                    }else{
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .85,
                        ),
                        itemCount: dataCount,
                        itemBuilder: (context, index){
                          final DocumentSnapshot document =
                          snapshot.data.docs[index];
                          return buildProducts(context, index, document);
                        },
                      );
                    }
                  }
                }),
            StreamBuilder(
              //stream: firestore.collection(appProducts).snapshots(),
                stream: firestore.collection(appProducts).where("ProductCat",
                    isEqualTo: "Accesorios").snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor
                        ),
                      ),
                    );
                  }else{
                    final int dataCount = snapshot.data.docs.length;
                    print("data count $dataCount");
                    if(dataCount == 0){
                      return noDataFound();
                    }else{
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .85,
                        ),
                        itemCount: dataCount,
                        itemBuilder: (context, index){
                          final DocumentSnapshot document =
                          snapshot.data.docs[index];
                          return buildProducts(context, index, document);
                        },
                      );
                    }
                  }
                }),
            StreamBuilder(
              //stream: firestore.collection(appProducts).snapshots(),
                stream: firestore.collection(appProducts).where("ProductCat",
                    isEqualTo: "Gadgets").snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor
                        ),
                      ),
                    );
                  }else{
                    final int dataCount = snapshot.data.docs.length;
                    print("data count $dataCount");
                    if(dataCount == 0){
                      return noDataFound();
                    }else{
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .85,
                        ),
                        itemCount: dataCount,
                        itemBuilder: (context, index){
                          final DocumentSnapshot document =
                          snapshot.data.docs[index];
                          return buildProducts(context, index, document);
                        },
                      );
                    }
                  }
                }),
            StreamBuilder(
              //stream: firestore.collection(appProducts).snapshots(),
                stream: firestore.collection(appProducts).where("ProductCat",
                    isEqualTo: "Celulares/Tablets").snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor
                        ),
                      ),
                    );
                  }else{
                    final int dataCount = snapshot.data.docs.length;
                    print("data count $dataCount");
                    if(dataCount == 0){
                      return noDataFound();
                    }else{
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .85,
                        ),
                        itemCount: dataCount,
                        itemBuilder: (context, index){
                          final DocumentSnapshot document =
                          snapshot.data.docs[index];
                          return buildProducts(context, index, document);
                        },
                      );
                    }
                  }
                }),
            StreamBuilder(
              //stream: firestore.collection(appProducts).snapshots(),
                stream: firestore.collection(appProducts).where("ProductCat",
                    isEqualTo: "Varios").snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor
                        ),
                      ),
                    );
                  }else{
                    final int dataCount = snapshot.data.docs.length;
                    print("data count $dataCount");
                    if(dataCount == 0){
                      return noDataFound();
                    }else{
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .85,
                        ),
                        itemCount: dataCount,
                        itemBuilder: (context, index){
                          final DocumentSnapshot document =
                          snapshot.data.docs[index];
                          return buildProducts(context, index, document);
                        },
                      );
                    }
                  }
                }),

          ],
        ),

        /*
        floatingActionButton: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            FloatingActionButton(
              onPressed: (){
                Navigator.of(context).push(
                    CupertinoPageRoute(
                        builder: (BuildContext context){
                          return ClickUCart();
                        }
                    )
                );
              },
              child: Icon(Icons.shopping_cart),
            ),
            CircleAvatar(
              radius: 10.0,
              backgroundColor: Colors.red,
              child: Text(
                "0",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),

         */


        drawer: Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                    accName
                ),
                accountEmail: Text(
                    accEmail
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                  ),
                ),
              ),




              /*
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.notifications,
                    color: Colors.white,
                    size: 20,),
                ),
                title: Text("Order Notification"),
                onTap: (){
                  Navigator.of(context).push(
                      CupertinoPageRoute(
                          builder: (BuildContext context){
                            return clickUNotifications();
                          }
                      )
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.history,
                    color: Colors.white,
                    size: 20,),
                ),
                title: Text("Order History"),
                onTap: (){
                  Navigator.of(context).push(
                      CupertinoPageRoute(
                          builder: (BuildContext context){
                            return clickUHistory();
                          }
                      )
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person,
                    color: Colors.white,
                    size: 20,),
                ),
                title: Text("Profile Settings"),
                onTap: (){
                  Navigator.of(context).push(
                      CupertinoPageRoute(
                          builder: (BuildContext context){
                            return clickUSettings();
                          }
                      )
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.home,
                    color: Colors.white,
                    size: 20,),
                ),
                title: Text("Delivery Address"),
                onTap: (){
                  Navigator.of(context).push(
                      CupertinoPageRoute(
                          builder: (BuildContext context){
                            return clickUAdress();
                          }
                      )
                  );
                },
              ),
              Divider(),
               */



              ListTile(
                trailing: CircleAvatar(
                  child: Icon(Icons.help,
                    color: Colors.white,
                    size: 20,),
                ),
                title: Text("About Us"),
                onTap: (){
                  Navigator.of(context).push(
                      CupertinoPageRoute(
                          builder: (BuildContext){
                            return clickUAboutUs();
                          }
                      )
                  );
                },

              ),
              ListTile(
                trailing: CircleAvatar(
                  child: Icon(Icons.view_list,
                    color: Colors.white,
                    size: 20,),
                ),
                title: Text("Noticias"),
                onTap: (){
                  Navigator.of(context).push(
                      CupertinoPageRoute(
                          builder: (BuildContext){
                            return clickUnewsApp();
                          }
                      )
                  );
                },

              ),

              /*
              ListTile(
                trailing: CircleAvatar(
                  child: Icon(Icons.exit_to_app,
                    color: Colors.white,
                    size: 20,),
                ),
                title: Text(isLoggedIn == true ? "Log Out" : "Log In"),
                //onTap: checkIfLoggedIn,
                onTap: checkIfLoggedIn,

              ),

               */

            ],
          ),
        ),


      ),
    );
  }

  createList(int dataCount, AsyncSnapshot snapshot){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .85,
      ),
      itemCount: dataCount,
      itemBuilder: (context, index){
        final DocumentSnapshot document =
        snapshot.data.docs[index];
        return buildProducts2(context, index, document);
      },
    );
  }

  checkIfLoggedIn() async{

    if(isLoggedIn == false){

        bool response = await Navigator.of(context).push(
            CupertinoPageRoute(
                builder: (BuildContext context) => clickULoginLogOut()
            )
        );
        if(response == true) getCurrentUser();
        return;
    }
    bool response = await appMethods.LoggOutUser();
    if(response == true) getCurrentUser();

    
  }

  logAdmin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => clickULoginLogOutAdmin()
      )
    );
  }

  Widget noDataFound(){
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.find_in_page,
              color: Colors.black45,
              size: 80.0,
            ),
            Text(
              "Not product available yet",
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 20.0
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Please check back later",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProducts(BuildContext context, int index, DocumentSnapshot document) {

    List productImage = document[productImages] as List;
    print(productImage[0]);

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => itemDetail(

              itemImage: productImage[0],
              itemImages: productImage,
              itemName: document[productTitle],
              itemSubname: document[productCat],
              itemPrice: document[productPrice],
              itemSize: document[productSize],
              itemColor: document[productColor],
              itemDescription: document[productDesc],
              itemSeller: document[productSeller],

            )
        ));
      },
      child: Card(
        child: Stack(
          alignment: FractionalOffset.topLeft,
          children: [
            Stack(
              alignment: FractionalOffset.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(
                            productImage[0]
                              //storeItems[index].itemImage,
                            //document[productImages]
                          )
                      )
                  ),
                ),
                Container(
                  height: 50.0,
                  width: 150.0,
                  color: Colors.black.withAlpha(100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8,0,8,0),
                        child: Text(
                          "${document[productTitle]}",
                          //"${storeItems[index].itemName.substring(0, 8)}...",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                              color: Colors.white
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      SizedBox(height: 5.0,),
                      Text(
                        //"N${storeItems[index].itemPrice}",
                        "USD ${document[productPrice]}",
                        style: TextStyle(
                          color: Colors.red[500],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            
            Column(
              children: [
                Text(
                  //todo put state
                  //document[productState],
                  document[productState],
                  style: TextStyle(
                    color: setColor(document[productState]),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          /*
                          Icon(
                            Icons.star,
                            color: Colors.blue,
                            size: 20.0,
                          ),
                          Text(
                            "${storeItems[index].itemRating}",
                            style: TextStyle(color: Colors.white),
                          ),

                           */
                        ],
                      ),

                    ),
                    SizedBox(width: 3.0,),
                    /*
                    IconButton(
                      icon: Icon(
                          Icons.favorite_border,
                          color: Colors.blue
                      ),
                      onPressed: (){},
                    )

                     */
                  ],
                ),


              ],
            ),


          ],
        ),
      ),
    );
  }

  Widget buildProducts2(BuildContext context, int index, DocumentSnapshot document) {

    List productImage = document[productImages] as List;
    print(productImage[0]);

    return GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => itemDetail(

                itemImage: productImage[0],
                itemImages: productImage,
                itemName: document[productTitle],
                itemSubname: document[productCat],
                itemPrice: document[productPrice],
                itemSize: document[productSize],
                itemColor: document[productColor],
                itemDescription: document[productDesc],
                itemSeller: document[productSeller],

              )
          ));
        },
        child: Card(
          child: Stack(
            alignment: FractionalOffset.topLeft,
            children: [
              Stack(
                alignment: FractionalOffset.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: NetworkImage(
                                productImage[0]
                              //storeItems[index].itemImage,
                              //document[productImages]
                            )
                        )
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: 150.0,
                    color: Colors.black.withAlpha(100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8,0,8,0),
                          child: Text(
                            "${document[productTitle]}",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                color: Colors.white
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        SizedBox(height: 5.0,),
                        Text(
                          //"N${storeItems[index].itemPrice}",
                          "USD ${document[productPrice]}",
                          style: TextStyle(
                            color: Colors.red[500],
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    //todo put state
                    //document[productState],
                    document[productState],
                    style: TextStyle(
                      color: setColor(document[productState]),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*
                            Icon(
                              Icons.star,
                              color: Colors.blue,
                              size: 20.0,
                            ),
                            Text(
                              "${storeItems[index].itemRating}",
                              style: TextStyle(color: Colors.white),
                            ),

                             */
                          ],
                        ),

                      ),
                      SizedBox(width: 3.0,),
                      /*
                      IconButton(
                        icon: Icon(
                            Icons.favorite_border,
                            color: Colors.blue
                        ),
                        onPressed: (){},
                      )

                       */
                    ],
                  ),


                ],
              ),


            ],
          ),
        ),
      );

  }



  setColor(String state) {
    if (state.toLowerCase() == "agotado"){
      return Colors.red[800];
    }else{
      return Colors.brown[900];
    }

  }




}
