import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ung_ubru/models/product_model.dart';
import 'package:ung_ubru/screens/detail.dart';
import 'package:ung_ubru/screens/home.dart';
import 'package:ung_ubru/screens/list_product.dart';
import 'package:ung_ubru/screens/show_map.dart';
import 'package:barcode_scan/barcode_scan.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  String loginString = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  double mySizeIcon = 36.0;
  double h2 = 18.0;
  Widget myWidget = ListProduct();
  List<ProductModel> productModels = [];

  // Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
    readAllData();
  }

  Future<void> scanQRcode() async {
    try {
      String barcode = await BarcodeScanner.scan();
      print('barcode = $barcode');

      if (productModels.length != 0) {
        for (var myProductModel in productModels) {
          if (barcode == myProductModel.qrCode) {
            print('barcode Map');

            MaterialPageRoute materialPageRoute = MaterialPageRoute(
                builder: (BuildContext context) => Detail(
                      productModel: myProductModel,
                    ));
                    Navigator.of(context).push(materialPageRoute);
          }
        }
      }
    } catch (e) {}
  }

  Future readAllData() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Product');
    StreamSubscription<QuerySnapshot> subscription =
        await collectionReference.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.documents;

      for (var snapshot in snapshots) {
        ProductModel productModel = ProductModel(
            snapshot.data['Name'],
            snapshot.data['Detail'],
            snapshot.data['Path'],
            snapshot.data['QRcode']);
        productModels.add(productModel);
      }
    });
  }

  Widget listProductMenu() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: mySizeIcon,
      ),
      title: Text(
        'List Product',
        style: TextStyle(fontSize: h2),
      ),
      subtitle: Text('Show List All Product'),
      onTap: () {
        setState(() {
          myWidget = ListProduct();
          Navigator.of(context).pop();
        });
      },
    );
  }

  Widget mapMenu() {
    return ListTile(
      leading: Icon(
        Icons.map,
        size: mySizeIcon,
      ),
      title: Text(
        'Show Map',
        style: TextStyle(fontSize: h2),
      ),
      subtitle: Text('Show Show Current Location Map'),
      onTap: () {
        setState(() {
          myWidget = ShowMap();
          Navigator.of(context).pop();
        });
      },
    );
  }

  Widget signOutMenu() {
    return ListTile(
      leading: Icon(
        Icons.cached,
        size: mySizeIcon,
      ),
      title: Text(
        'Sign Out',
        style: TextStyle(fontSize: h2),
      ),
      onTap: () {
        processSignOut();
      },
    );
  }

  Future<void> processSignOut() async {
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Future<void> findDisplayName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      loginString = firebaseUser.displayName;
      print('login = $loginString');
    });
  }

  Widget showLogin() {
    return Text(
      'Login by ... $loginString',
      style: TextStyle(fontSize: 16.0, color: Colors.white),
    );
  }

  Widget showAppName() {
    return Text(
      'Ung UBRU',
      style: TextStyle(
        fontSize: 24.0,
        color: Colors.blue,
        fontFamily: 'DancingScript',
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget myHeadDrawer() {
    return DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/sun.jpg'), fit: BoxFit.fitHeight),
      ),
      child: Column(
        children: <Widget>[
          showLogo(),
          showAppName(),
          showLogin(),
        ],
      ),
    );
  }

  Widget myDrewerMenu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          myHeadDrawer(),
          listProductMenu(),
          qrCodeMenu(),
          mapMenu(),
          signOutMenu(),
        ],
      ),
    );
  }

  Widget qrCodeMenu() {
    return ListTile(
      leading: Icon(
        Icons.camera,
        size: mySizeIcon,
      ),
      title: Text(
        'Read QR code',
        style: TextStyle(fontSize: h2),
      ),
      subtitle: Text('For Read QR code by Camera'),
      trailing: Icon(Icons.navigate_next),
      onTap: () {
        scanQRcode();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      body: myWidget,
      drawer: myDrewerMenu(),
    );
  }
}
