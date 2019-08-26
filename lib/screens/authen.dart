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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[backButton(),],
        ),
      ),
    );
  }
}
