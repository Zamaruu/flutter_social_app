import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final _googleSignIn = GoogleSignIn();
  
  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

  Future<String> signIn(String email, String password)async{
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Sigend in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }


  Future<String> signInWithGoogle() async {
    String errMsg;

    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      return "Sigend in with Google";
    } catch (e) {
      errMsg = 'Login failed, please try again later.';
    } finally {
      return errMsg;
    }
  }
  Future<String> signUp(String email, String password)async{
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Sigend up";
    }  on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}