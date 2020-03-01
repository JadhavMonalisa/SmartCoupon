import 'package:couponapp/slider_images.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'Notification.dart';
import 'NotificationExample.dart';
import 'about_us.dart';
import 'coupon_list.dart';
import 'home_page.dart';
import 'listView.dart';
import 'slider_listview.dart';
import 'login_page.dart';
import 'root_page.dart';
import 'slider.dart';

void main(){
  runApp(MaterialApp(
    //home: NotificationExample(),
    //home: HomePage(),
   home: LoginPage(),
  ));
}
class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}
class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
        (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(image: AssetImage('images/download_2.jpg'),),
      ),
    );
  }
}
