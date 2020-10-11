import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tutorial_app/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  AppUser _userFromFirebaseUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
    // .map((User user) => _userFromFirebaseUser(user));
  }

  // sign in anonymous
  Future signInAnonymous() async {
    try {
      UserCredential result = await _auth
          .signInAnonymously(); // AuthResult class has been renamed to UserCredential
      User user = result.user; // FirebaseUser is deprecated
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password

  // register with email & password

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
