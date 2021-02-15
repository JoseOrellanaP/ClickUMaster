import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


void lauchWhattsap({number, message}) async{

  //String url = "whatsapp://send?phone=$number&message=$message";
  String url = "https://wa.me/${number}?text=$message";
  await canLaunch(url) ? launch(url) : print("Can't open whatsapp");

}

void launchSMS({number, message}) async {


  String url = "sms:$number?body=$message";
  await canLaunch(url) ? launch(url) : print("Can't open whatsapp");


}

void launchEmail({email, message}) async{

  String url = "mailto:$email?subject=Comprar&body=$message";
  await canLaunch(url) ? launch(url) : print("Can't open whatsapp");

}

void launchPhone({number}) async{

  String url = "tel: $number";
  await canLaunch(url) ? launch(url) : print("Can't open whatsapp");

}