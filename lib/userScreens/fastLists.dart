import 'package:clikcus/tools/app_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'itemsDetails.dart';

class fastLists extends StatefulWidget {

  List imageList;
  List titleList;
  List listCategory;
  List listPrices;
  List listSizes;
  List listColor;
  List listDesc;
  List listSeller;
  List listState;


  fastLists({
    this.imageList,
    this.titleList,
    this.listCategory,
    this.listPrices,
    this.listSizes,
    this.listColor,
    this.listDesc,
    this.listSeller,
    this.listState
  });

  @override
  _fastListsState createState() => _fastListsState();
}

class _fastListsState extends State<fastLists> {

  List imag = List();
  List imagC = List();

  @override
  void initState() {


    for (int i = 0; i<widget.imageList.length; i++){
      imag.add(NetworkImage(widget.imageList[i][0]));
      imagC.add((widget.imageList[i]));
    }


  }



  @override
  Widget build(BuildContext context) {

    Widget imageC = new Container(
        height: MediaQuery.of(context).size.width * .6,
        child: Swiper(
          pagination: SwiperPagination(),
          autoplay: true,
          layout: SwiperLayout.DEFAULT,
          itemCount: imag.length,
          itemBuilder: (context, index){
            return Image.network(
              widget.imageList[index][0],
              fit: BoxFit.cover,
            );
          },
          itemHeight: 300.0,
          itemWidth: MediaQuery.of(context).size.width,

          onTap: (index){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => itemDetail(

                  itemImage: widget.imageList[index][0].toString(),
                  itemImages: widget.imageList[index] as List,
                  itemName: widget.titleList[index],
                  itemSubname: widget.listCategory[index],
                  itemPrice: widget.listPrices[index],
                  itemSize: widget.listSizes[index],
                  itemColor: widget.listColor[index],
                  itemDescription: widget.listDesc[index],
                  itemSeller: widget.listSeller[index],
                  itemState: widget.listState[index],

                )
            ));






          },



        )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "List"
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        side: BorderSide(width: 3, color: Colors.orange)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Los mas vendidos",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),),
                          SizedBox(height: 15.0,),
                          imageC,
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        side: BorderSide(width: 3, color: Colors.orange)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Lo mas nuevo",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),),
                          SizedBox(height: 15.0,),
                          imageC,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35.0,),
          ],
        ),
      ),
    );
  }


}
