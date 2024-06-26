import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../device/constants.dart';
import '../init/cache/locale_manager.dart';
import 'firestore/database_service.dart';

class GoogleSignHelper {
  static GoogleSignHelper _instance = GoogleSignHelper._private();
  GoogleSignHelper._private();

  static GoogleSignHelper get instance => _instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<GoogleSignInAccount> signIn() async {
    final user = await _googleSignIn.signIn();
    if (user != null) {
      return user;
    }
    return null;
  }

  bool get isHaveUser => user == null ? false : true;
  GoogleSignInAccount get user => _googleSignIn.currentUser;

  Future<GoogleSignInAuthentication> googleAuthtencite() async {
    if (await _googleSignIn.isSignedIn()) {
      final user = _googleSignIn.currentUser;
      final userData = await user.authentication;
      return userData;
    }
    return null;
  }

  Future<GoogleSignInAccount> signOut() async {
    final user = await _googleSignIn.signOut();
    if (user != null) {
      print(user.email);
      return user;
    }
    return null;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAuthentication googleAuth = await googleAuthtencite();

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final user = (await _auth.signInWithCredential(credential)).user;
    await LocaleManager.instance
        .setStringValue(PreferencesKeys.TOKEN, user.uid);

    //cloud messaging get token
    var service = new DatabaseService();
    await FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance.onTokenRefresh.listen(service.addUsers);
    final token = await FirebaseMessaging.instance.getToken();
    service.addUsers(token);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
