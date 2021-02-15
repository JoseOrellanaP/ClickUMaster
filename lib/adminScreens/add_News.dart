import 'dart:io';

import 'package:clikcus/tools/app_data.dart';
import 'package:clikcus/tools/app_methods.dart';
import 'package:clikcus/tools/app_tools.dart';
import 'package:clikcus/tools/firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddNews extends StatefulWidget {
  @override
  _AddNewsState createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {

  List<File> imageList;

  TextEditingController articleTitleController = TextEditingController();
  TextEditingController articleLinkController = TextEditingController();

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
            "Add News"
        ),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton.icon(
              color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0)
                )
              ),
              onPressed: () => pickImage(),
              icon: Icon(Icons.add, color: Colors.white,),
              label: Text("Add image",
              style: TextStyle(
                color: Colors.white
              ),),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(height: 10.0,),
            MultiImagePickerList(
              imageList: imageList,
              removeNewImage: (index){
                removeImage(index);
              }
            ),
            SizedBox(height: 10.0,),
            productTextView(textTitle: "Article Title",
                            textHint: "Enter Article Title",
                            controller: articleTitleController
                            ),
            SizedBox(height: 10.0,),
            productTextView(textTitle: "Article Link",
              textHint: "Enter the Article Link",
              height: 180,
              maxLines: 40,
              controller: articleLinkController,
              textType: TextInputType.multiline
            ),
            SizedBox(
              height: 20.0,
            ),
            appButton(
              btnText: "Add News",
              onBtnClicked: addNewProducts,
              btnPadding: 20.0,
              btnColor: Theme.of(context).primaryColor
            ),

          ],
        ),
      ),
    );
  }

  pickImage() async{
    File file = await ImagePicker.pickImage(source: ImageSource.gallery,
    maxWidth: 800.0,
    maxHeight: 400.0);
    if(file != null){
      List<File> imageFile = new List();
      imageFile.add(file);
      if(imageList == null){
        imageList = List.from(imageFile, growable: true);
      }else{
        for(int s = 0; s< imageFile.length; s++){
          imageList.add(file);
        }
      }
      setState(() {

      });
    }
  }

  removeImage(int index) async{
    imageList.removeAt(index);
    setState(() {

    });
  }

  AppMethods appMethods = new FirebaseMethods();

  addNewProducts() async{
    
    if(imageList == null || imageList.isEmpty){
      showSnackBar("Product Images cannot be empty", scaffolKey);
      return;
    }
    
    if(articleTitleController.text == ""){
      showSnackBar("Article title cannot be empty", scaffolKey);
      return;
    }


    if(articleLinkController.text == ""){
      showSnackBar("Article link cannot be empty", scaffolKey);
      return;
    }

    // show the progress dialog
    displayProgressDialog(context);

    // Get the text from the individual controllers title, price, description
    Map<String, dynamic> newArticle = {
      productTitle: articleTitleController.text,
      productDesc: articleLinkController.text,
    };

    // adding the information to firebase
    String productID = await appMethods.addNewArticle(newArticle: newArticle);

    // time to upload images to firebase storage
    List<String> imagesURL = await appMethods.uploadArticleImages(
      docID: productID,
      imageList: imageList,
    );

    // check if an error occurred while adding the images
    if(imagesURL.contains(error)){
      closeProgressDialog(context);
      showSnackBar("Image Upload Error", scaffolKey);
      return;
    }

    // update the information after uploading image file to the storage
    bool result = await appMethods.updateArticleImages(docID: productID, data: imagesURL);

    if(result != null && result == true){
      closeProgressDialog(context);
      resetEverything();
      showSnackBar("Article Added Successfully", scaffolKey);
    }else{
      closeProgressDialog(context);
      showSnackBar("An Error Occurred", scaffolKey);
    }

  }

  void resetEverything() {

    imageList.clear();
    articleTitleController.text = "";
    articleLinkController.text = "";

    setState(() {

    });

  }

}
