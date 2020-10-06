import 'package:flutter/material.dart';
import 'package:flutter_tutorial_app/models/user.dart';
import 'package:flutter_tutorial_app/screens/authenticate/authenticate.dart';
import 'package:flutter_tutorial_app/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
