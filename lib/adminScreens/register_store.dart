import 'package:clikcus/adminScreens/add_New_Store.dart';
import 'package:clikcus/tools/app_data.dart';
import 'package:clikcus/tools/getQueries.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterStore extends StatefulWidget {
  @override
  _RegisterStoreState createState() => _RegisterStoreState();
}

class _RegisterStoreState extends State<RegisterStore> {


  FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Stores"
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: ()async{



                toAddStore(context);


              },
              child: Icon(
                Icons.add,
                size: 26.0,
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder(
          stream: firestore.collection(storesList).snapshots(),
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
                return createList(dataCount, snapshot);
              }


            }

          }),
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
              "Not Store available yet",
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
            SizedBox(
              height: 10.0,
            ),

          ],
        ),
      ),
    );
  }

  toAddStore(context){
    Navigator.of(context).push(
        CupertinoPageRoute(
            builder: (context) => AddNewStore(
            )
        )
    );
  }

  createList(int dataCount, AsyncSnapshot snapshot){
    return ListView.builder(


      itemCount: dataCount,
      itemBuilder: (context, index){
        final DocumentSnapshot document =
        snapshot.data.docs[index];
        return buildProducts2(context, index, document);
      },




    );
  }

  Widget buildProducts2(BuildContext context, int index, DocumentSnapshot document) {

    //List productImage = document[productImages] as List;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        "${document[storeName2]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.0,),
                      Text(
                        //"USD ${document[productPrice]}",
                        "${document[storeOwnerName2]}",
                        style: TextStyle(
                          color: Colors.red[500],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 36,),
            ],
          ),
        ),
      ),
    );

  }


}
