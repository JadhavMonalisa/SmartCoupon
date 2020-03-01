import 'package:flutter/material.dart';

import 'home_page.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}
class _AboutUsState extends State<AboutUs> {

  Future<bool> _onWillPop() {

    //Navigator.of(context).pop(true);
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }

  @override
  Widget build(BuildContext context){
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
    body: ListView(
      children: <Widget>[
        Card(
          child: GridTile(child: Image.asset('images/aboutUs.jpg'),),
        ),
        Card(
          child: ListTile(
            title: Text('About Us'),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('   We have store information where discount is offered. '
                  'Store information like location of that store, and we provide facility to '
                  'send details of discount offer on whatsApp. We list all these discount coupons.'
                  'We have active offers and coupons from various shops.'),
            ),
            ),
        ),

        Divider(),
        Card(
          child:Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(Icons.email, color: Colors.blue,),
                  ),Divider(),
                  Text('help@unitglo.com'),
                ],
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(Icons.call, color: Colors.green,),
                  ),
                  Text('+91 9999999999'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
    ),
    );
  }
}
