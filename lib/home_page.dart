import 'package:couponapp/root_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';
import 'main.dart';
import 'slider.dart';
import 'slider_listview.dart';
import 'about_us.dart';
import 'login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'listView.dart';

class DrawerItem {
  String title;
  IconData icon;
  Color color;

  DrawerItem(this.title, this.icon, this.color);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Home", Icons.home, Colors.green),
    new DrawerItem("About Us", Icons.person, Colors.black),
    new DrawerItem('Logout', Icons.exit_to_app, Colors.blue),
  ];

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  int selectedDrawerIndex = 0;
  bool backStatus = false;

  Future<bool> _warnUserAboutInvalidData() async {
    // final FormState form = _formKey.currentState;
    if (backStatus == false) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (BuildContext context) => HomePage()));

      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));

      return true;
    }

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Are you going to exit the application?'),
              actions: <Widget>[
                new FlatButton(
                  child: const Text('YES'),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
                new FlatButton(
                  child: const Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

/*

  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
    */
/*Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));*/ /*

  }
*/

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
  }

  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        backStatus = true;
        return new SliderImages();
      case 1:
        backStatus = false;
        return new AboutUs();
      //backStatus=false;

      case 2:
         logout();
         break;

      default:
        new Text('ERROR');
    }
  }

  onSelectItem(int index) {
    setState(() => selectedDrawerIndex = index);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    //Fluttertoast.showToast(msg: 'Login Successfully');
    var drawerOptions = <Widget>[];

    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(InkWell(
        child: ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == selectedDrawerIndex,
          onTap: () => onSelectItem(i),
        ),
      ));
    }
    return WillPopScope(
      onWillPop: _warnUserAboutInvalidData,
      child: new Scaffold(
        backgroundColor: Colors.grey,
        appBar: new AppBar(
          title: new Text('Coupons'),
          backgroundColor: Colors.blue,
        ),
        drawer: Drawer(
          //width: MediaQuery.of(context).size.width*65,
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text(
                  'Welcome',
                  style: TextStyle(color: Colors.white),
                ),
                accountEmail: new Text(
                  "${user?.email}",
                  style: TextStyle(color: Colors.white),
                ),
                decoration: new BoxDecoration(
                  color: Colors.blue,
                ),
                //currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/46.jpg'),),
              ),
              new Column(children: drawerOptions),
            ],
          ),
        ),
        body: getDrawerItemWidget(selectedDrawerIndex),
      ),
    );
    // TODO: implement build
  }
  Future logout()  async {
    selectedDrawerIndex=null;
    Fluttertoast.showToast(msg: 'Logged out Successfully');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    //SystemNavigator.pop();
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RootPage(auth: new Auth()),
      ),

      // this function should return true when we're done removing routes
      // but because we want to remove all other screens, we make it
      // always return false

    );
  }
}


/*
return new AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('You want to logout?'),
        actions: <Widget>[
          new FlatButton(
            child: const Text('YES'),
            onPressed: () {
              Fluttertoast.showToast(msg: 'Logged out Successfully');
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email');
              SystemNavigator.pop();
            },
          ),
          new FlatButton(
            child: const Text('NO'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      ); */

