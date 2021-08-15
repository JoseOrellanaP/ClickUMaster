import 'dart:io';

import 'package:clikcus/tools/app_data.dart';
import 'package:clikcus/tools/app_methods.dart';
import 'package:clikcus/tools/app_tools.dart';
import 'package:clikcus/tools/firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class editInfo extends StatefulWidget {

  Map itemMap;
  String itemId;

  editInfo({
    this.itemMap,
    this.itemId,
  });

  @override
  _editInfoState createState() => _editInfoState();
}

class _editInfoState extends State<editInfo> {


  List<DropdownMenuItem<String>> dropDownMenuState;
  String selectedState;
  List<String> stateList = new List();



  TextEditingController priceField = TextEditingController();
  TextEditingController titleField = TextEditingController();





  final scaffolKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    stateList = new List.from(productMode);
    dropDownMenuState = buildAndGetDropDownItems(stateList);
    selectedState = widget.itemMap[productState];

    String price = widget.itemMap[productPrice];
    priceField = TextEditingController(text: price);

    String title = widget.itemMap[productTitle];
    titleField = TextEditingController(text: title);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
            "Edit Info"
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
                child: Text(widget.itemMap[productTitle],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white
                ),
                )
            ),

            SizedBox(height: 10.0,),
            productTextView(textTitle: "Title",
              textHint: "Enter a title",
              controller: titleField,
            ),
            SizedBox(height: 10.0,),
            productTextView(textTitle: "Price",
              textHint: "Enter a price number",
              controller: priceField,
              textType: TextInputType.number,
            ),
            SizedBox(height: 10.0,),
            productDropDown(
              textTitle: "State",
              selectedItem: selectedState,
              dropDownCategories: dropDownMenuState,
              changedDropDownCategory: changeDropDownState,
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


    String itemId = widget.itemId;

    widget.itemMap[productState] = selectedState;
    widget.itemMap[productPrice] = priceField.text;
    widget.itemMap[productTitle] = titleField.text;

    // show the progress dialog
    displayProgressDialog(context);

    // Get the text from the individual controllers

    Map<String, dynamic> updateProductInfo = {
      productState: widget.itemMap[productState],
      productPrice: widget.itemMap[productPrice],
      productTitle: widget.itemMap[productTitle],

    };


    // adding locations to firebase
    //String LocationID = await appMethods.addNewLocation(updateProductInfo: updateProductInfo);
    String LocationID = await appMethods.updateData(newDataP: updateProductInfo,id: itemId);




    if(LocationID != null){
      closeProgressDialog(context);
      resetEverything();
      showSnackBar("Article Added Successfully", scaffolKey);
    }else{
      closeProgressDialog(context);
      showSnackBar("Guardado", scaffolKey);
    }







    
    
    
    


  }

  void changeDropDownState(String selectedSt){
    setState(() {
      selectedState = selectedSt;
      print(selectedState);
    });
  }

  void resetEverything() {

    priceField.text = "";

    setState(() {

    });

  }

}
