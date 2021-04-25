import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../device/constants.dart';
import '../init/cache/locale_manager.dart';
import 'package:tasarim_proje/core/services/firestore/status_service.dart';

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
    //var tokenResult = await user.getIdToken();
    await LocaleManager.instance
        .setStringValue(PreferencesKeys.TOKEN, user.uid);
    //print(user.uid);
    var service = new StatusService();
    bool isDocExists = await service.isDocExists();
    if (!isDocExists) {
      service.addEmptyDoc();
    }

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
