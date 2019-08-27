import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ung_ubru/models/product_model.dart';

class ListProduct extends StatefulWidget {
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  // Explicit
  // List<String> names = ['aa', 'bb', 'cc'];
  List<DocumentSnapshot> snapshots;
  List<ProductModel> productModels = [];

  // Method
  @override
  void initState() {
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Product');
    StreamSubscription<QuerySnapshot> subscription =
        await collectionReference.snapshots().listen((dataSnapshot) {
      snapshots = dataSnapshot.documents;
      for (var mySnapshot in snapshots) {
        String name = mySnapshot.data['Name'];
        String detail = mySnapshot.data['Detail'];
        String path = mySnapshot.data['Path'];
        String qrCode = mySnapshot.data['QRcode'];
        print('name = $name');

        ProductModel productModel = ProductModel(name, detail, path, qrCode);
        setState(() {
          productModels.add(productModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(productModels[index].path,fit: BoxFit.contain,),
    );
  }

  Widget showListViewProduct() {
    return ListView.builder(
      itemCount: productModels.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: <Widget>[showImage(index),],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return showListViewProduct();
  }
}
