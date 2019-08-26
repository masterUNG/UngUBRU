import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ung_ubru/screens/my_service.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  Color myColor = Colors.green.shade900;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String email = '', password = '';
  final formKey = GlobalKey<FormState>();

  // Method

  Widget loginButton() {
    return FloatingActionButton(
      backgroundColor: myColor,
      child: Icon(
        Icons.navigate_next,
        size: 36.0,
      ),
      onPressed: () {
        formKey.currentState.save();
        print('email = $email, password = $password');
        checkAuthen();
      },
    );
  }

  Future<void> checkAuthen() async {
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      myAlert(title, message);
    });
  }

  void myAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: showTitle(title),
          content: Text(message),
          actions: <Widget>[okButton()],
        );
      },
    );
  }

  Widget okButton() {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget showTitle(String title) {
    return ListTile(
      leading: Icon(
        Icons.add_alert,
        color: Colors.red,
        size: 48.0,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget backButton() {
    return IconButton(
      icon: Icon(
        Icons.navigate_before,
        color: myColor,
        size: 36.0,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          size: 36.0,
          color: myColor,
        ),
        labelText: 'Email :',
        labelStyle: TextStyle(color: myColor),
      ),
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          size: 36.0,
          color: myColor,
        ),
        labelText: 'Password :',
        labelStyle: TextStyle(color: myColor),
      ),
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget showName() {
    return ListTile(
      leading: ImageIcon(
        AssetImage('images/logo.png'),
        size: 36.0,
        color: myColor,
      ),
      title: Text(
        'Ung UBRU',
        style: TextStyle(
          fontSize: 30.0,
          color: myColor,
          fontFamily: 'DancingScript',
        ),
      ),
    );
  }

  Widget showAuthen() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/wallpaper.jpg'), fit: BoxFit.cover),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(20.0),
        color: Color.fromRGBO(255, 255, 255, 0.7),
        width: 300.0,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showName(),
              emailText(),
              passwordText(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            showAuthen(),
            backButton(),
          ],
        ),
      ),
      floatingActionButton: loginButton(),
    );
  }
}
