import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';
import 'home_page.dart';
import 'slider_listview.dart';


class LoginPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  LoginPage({this.auth,this.onSignedIn});

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType{
  login,
  register
}
class _LoginPageState extends State<LoginPage> {

  final formKey=new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType=FormType.login;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  bool validateAndSave(){
    final form=formKey.currentState;

    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async{

    /*_scaffoldKey.currentState.showSnackBar(
        new SnackBar(duration: new Duration(seconds: 4), content:
        new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text("  Login...")
          ],
        ),
        ));*/
    if(validateAndSave()) {
      try{
        //FirebaseUser user=FirebaseAuth.instance.currentUser() as FirebaseUser;
        if(_formType==FormType.login){

          _scaffoldKey.currentState.showSnackBar(
              new SnackBar(duration: new Duration(seconds: 4), content:
              new Row(
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Text("  Login...")
                ],
              ),
              ));
          String userId=await widget.auth.signInWithEmailAndPassword(_email,_password);
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

          //FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
          print('Signed in: ${userId}');
          //print('Email: ${user.email}');

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', _email);
          //Navigator.pop(context);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext ctx) => HomePage()));
        }
        else
        {
          _scaffoldKey.currentState.showSnackBar(
              new SnackBar(duration: new Duration(seconds: 4), content:
              new Row(
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Text("  Register...")
                ],
              ),
              ));
          String userId=await widget.auth.createUserWithEmailAndPassword(_email,_password);
          //FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
          print('Registered User: ${userId}');

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', _email);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext ctx) => HomePage()));
        }
        //widget.onSignedIn;
      } catch(e){
        print("Sign In Error: $e");
        String exception = getExceptionText(e);
        Flushbar(
          title: "Sign In Error",
          message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    }
  }

 /* void validateAndSubmitRegistration() async{

    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(duration: new Duration(seconds: 4), content:
        new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text("  Register...")
          ],
        ),
        ));

    if(validateAndSave()) {
      try{
        FirebaseUser user=FirebaseAuth.instance.currentUser() as FirebaseUser;

        String userId=await widget.auth.createUserWithEmailAndPassword(_email,_password);
        //FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
        print('Registered User: ${userId}');

        //add to go to homepage
        userId=await widget.auth.signInWithEmailAndPassword(_email,_password);
        Navigator.pop(context);
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', _email);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext ctx) => HomePage()));
        *//*if(_formType==FormType.login){

          String userId=await widget.auth.signInWithEmailAndPassword(_email,_password);
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

          //FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
          print('Signed in: ${userId}');
          //print('Email: ${user.email}');

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', _email);

          *//**//*if(_email!=null){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext ctx) => HomePage()));
          }*//**//*
          //Navigator.pop(context);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext ctx) => HomePage()));
        }
        else
        {
          String userId=await widget.auth.createUserWithEmailAndPassword(_email,_password);
          //FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
          print('Registered User: ${userId}');

          //add to go to homepage
          userId=await widget.auth.signInWithEmailAndPassword(_email,_password);
          Navigator.pop(context);
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', _email);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext ctx) => HomePage()));
        }
*//*        //widget.onSignedIn;
      } catch(e){
        print("Sign In Error: $e");
        String exception = getExceptionText(e);
        Flushbar(
          title: "Sign In Error",
          message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    }
  }
*/  String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this email address not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'This email address already has an account.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }
  void moveToRegister()
  {
    formKey.currentState.reset();
    setState(() {
      _formType=FormType.register;
    });
  }

  void moveToLogin()
  {
    formKey.currentState.reset();
    setState(() {
      _formType=FormType.login;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: (Colors.white),
      appBar: AppBar(title: Text('Login'),
      ),
      body: Container(
        child: Form(
            key: formKey,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildInputs()+submitButton(),
              ),
            )),
      ),

    );
  }
  List<Widget> buildInputs(){
    return[
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Icon(Icons.person,color: Colors.blue,size: 80,),
          ),
          //Text('Login',style: TextStyle(fontSize: 30.0,color:Colors.black),),

          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: TextFormField(
              decoration: new InputDecoration(
                prefixIcon: Padding(padding: EdgeInsets.only(left:5.0),
                  child: Icon(
                    Icons.email,color: Colors.black,
                  ),
                ),
                hintText: ' Enter Email',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              ),
              validator: (value)=>value.isEmpty? 'Please enter Email Id':null,
              onSaved: (value)=> _email=value,
            ),
          ),
          Divider(),
          TextFormField(
            decoration: new InputDecoration(
              prefixIcon: Padding(padding: EdgeInsets.only(left:5.0),
                child: Icon(
                  Icons.lock,color: Colors.black,
                ),
              ),
              hintText: 'Enter Password',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            validator: (value)=>value.isEmpty? 'Please enter password':null,
            obscureText: true,
            onSaved: (value)=> _password=value,
          ),
        ],
      ),
    ];
  }
  List<Widget> submitButton(){

    if(_formType==FormType.login){
      return [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.blue,
            child: Text('Login',style: TextStyle(color: Colors.white),),
            onPressed: validateAndSubmit,
          ),
        ),
        new FlatButton(
          child:Text('Create an Account') ,
          onPressed: moveToRegister,
        ),
      ];
    }
    else
    {
      return [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.blue,
            child: Text('Create an Account',style: TextStyle(color: Colors.white),),
            onPressed:validateAndSubmit,
          ),
        ),
        new FlatButton(
          child:Text('Have an Account?Login'),
          onPressed: moveToLogin,
        )
      ];
    }
  }
}
