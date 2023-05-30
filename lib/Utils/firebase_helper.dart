import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signUp(
      {required String email, required String password}) async {
    print("=========== $email $password");
    String msg = "";
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => msg = "Success")
        .catchError((e) => msg = " Fail$e");
    return msg;
  }

  Future<String> signIn({required email, required password}) async {
    String? msg;
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print("sucessLogin");
      msg = "Success";
    }).catchError((e) {
      print("$e");
      msg = "$e";
    });
    return msg!;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Get.offAndToNamed('login'));
    GoogleSignIn().signOut();
  }

  Future<String?> signInWithGoogle() async {
    String? msg;
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => msg = "Success")
        .catchError((e) => msg = "$e");
    return msg;
  }

  // Future signOut() async{
  //   try{
  //     return await FirebaseAuth.instance.signOut();
  //   }
  //   catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }

  bool checkUser() {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }

  Map UserData() {
    User? user = firebaseAuth.currentUser;

    String? image = user!.photoURL;
    String? name = user.displayName;
    String? email = user.email;
    String? phone = user.phoneNumber;

    return {
      "image": image,
      "name": name,
      "email": email,
      "phone": phone,
    };
  }
}
