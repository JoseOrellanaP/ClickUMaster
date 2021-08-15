import 'package:clikcus/tools/app_data.dart';
import 'package:clikcus/tools/getQueries.dart';
import 'package:clikcus/tools/lauchSocialN.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map.dart';

class clickURetiro extends StatefulWidget {

  String itemName;



  clickURetiro(
      this.itemName,
      );

  @override
  _clickURetiroState createState() => _clickURetiroState();
}

class _clickURetiroState extends State<clickURetiro> {



  String messageC = "Hola quisiera coordinar el retiro de: ";



  @override
  Widget build(BuildContext context) {

    int division = 8;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Resumen de la orden"
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          widget.itemImage
                      ),
                      fit: BoxFit.fitHeight
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(120.0),
                    bottomLeft: Radius.circular(120.0),
                  )
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  widget.itemName,
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Text(
              "USD ${widget.itemPrice}",
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 50.0,),
            Text(
              "Coordinar la compra con el vendedor por:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 35.0),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    RaisedButton(
                      onPressed: (){
                        lauchWhattsap(
                        number: "+593${widget.itemSize}",
                        message: "$messageC${widget.itemName}");
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      color: Colors.green[900],
                      child: Column(
                        children: [
                          Image.asset("assets/whatsapp_icon.png",
                          width: MediaQuery.of(context).size.width /division,),
                          SizedBox(height: 5.0,),
                          Text("Whatsapp",
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 5.0,),

                        ],
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    RaisedButton(

                      onPressed: (){
                        launchPhone(number: widget.itemSize);
                      },
                      color: Colors.blue[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Image.asset("assets/call_icon.png",
                            width: MediaQuery.of(context).size.width /division,),
                          SizedBox(height: 5.0,),
                          Text("Llamada",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),),
                          SizedBox(height: 5.0,),

                        ],
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    RaisedButton(

                      onPressed: (){
                        launchSMS(
                            number: widget.itemSize,
                            message: "$messageC${widget.itemName}");
                      },
                      color: Colors.white60,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Image.asset("assets/sms_icon.png",
                            width: MediaQuery.of(context).size.width /division,),
                          SizedBox(height: 5.0,),
                          Text("Mensaje",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),),
                          SizedBox(height: 5.0,),

                        ],
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    RaisedButton(

                      onPressed: (){
                        launchEmail(
                            email: widget.itemColor,
                            message: "$messageC${widget.itemName}");
                      },
                      color: Colors.red[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Image.asset("assets/gmail_icon.png",
                            width: MediaQuery.of(context).size.width /division,),
                          SizedBox(height: 5.0,),
                          Text("Email",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                          SizedBox(height: 5.0,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 55.0),

          ],
        ),
      ),
    );
  }


}
