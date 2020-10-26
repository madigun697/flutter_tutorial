import 'package:flutter/material.dart';
import 'package:flutter_tutorial_app/models/package.dart';
import 'package:flutter_tutorial_app/screens/home/package_tile.dart';
import 'package:provider/provider.dart';

class PackageList extends StatefulWidget {
  @override
  _PackageListState createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  @override
  Widget build(BuildContext context) {
    final packages = Provider.of<List<Package>>(context) ?? [];

    return ListView.builder(
      itemCount: packages.length,
      itemBuilder: (context, index) {
        return PackageTile(package: packages[index]);
      },
    );
  }
}
