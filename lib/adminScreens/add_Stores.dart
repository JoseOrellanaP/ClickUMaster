import 'dart:io';

import 'package:clikcus/tools/app_data.dart';
import 'package:clikcus/tools/app_methods.dart';
import 'package:clikcus/tools/app_tools.dart';
import 'package:clikcus/tools/firebase_methods.dart';
import 'package:clikcus/tools/getQueries.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddStores extends StatefulWidget {

  String itemName;
  List storeList;

  AddStores({
    this.itemName,
    this.storeList,

  });

  @override
  _AddStoresState createState() => _AddStoresState();
}

class _AddStoresState extends State<AddStores> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  List<DropdownMenuItem<String>> dropDownMenuState;
  String selectedState;
  List<String> stateList = new List();

  List<File> imageList;

  TextEditingController storePhoneNumber = TextEditingController();
  TextEditingController storeOwnerName = TextEditingController();
  TextEditingController storeLatitud = TextEditingController();
  TextEditingController storeLongitud = TextEditingController();


  final scaffolKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();


    stateList = new List.from(widget.storeList);
    dropDownMenuState = buildAndGetDropDownItems(stateList);
    selectedState = widget.storeList[0];

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
                child: Text(widget.itemName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white
                ),
                )
            ),
            SizedBox(height: 10.0,),

            productDropDown(
              textTitle: "Store",
              selectedItem: selectedState,
              dropDownCategories: dropDownMenuState,
              changedDropDownCategory: changeDropDownState,
            ),

            SizedBox(height: 10.0,),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text(
                    'Search'
                  ),
                  onPressed: ()async{

                    List<Map<dynamic, dynamic>> storeList = await getDataFireBase().getSpecificStores(selectedState);
                    print(storeList[0][storePhoneNumber2]);
                    storePhoneNumber.text = storeList[0][storePhoneNumber2];
                    storeOwnerName.text = storeList[0][storeOwnerName2];
                    storeLatitud.text = storeList[0][storeLatitude2];
                    storeLongitud.text = storeList[0][storeLongitude2];


                  },
                ),
              ),
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

  void changeDropDownState(String selectedSt){
    setState(() {
      selectedState = selectedSt;
      print(selectedState);
    });
  }

  AppMethods appMethods = new FirebaseMethods();

  addLocation() async{


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
      productTitle: widget.itemName,
      storePhoneNumber2: storePhoneNumber.text,
      storeOwnerName2: storeOwnerName.text,
      storeLatitude2: storeLatitud.text,
      storeLongitude2: storeLongitud.text,
    };


    // adding locations to firebase
    String LocationID = await appMethods.addNewLocation(newLocation: newLocation);



    if(LocationID != null){
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

    setState(() {

    });

  }

}
