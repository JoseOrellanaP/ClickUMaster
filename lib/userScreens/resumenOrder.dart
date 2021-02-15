import 'package:clikcus/tools/lauchSocialN.dart';
import 'package:flutter/material.dart';

class clicUOrderNow extends StatefulWidget {

  String itemName;
  String itemImage;
  String itemPrice;
  String itemSize;
  String itemColor;


  clicUOrderNow(
      this.itemName,
      this.itemImage,
      this.itemPrice,
      this.itemSize,
      this.itemColor,
      );

  @override
  _clicUOrderNowState createState() => _clicUOrderNowState();
}

class _clicUOrderNowState extends State<clicUOrderNow> {

  String messageC = "Hola quisiera coordinar la entrega de: ";

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  widget.itemName,
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
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
            SizedBox(height: 15.0,),
            Text(
              "USD ${widget.itemPrice}",
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.red[500],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0,),
            Text(
              "Coordinar la compra por:",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      color: Colors.green[900],
                      onPressed: () async{
                        lauchWhattsap(
                            number: "+593${widget.itemSize}",
                            message: "$messageC${widget.itemName}");
                      },
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage("assets/whatsapp_icon.png"),
                            width: 25.0,
                            height: 25.0,
                          ),
                          SizedBox(width: 5.0,),
                          Text("Whatsapp",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),),
                        ],
                      ),
                    ),
                    SizedBox(width: 25.0),
                    RaisedButton(
                      color: Colors.blue[500],
                      onPressed: () async{
                        print("ClickMe");
                        launchPhone(number: widget.itemSize);
                      },
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage("assets/call_icon.png"),
                            width: 25.0,
                            height: 25.0,
                          ),
                          SizedBox(width: 10.0,),
                          Text("Llamada",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      color: Colors.white,
                      onPressed: () async{
                        launchSMS(
                            number: widget.itemSize,
                            message: "$messageC${widget.itemName}");
                      },
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage("assets/sms_icon.png"),
                            width: 25.0,
                            height: 25.0,
                          ),
                          SizedBox(width: 10.0,),
                          Text("Mensaje",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),),
                        ],
                      ),
                    ),
                    SizedBox(width: 25.0),
                    RaisedButton(
                      color: Colors.red[600],
                      onPressed: () async{
                        launchEmail(
                            email: widget.itemColor,
                            message: "$messageC${widget.itemName}");
                      },
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage("assets/gmail_icon.png"),
                            width: 25.0,
                            height: 25.0,
                          ),
                          SizedBox(width: 10.0,),
                          Text("Email",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}
