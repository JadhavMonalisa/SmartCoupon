import 'package:couponapp/auth.dart';
import 'package:couponapp/root_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AuthService.dart';
import 'home_page.dart';
import 'splashscreen.dart';

Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);

 /* if(email!=null){
    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
  }*/

 if(email!=null){
   runApp(MaterialApp(home: HomePage(),));
 }
 else
   {
     runApp(MaterialApp(home: email == null ? RootPage(auth: new Auth()) : Splashscreen()));
   }
//  runApp(MaterialApp(home: email == null ? RootPage(auth: new Auth()) : Splashscreen()));
}
