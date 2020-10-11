import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tutorial_app/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  AppUser _userFromFirebaseUser(User user) {
    print(user);
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
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      // [firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.
      // [firebase_auth/wrong-password] The password is invalid or the user does not have a password.
      return e.toString().split('] ')[1];
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

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
