import 'package:clikcus/tools/app_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'itemsDetails.dart';

class fastLists2 extends StatefulWidget {
  var trending;
  var outStock;
  var newest;
  var soon;
  var discount;

  fastLists2({

    this.trending,
    this.outStock,
    this.newest,
    this.soon,
    this.discount,

  });

  @override
  _fastLists2State createState() => _fastLists2State();
}

class _fastLists2State extends State<fastLists2> {

  List imag = List();
  List imagC = List();

  @override
  void initState() {


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Listas Rapidas"
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
                  getCard("Lo mas vendido", widget.trending),
                  getCard("Nuevas adquisiciones", widget.newest),
                  getCard("Próximamente en ClickU", widget.soon),
                  getCard("Hora del ahorro, precios reducidos", widget.discount),

                ],
              ),
            ),
            SizedBox(height: 35.0,),
          ],
        ),
      ),
    );


  }

  Widget getCard(String listName, stateC){

    try{
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              side: BorderSide(width: 3, color: Colors.orange)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(listName,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(height: 15.0,),
                //getImageC2(context, widget.newest),
                getImageC2(context, stateC),
              ],
            ),
          ),
        ),
      );
    }catch (error){
      return Card();
    }




  }

  getImageC2(context, imag){
    
    return Container(
          height: MediaQuery.of(context).size.width * .6,
          child: Swiper(
            pagination: SwiperPagination(),
            autoplay: true,
            layout: SwiperLayout.DEFAULT,
            itemCount: imag.length,
            //itemCount: 2,
            itemBuilder: (context, index){
              return Image.network(
                imag[index][productImages][0],
                fit: BoxFit.cover,
              );
            },

            itemHeight: 300.0,
            itemWidth: MediaQuery.of(context).size.width,

            onTap: (index){

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

                  )
              ));



            },



          )
      );


  }

}

