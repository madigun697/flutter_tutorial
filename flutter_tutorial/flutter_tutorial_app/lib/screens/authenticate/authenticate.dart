import 'package:flutter/material.dart';
import 'package:flutter_tutorial_app/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  Widget build(BuildContext context) {
    return Container(
      child: SignIn(),
    );
  }
}
