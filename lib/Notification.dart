import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Message.dart';

class Notifications extends StatefulWidget{
  @override

  State<StatefulWidget> createState () => NotificationState();

}
class NotificationState extends State<Notifications>{

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String,dynamic>message) async{
        print("onMessage: $message ");
        final notification = message ['notifiction'];
        setState(() {
          messages.add(Message(
              title: notification['titile'],body: notification['body']
          ));
        });
      },
      onLaunch:  (Map<String,dynamic>message) async{
        print("onLaunch: $message ");
      },
      onResume:  (Map<String,dynamic>message) async{
        print("onResume: $message ");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true,badge: true,alert: true)
    );
    _firebaseMessaging.getToken().then((token) {
      print(token); // Print the Token in Console
    });
  }
  @override
  Widget build(BuildContext context) => ListView(
    children: messages.map(buildMessage).toList(),
  );
  Widget buildMessage(Message message) => ListTile(
    title: Text(message.title),
    subtitle: Text(message.body),
  );
}

