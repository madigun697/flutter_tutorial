import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference tutorialCollection =
      FirebaseFirestore.instance.collection('tutorial');

  Future updateUserData(String name, String email, String photo) async {
    if (await tutorialCollection.doc(uid).get().then((doc) => doc.exists)) {
      return null;
    } else {
      return await tutorialCollection
          .doc(uid)
          .set({'name': name, 'email': email, 'photoURL': photo});
    }
  }

  // get stream
  Stream<QuerySnapshot> get tutorial {
    return tutorialCollection.snapshots();
  }
}
