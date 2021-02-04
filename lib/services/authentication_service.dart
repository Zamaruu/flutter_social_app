import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool validateEmail(String email){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid;
  }

bool validatePassword(String password){
  String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(password);
}

bool validateNames(String name){
  if(name.length <= 1 || name.length >= 40) return false;
  else return true;
}

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
  
  Future<String> signUp(String firstName, String surName, String email, String password)async{
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      userSetup(firstName, surName);
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Sigend up";
    }  on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> userSetup(String firstName, String surName){
    CollectionReference users = FirebaseFirestore.instance.collection("Users");
    String uid = _firebaseAuth.currentUser.uid;

    users.add({
      'firstName': firstName,
      'surName': surName,
      'uid': uid
    });
  }

  

}