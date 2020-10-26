import 'package:flutter/material.dart';
import 'package:flutter_tutorial_app/models/package.dart';
import 'package:flutter_tutorial_app/models/user.dart';
import 'package:flutter_tutorial_app/screens/home/package_list.dart';
import 'package:flutter_tutorial_app/screens/home/settings_form.dart';
import 'package:flutter_tutorial_app/services/auth.dart';
import 'package:flutter_tutorial_app/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final AppUser user;
  Home(this.user);

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Package>>.value(
      value: DatabaseService().package,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('App Main'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: Icon(Icons.person),
                  label: Text('logout')),
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
                onPressed: () => _showSettingsPanel(),
              )
            ],
          ),
          // body: Container(
          //     padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
          //     child: Row(children: <Widget>[
          //       Image(
          //         image: this.user.photo != null
          //             ? NetworkImage(this.user.photo)
          //             : AssetImage('lib/assets/default_photo.png'),
          //       ),
          //       Expanded(
          //           child: Container(
          //               padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          //               child: Text(
          //                 this.user.name + "\n" + this.user.email,
          //                 textAlign: TextAlign.left,
          //                 style: TextStyle(),
          //               ))),
          //       PackageList(),
          //     ]))
          body: PackageList()),
    );
  }
}
