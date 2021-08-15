
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clikcus/userScreens/resumenOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


import 'cart.dart';
import 'map.dart';

class itemDetail extends StatefulWidget {

  String itemName;
  String itemImage;
  String itemSubname;
  String itemDescription;
  List itemImages;
  String itemPrice;
  String itemSize;
  String itemColor;
  double itemRating;
  String itemSeller;
  String itemState;

  itemDetail({
    this.itemSubname,
    this.itemPrice,
    this.itemDescription,
    this.itemImages,
    this.itemName,
    this.itemImage,
    this.itemSize,
    this.itemColor,
    this.itemRating,
    this.itemSeller,
    this.itemState,
  });

  @override
  _itemDetailState createState() => _itemDetailState();
}

class _itemDetailState extends State<itemDetail> {

  List imag = List();

  @override
  void initState() {

    //print("The print is ${widget.itemImages[1]}");
    for (int i = 0; i<widget.itemImages.length; i++){
      imag.add(NetworkImage(widget.itemImages[i]));
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
            widget.itemImages[index],
            fit: BoxFit.cover,
          );
        },
        itemHeight: 300.0,
        itemWidth: MediaQuery.of(context).size.width,
        onTap: (index){
          List imagesI = widget.itemImages;
          showDialogFunc(context, imagesI[index]);
        },
      )
    );



    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Item Details"
        ),
        centerTitle: false,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[

                //Calling widget Creator
                imageC,

                SizedBox(
                  height: 15.0,
                ),

                Card(
                  child: Container(
                    width: screenSize.width,
                    margin: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          widget.itemName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        Text(
                          "USD ${widget.itemPrice}",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        setText(widget.itemState),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    width: screenSize.width,
                    margin: EdgeInsets.only(left: 20.0,  right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "Categoria: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0
                              ),
                            ),
                            Text(
                              widget.itemSubname,
                              style: TextStyle(
                                  fontSize: 14.0
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Vendedor: ",
                                  style: TextStyle(
                                      color: Colors.black,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "${widget.itemSeller}",
                                  style: TextStyle(
                                      color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    width: screenSize.width,
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Text(
                          widget.itemDescription,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(height: 10.0,),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    width: screenSize.width,
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /*
                        new SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Colors",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        SizedBox(
                          height: 50.0,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ChoiceChip(
                                    label: Text(
                                        "Color $index"
                                    ),
                                    selected: false,
                                  ),
                                );
                              }
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Sizes",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 50.0,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ChoiceChip(
                                    label: Text("Size $index"),
                                    selected: false,
                                  ),
                                );
                              }
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Sizes",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircleAvatar(
                              child: Icon(Icons.remove),
                            ),
                            Text("0"),
                            CircleAvatar(
                              child: Icon(Icons.add),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50.0,
                        )
                         */


                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),






      /*
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        elevation: 00.0,
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: (screenSize.width-20) / 2,
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => clicUOrderNow(
                            widget.itemName,
                          widget.itemImage,
                          widget.itemPrice,
                          widget.itemSize,
                          widget.itemColor,
                        )
                    ));
                  },
                  child: Text(
                    "Comprar",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                      fontSize: 20.0
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      */

      floatingActionButton: Container(
        width: 70.0,
        height: 70.0,
        child: FloatingActionButton(
          elevation: 00.0,
          backgroundColor: Colors.white.withOpacity(.1),
          onPressed: (){

            if(widget.itemState == "Agotado"){
              AwesomeDialog(
                  context: context,
                  headerAnimationLoop: true,
                  animType: AnimType.BOTTOMSLIDE,
                  title: 'Agotado',
                  desc: "Lo sentimos, por ahora el producto esta agotado",
              ).show();
            }else if(widget.itemState == "Proximamente"){
              AwesomeDialog(
                context: context,
                headerAnimationLoop: true,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Próximamente',
                desc: "Espéralo, ya mismo llega",
              ).show();
            }
            else{
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => clicUOrderNow(
                    widget.itemName,
                    widget.itemImage,
                    widget.itemPrice,
                    widget.itemSize,
                    widget.itemColor,
                  )
              ));
            }



          },
          child: Container(
            child: Image(image: AssetImage("assets/Logo11.png"),
            color: Colors.deepOrange,
            ),
          ),
        ),
      ),
    );
  }


  setText(String state){


    if(state=="Agotado"){
      return Text(
        state,
        style: TextStyle(
          color: Colors.red,
          fontSize: 25.0,
          fontWeight: FontWeight.bold
        ),
      );
    }else{
      return Text(
        state,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.0,
        ),
      );
    }



  }

  showDialogFunc(context, itemImage) {
    return showDialog(
        context: context,
      builder: (context){
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                height: 320,
                width: MediaQuery.of(context).size.width *.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        itemImage,
                        width: MediaQuery.of(context).size.width,
                        height: 280,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      }
    );
  }


}
