import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  Color myColor = Colors.green.shade900;

  // Method
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
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          size: 36.0,
          color: myColor,
        ),
        labelText: 'Email :',
        labelStyle: TextStyle(color: myColor),
      ),
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          size: 36.0,
          color: myColor,
        ),
        labelText: 'Password :',
        labelStyle: TextStyle(color: myColor),
      ),
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
      alignment: Alignment.center,
      child: Container(
        width: 250.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showName(),
            emailText(),
            passwordText(),
          ],
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
            backButton(),
            showAuthen(),
          ],
        ),
      ),
    );
  }
}
