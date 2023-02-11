import 'package:bye_bye_cry_new/db/db_helper.dart';
/*import 'package:firebase_auth/firebase_auth.dart';*/



class AuthService {
 /* static final _auth = FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;*/

  /*static Future<bool> loginAdmin(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return DbHelper.isUser(credential.user!.uid);
  }

  static Future<void> logout() {
    return _auth.signOut();
  }*/
}
























/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

_googleSignUp() async {
  try {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final User? user = (await _auth.signInWithCredential(credential)).user;
    // print("signed in " + user.displayName);

    return user;
  } catch (e) {
  }
}*/
