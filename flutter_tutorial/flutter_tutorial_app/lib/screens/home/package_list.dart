import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class PackageList extends StatefulWidget {
  @override
  _PackageListState createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  @override
  Widget build(BuildContext context) {
    final packages = Provider.of<QuerySnapshot>(context);

    for (var doc in packages.docs) {
      print(doc.data());
    }
    return Container();
  }
}
