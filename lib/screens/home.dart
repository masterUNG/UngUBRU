import 'package:flutter/material.dart';
import 'package:ung_ubru/screens/register.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Explicit

  // Method
  Widget mySizebox() {
    return SizedBox(
      width: 5.0,
      height: 16.0,
    );
  }

  Widget signInButton() {
    return Expanded(
      child: RaisedButton(
        color: Colors.blue.shade400,
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget signUpButton() {
    return Expanded(
      child: OutlineButton(
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.blue.shade400),
        ),
        onPressed: () {
          print('You Click SingUp');

          MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => Register()); 
          Navigator.of(context).push(materialPageRoute);                 

        },
      ),
    );
  }

  Widget showButton() {
    return Container(
      margin: EdgeInsets.only(left: 50.0, right: 50.0),
      child: Row(
        children: <Widget>[
          signInButton(),
          mySizebox(),
          signUpButton(),
        ],
      ),
    );
  }

  Widget showLogo() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 150.0,
        height: 150.0,
        child: Image.asset('images/logo.png'),
      ),
    );
  }

  Widget showAppName() {
    return Text(
      'Ung UBRU',
      style: TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.blue[400],
        fontFamily: 'DancingScript',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: [Colors.white, Colors.blue],
          radius: 1.0,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showLogo(),
            mySizebox(),
            showAppName(),
            showButton(),
          ],
        ),
      ),
    );
  }
}
