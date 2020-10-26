import 'package:flutter/material.dart';
import 'package:flutter_tutorial_app/models/package.dart';

class PackageTile extends StatelessWidget {
  final Package package;
  PackageTile({this.package});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
          child: ListTile(
            isThreeLine: true,
            leading: CircleAvatar(
              radius: 25.0,
              backgroundImage: package.photoURL != null
                  ? NetworkImage(package.photoURL)
                  : AssetImage('lib/assets/default_photo.png'),
            ),
            title: Text(package.name + " (" + package.level.toString() + ")"),
            subtitle: Text(package.email),
            trailing: Text(package.gender),
          ),
        ));
  }
}
