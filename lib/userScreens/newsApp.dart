

import 'package:clikcus/tools/app_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class clickUnewsApp extends StatefulWidget {
  @override
  _clickUnewsAppState createState() => _clickUnewsAppState();
}

class _clickUnewsAppState extends State<clickUnewsApp> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Noticias"
          ),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: firestore.collection(articleNews).snapshots(),
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
              if(dataCount == 0){
                return noDataFound();
              }else{
                //return createList(dataCount, snapshot);
                return createList(dataCount, snapshot);
              }
            }
          },
        )
      );
  }

  createList(int dataCounts, AsyncSnapshot snapshot){


    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dataCounts,
              itemBuilder: (context, index){
                final DocumentSnapshot document =
                snapshot.data.docs[index];
                List productImage = document[productImages] as List;
                print("This is ${productImage[0]}");
                return Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 220.0,
                  width: double.maxFinite,
                  child: Card(
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(7),
                        child: Stack(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 10, top: 5),
                              child: Column(
                                children: [
                                  //todo [Index]
                                  GestureDetector(
                                  onTap: (){
                      _launchURL("${document[productDesc]}");
                      },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 130,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                alignment: Alignment(-.2, 0),
                                image: NetworkImage(
                                  "${productImage[0]}",
                                  //'http://www.naturerights.com/blog/wp-content/uploads/2017/12/Taranaki-NR-post-1170x550.png',
                                ),
                                fit: BoxFit.fill),
                          ),
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(bottom: 20),
                        ),
                      ),
                                  SizedBox(height: 20.0,),
                                  Text(
                                    "${document[productTitle]}",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                    //overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
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
              "Nothing here now",
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
}

_launchURL (String URL) async{

  if(await canLaunch(URL)){
    await launch(URL);
  }else{
    throw "Could not launch $URL";
  }

}
