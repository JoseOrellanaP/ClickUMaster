import 'package:clikcus/adminScreens/add_Stores.dart';
import 'package:clikcus/adminScreens/edit_info.dart';
import 'package:clikcus/tools/app_data.dart';
import 'package:clikcus/tools/getQueries.dart';
import 'package:clikcus/userScreens/itemsDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppProducts extends StatefulWidget {
  @override
  _AppProductsState createState() => _AppProductsState();
}

class _AppProductsState extends State<AppProducts> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;




List<Map<String, dynamic>> _foundData = [];


//String filter = 'Laptops';
String filter = '';

bool dummy;



@override
void initState() {
    
    // At the beggining all users are show

    dummy = false;
    


    
  }


  void _runFilter(String valueEntered){
    if(valueEntered.isEmpty){
      filter = '';
    }else{
      filter = valueEntered;
    }

    // Refresh the UI
    setState(() {
      filter = valueEntered;
    });

  }

  

 






  @override
  Widget build(BuildContext context) {

    //_runFilter('Laptop');
    if(filter.isEmpty){
      _runFilter("Laptop");
    }




    getFilter(String filter){


      final CollectionReference noticeCollection=Firestore.instance.collection('appProducts');

      if(dummy == false){
        final Query unapproved = noticeCollection;
        dummy = true;
        return unapproved.snapshots();

      }else{
        final Query unapproved = noticeCollection.where(productTitle, isGreaterThanOrEqualTo: filter)
      .where(productTitle, isLessThan: filter + 'z');
        return unapproved.snapshots();

      }

      
    };


  

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "App Products"
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [



          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                labelText: "Search",
                suffixIcon: Icon(Icons.search),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),






          Expanded(
            child: StreamBuilder(
                //stream: firestore.collection(appProducts).snapshots(),
                //stream: unapproved.snapshots(),
                stream: getFilter(filter),
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
          ),
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

    List productImage = document[productImages] as List;
    print(productImage[0]);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: width * .25,
                    child: Image(
                      image: NetworkImage(
                          productImage[0]
                      ),
                    )
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text(
                      "${document[productTitle]}",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                      ),
                      overflow: TextOverflow.ellipsis,
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
                    SizedBox(height: 10,),
                  ],
                ),
              ],
            ),
            SizedBox(width: 36,),
            GestureDetector(
                onTap: () async{

                  List storeList = List();

                  List<Map<dynamic, dynamic>> store = await getDataFireBase().getStores();

                  for (int i = 0; i < store.length; i++) {
                    storeList.add(store[i][storeName2]);
                  }




                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddStores(
                        itemName: document[productTitle],
                        storeList: storeList,
                      )
                  ));
                },
                child: Icon(Icons.add_location)
            ),
            SizedBox(width: 15.0,),
            GestureDetector(
                onTap: ()async{

                  Map mapData = await getDataFireBase().getIdInfo(document.id);
                  //print(document.id);


                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => editInfo(
                        itemMap: mapData,
                        itemId: document.id,
                      )
                  ));






                },
                child: Icon(Icons.edit)
            )
          ],
        ),
      ),
    );

  }

}
