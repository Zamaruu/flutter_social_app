import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/model/current_user.dart';
import 'package:flutter_social_app/ui/screens/login.dart';
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

  Future<void> signOut(BuildContext context) async{
    await _firebaseAuth.signOut();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginRoute()), (route) => false);
  }

  Future<String> signIn(String email, String password)async{
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await getUserCredentials();
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

      var name = _firebaseAuth.currentUser.displayName.split(" ");
      userSetup(name[0], name[1]);
      await getUserCredentials();
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
      
      CurrentUser.email = email;
      CurrentUser.firstName = firstName;
      CurrentUser.surName = surName;
      CurrentUser.uid = _firebaseAuth.currentUser.uid;

      return "Sigend up";
    }  on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future userSetup(String firstName, String surName){
    CollectionReference users = FirebaseFirestore.instance.collection("Users");
    String uid = _firebaseAuth.currentUser.uid;

    users.doc(uid).set({
      'firstName': firstName,
      'surName': surName,
      'uid': uid
    });
  }

  Future<void> getUserCredentials() async {
    String uid = _firebaseAuth.currentUser.uid;
    CollectionReference userDataReference = FirebaseFirestore.instance.collection("Users");

    var userData = await userDataReference.doc(uid).get();
    CurrentUser.firstName = userData["firstName"];
    CurrentUser.surName = userData["surName"];
    CurrentUser.uid = uid;
    CurrentUser.email = _firebaseAuth.currentUser.email;
    CurrentUser.photoUrl = _firebaseAuth.currentUser.photoURL;
  }
} 