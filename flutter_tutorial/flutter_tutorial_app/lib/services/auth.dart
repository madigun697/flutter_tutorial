import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tutorial_app/models/user.dart';
import 'package:flutter_tutorial_app/services/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _google_signin = GoogleSignIn();

  // create user object based on FirebaseUser
  AppUser _userFromFirebaseUser(User user) {
    print(user);
    if (user != null) {
      if (user.isAnonymous) {
        return AppUser(
            uid: user.uid,
            name: 'Ananymous',
            email: 'Unknown',
            photo: null,
            gender: 'Others',
            level: 0);
      } else {
        return AppUser(
            uid: user.uid,
            name: user.displayName != null ? user.displayName : 'Unknown',
            email: user.email,
            photo: user.photoURL,
            gender: 'Others',
            level: 0);
      }
    } else {
      return null;
    }
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

  // sign in using google account
  // https://blog.codemagic.io/firebase-authentication-google-sign-in-using-flutter/
  // https://blog.naver.com/PostView.nhn?blogId=ndtid0106&logNo=221743818945&parentCategoryNo=&categoryNo=60&viewDate=&isShowPopularPosts=false&from=postView
  Future signInGoogle() async {
    try {
      final GoogleSignInAccount _account = await _google_signin.signIn();
      final GoogleSignInAuthentication _google_auth =
          await _account.authentication;

      final AuthCredential _cridential = GoogleAuthProvider.credential(
          accessToken: _google_auth.accessToken, idToken: _google_auth.idToken);

      UserCredential result = await _auth.signInWithCredential(_cridential);
      User user = result.user;

      await DatabaseService(uid: user.uid).signupUserData(
          user.displayName, user.email, user.photoURL, 'Others', 100);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return "Error: " + e.toString();
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
      return e.toString();
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).signupUserData(
          user.displayName, user.email, user.photoURL, 'Others', 100);
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
