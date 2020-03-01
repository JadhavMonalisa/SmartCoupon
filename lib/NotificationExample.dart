import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationExample extends StatefulWidget {
  @override
  _NotificationExampleState createState() => _NotificationExampleState();
}

class _NotificationExampleState extends State<NotificationExample> {

  String textValue='Hello';
  final FirebaseMessaging _messaging=FirebaseMessaging();

   @override
   void initState(){

     _messaging.configure(
       onLaunch: (Map<String,dynamic>msg){
         print("OnLaunch called");
       },
         onResume: (Map<String,dynamic>msg){
           print("OnResume called");
         },
         onMessage: (Map<String,dynamic>msg){
           print("OnMessage called");
         }
         
     );

     _messaging.requestNotificationPermissions(
       const IosNotificationSettings(
         sound: true,
         alert: true,
         badge: true
       )
     );

     _messaging.onIosSettingsRegistered.listen((IosNotificationSettings setting){
        print("IOS setting generated");
     });

     _messaging.getToken().then((token){
       //print(token);
       update(token);
     });
   }

  update(String token) {
     print(token);
     textValue=token;
     setState(() {

     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Push Notification'),
      ),
      body: Center(
        child: Text(textValue),
      ),

    );
  }
}
