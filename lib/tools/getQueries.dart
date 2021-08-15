

import 'package:clikcus/tools/firebase_methods.dart';
import "package:cloud_firestore/cloud_firestore.dart";

import 'app_data.dart';

class getDataFireBase{

  getDataFireBaseData(String storeLocation, String field){
    return Firestore.instance
        .collection(storeLocation)
        .where("ProductTitle", isEqualTo: field)
        .getDocuments();
  }

  getDataFireListState(String appProducts, String state){
    return Firestore.instance
        .collection(appProducts)
        .where("ProductState", isEqualTo: state)
        .getDocuments();
  }

  getAllDataFire(String appProducts){
    return Firestore.instance
        .collection(appProducts)
        .getDocuments();
  }


  getAllDataFire2(String appProducts, String state){
    return Firestore.instance
        .collection(appProducts)
        .where("ProductState", isEqualTo: state)
        .getDocuments().then((QuerySnapshot docs){
      if(docs.docs.isNotEmpty){
        for (int i = 0; i<docs.docs.length; i++){
          docs.docs[i].data();
        }
      }
    });
  }

  getTest(String appProducts, String state){
    return Firestore.instance
        .collection(appProducts)
        .where("ProductState", isEqualTo: state)
        .getDocuments();
  }



  getUsers2(String state) async{

    final usersRef = FirebaseFirestore.instance.collection(appProducts);

    var mapE = <Map> [];

    final QuerySnapshot docs = await usersRef.where("ProductState", isEqualTo: state).getDocuments();

    if(docs.docs.isNotEmpty) {
      for (int i = 0; i < docs.docs.length; i++) {

        mapE.add({
          productTitle:docs.docs[i].get(productTitle),
          productPrice: docs.docs[i].get(productPrice),
          productImages: docs.docs[i].get(productImages),

          productCat: docs.docs[i].get(productCat),
          productPrice: docs.docs[i].get(productPrice),
          productSize: docs.docs[i].get(productSize),
          productColor: docs.docs[i].get(productColor),
          productDesc: docs.docs[i].get(productDesc),
          productSeller: docs.docs[i].get(productSeller),
          productState: docs.docs[i].get(productState),


        });
      }
      return mapE;
    }
  }



  getStores() async{

    final usersRef = FirebaseFirestore.instance.collection(storesList);

    var mapE = <Map> [];

    final QuerySnapshot docs = await usersRef.getDocuments();

    if(docs.docs.isNotEmpty) {
      for (int i = 0; i < docs.docs.length; i++) {

        mapE.add({
          storeName2:docs.docs[i].get(storeName2),
        });
      }
      return mapE;
    }
  }

  getSpecificStores(String store) async{

    final usersRef = FirebaseFirestore.instance.collection(storesList);

    var mapE = <Map> [];

    //final QuerySnapshot docs = await usersRef.getDocuments();
    final QuerySnapshot docs = await usersRef.where("StoreName", isEqualTo: store).getDocuments();

    if(docs.docs.isNotEmpty) {
      for (int i = 0; i < docs.docs.length; i++) {

        mapE.add({
          storeName2:docs.docs[i].get(storeName2),
          storePhoneNumber2: docs.docs[i].get(storePhoneNumber2),
          storeOwnerName2: docs.docs[i].get(storeOwnerName2),
          storeLongitude2: docs.docs[i].get(storeLongitude2),
          storeLatitude2: docs.docs[i].get(storeLatitude2),

        });
      }
      return mapE;
    }
  }



  getIdInfo(id) async{


    var doc = await Firestore.instance.collection(appProducts).doc(id).get();


    return doc.data();




  }



}