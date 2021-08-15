import 'dart:io';

import 'package:clikcus/tools/app_data.dart';
import 'package:clikcus/tools/app_methods.dart';
import 'package:clikcus/tools/app_tools.dart';
import 'package:clikcus/tools/firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddNewStore extends StatefulWidget {

  @override
  _AddNewStoreState createState() => _AddNewStoreState();
}

class _AddNewStoreState extends State<AddNewStore> {


  List<File> imageList;

  TextEditingController storeName = TextEditingController();
  TextEditingController storePhoneNumber = TextEditingController();
  TextEditingController storeOwnerName = TextEditingController();
  TextEditingController storeLatitud = TextEditingController();
  TextEditingController storeLongitud = TextEditingController();


  final scaffolKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
            "Add Stores"
        ),
        elevation: 0.0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10.0,),
            Center(
                child: Text(
                  //widget.itemName,
                  "New Store",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white
                ),
                )
            ),
            SizedBox(height: 10.0,),
            productTextView(textTitle: "Local Name",
              textHint: "Enter a name",
              controller: storeName,
              textType: TextInputType.text,
            ),
            SizedBox(height: 10.0,),
            productTextView(textTitle: "Phone Local Number",
              textHint: "Enter a cellphone number",
              controller: storePhoneNumber,
              textType: TextInputType.phone,
            ),

            SizedBox(height: 10.0,),
            productTextView(textTitle: "Owner Local Name",
              textHint: "Enter a name",
              controller: storeOwnerName,
              textType: TextInputType.text,
            ),

            SizedBox(height: 10.0,),
            productTextView(textTitle: "Latitude",
              textHint: "Enter a Latitude",
              controller: storeLatitud,
              textType: TextInputType.numberWithOptions(decimal: true),
            ),

            SizedBox(height: 10.0,),
            productTextView(textTitle: "Longitude",
              textHint: "Enter a Longitude",
              controller: storeLongitud,
              textType: TextInputType.numberWithOptions(decimal: true),
            ),

            SizedBox(
              height: 20.0,
            ),

            appButton(
              btnText: "Add Store Location",
              onBtnClicked: addLocation,
              btnPadding: 20.0,
              btnColor: Theme.of(context).primaryColor
            ),

          ],
        ),
      ),
    );
  }


  AppMethods appMethods = new FirebaseMethods();

  addLocation() async{


    if(storeName.text == ""){
      showSnackBar("Fill all the info", scaffolKey);
      return;
    }

    if(storePhoneNumber.text == ""){
      showSnackBar("Fill all the info", scaffolKey);
      return;
    }


    if(storeLatitud.text == ""){
      showSnackBar("Fill all the info", scaffolKey);
      return;
    }

    if(storeLongitud.text == ""){
      showSnackBar("Fill all the info", scaffolKey);
      return;
    }

    if(storeOwnerName.text == ""){
      showSnackBar("Fill all the info", scaffolKey);
      return;
    }

    // show the progress dialog
    displayProgressDialog(context);

    // Get the text from the individual controllers


    Map<String, dynamic> newLocation = {
      storeName2: storeName.text,
      storePhoneNumber2: storePhoneNumber.text,
      storeOwnerName2: storeOwnerName.text,
      storeLatitude2: storeLatitud.text,
      storeLongitude2: storeLongitud.text,
    };


    // adding locations to firebase

    //String LocationID = await appMethods.addNewLocation(newLocation: newLocation);
    String storeId = await appMethods.addNewStoreL(newLocation: newLocation);



    if(storeId != null){
      closeProgressDialog(context);
      resetEverything();
      showSnackBar("Article Added Successfully", scaffolKey);
    }else{
      closeProgressDialog(context);
      showSnackBar("An Error Occurred", scaffolKey);
    }





  }

  void resetEverything() {

    storePhoneNumber.text = "";
    storeLatitud.text = "";
    storeOwnerName.text = "";
    storeLongitud.text = "";
    storeName.text = "";

    setState(() {

    });

  }

}
