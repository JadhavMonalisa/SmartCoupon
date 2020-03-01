import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'auth.dart';

class RootPage extends StatefulWidget
{
  final BaseAuth auth;

  RootPage({this.auth});

  @override
  State<StatefulWidget> createState()=>new _RootPageState();

    // TODO: implement createState
}
enum AuthStatus{
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage>{

  AuthStatus _authStatus=AuthStatus.notSignedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.currentState().then((userId){
        setState(() {
          //_authStatus=userId==null? AuthStatus.notSignedIn : AuthStatus.signedIn;
        });
    });
  }

  void _signedIn(){
    setState(() {
      _authStatus=AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context){

    switch (_authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );

      case AuthStatus.signedIn:
        return show();
        // TODO: Handle this case.
        break;
    }
    // TODO: implement build
   // return new LoginPage(auth:widget.auth);
  }

  show()
  {
    print('Status=$_authStatus');
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
  }
}