class AppUser {
  final String uid;
  final String name;
  final String email;
  final String photo;
  final String gender;
  final int level;
  AppUser(
      {this.uid, this.name, this.email, this.photo, this.gender, this.level});

  // Firebase User Sample
  // User(displayName: null, email: test2@test.com, emailVerified: false,
  // isAnonymous: false,
  // metadata: UserMetadata(creationTime: 2020-10-11 00:14:10.865,
  // lastSignInTime: 2020-10-11 00:53:43.374), phoneNumber: null,
  // photoURL: null, providerData,
  // UserInfo(displayName: null, email: test2@test.com, phoneNumber: null,
  // photoURL: null, providerId: password, uid: test2@test.com)],
  // refreshToken: , tenantId: null, uid: BbAdbtC58PQfQ0k0Ki82VOjmEq83)
}

class UserData {
  final String uid;
  final String name;
  final String email;
  final String photo;
  final String gender;
  final int level;
  UserData(
      {this.uid, this.name, this.email, this.photo, this.gender, this.level});
}
