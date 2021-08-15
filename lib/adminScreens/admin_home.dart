import 'package:clikcus/adminScreens/add_Stores.dart';
import 'package:clikcus/adminScreens/add_products.dart';
import 'package:clikcus/adminScreens/app_orders.dart';
import 'package:clikcus/adminScreens/privileges.dart';
import 'package:clikcus/adminScreens/register_store.dart';
import 'package:clikcus/adminScreens/search_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_News.dart';
import 'app_messages.dart';
import 'app_products.dart';
import 'app_users.dart';
import 'order_history.dart';

class adminHome extends StatefulWidget {
  @override
  _adminHomeState createState() => _adminHomeState();
}

class _adminHomeState extends State<adminHome> {

  Size screenSize;

  @override
  Widget build(BuildContext context) {

    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: new Text("App Admin"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => SearchData()
                        ));
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search),
                        SizedBox(height: 10.0,),
                        Text("Search Data"),

                      ],
                    ),

                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => AppUsers()
                      )
                    );
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_add),
                        SizedBox(height: 10.0,),
                        Text("App Users"),

                      ],
                    ),

                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => AppOrders()
                      )
                    );
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(height: 10.0,),
                        Text("App Orders"),

                      ],
                    ),

                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        //builder: (context) => AppMesages()
                        builder: (context) => RegisterStore()
                      )
                    );
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_box),
                        SizedBox(height: 10.0,),
                        Text("Register Store"),

                      ],
                    ),

                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => AppProducts()
                      )
                    );
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shop),
                        SizedBox(height: 10.0,),
                        Text("App Products"),

                      ],
                    ),

                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => AddProducts()
                      )
                    );
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        SizedBox(height: 10.0,),
                        Text("Add Products"),

                      ],
                    ),

                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){

                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.verified_user),
                        SizedBox(height: 10.0,),
                        Text("Users"),

                      ],
                    ),

                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => AddNews()
                      )
                    );
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.insert_drive_file),
                        SizedBox(height: 10.0,),
                        Text("Add News"),

                      ],
                    ),

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
