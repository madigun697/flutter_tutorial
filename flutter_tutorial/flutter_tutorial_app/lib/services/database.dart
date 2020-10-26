import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tutorial_app/models/package.dart';
import 'package:flutter_tutorial_app/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference tutorialCollection =
      FirebaseFirestore.instance.collection('tutorial');

  Future signupUserData(
      String name, String email, String photo, String gender, int level) async {
    if (await tutorialCollection.doc(uid).get().then((doc) => doc.exists)) {
      return null;
    } else {
      return await tutorialCollection.doc(uid).set({
        'name': name,
        'email': email,
        'photoURL': photo,
        'gender': gender,
        'level': level
      });
    }
  }

  Future updateUserData(String name, String gender, int level) async {
    print(name + gender + level.toString());
    return await tutorialCollection
        .doc(uid)
        .update({'name': name, 'gender': gender, 'level': level});
  }

  // Package list from sanpshot
  List<Package> _packageListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Package(
          name: doc.data()['name'] ?? 'Unknown',
          email: doc.data()['email'] ?? '',
          photoURL: doc.data()['photoURL'],
          gender: doc.data()['gender'] ?? 'Others',
          level: doc.data()['level'] ?? 100);
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()['name'],
        email: snapshot.data()['email'],
        photo: snapshot.data()['photoURL'],
        gender: snapshot.data()['gender'],
        level: snapshot.data()['level']);
  }

  // get stream
  Stream<List<Package>> get package {
    return tutorialCollection.snapshots().map(_packageListFromSnapshot);
  }

  Stream<UserData> get userData {
    return tutorialCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
