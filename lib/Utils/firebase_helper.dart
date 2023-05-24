import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();
  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void signUp({required email, required password}) {
    firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
        // .then((value) => print("Success"))
        // .catchError(email);
  }

}