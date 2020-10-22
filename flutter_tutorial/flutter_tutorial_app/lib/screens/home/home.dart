import 'package:flutter/material.dart';
import 'package:flutter_tutorial_app/models/user.dart';
import 'package:flutter_tutorial_app/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final AppUser user;
  Home(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                label: Text('logout'))
          ],
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Row(children: <Widget>[
              Image(
                image: this.user.photo != null
                    ? NetworkImage(this.user.photo)
                    : AssetImage('lib/assets/default_photo.png'),
              ),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        this.user.name + "\n" + this.user.email,
                        textAlign: TextAlign.left,
                        style: TextStyle(),
                      ))),
            ])));
  }
}
