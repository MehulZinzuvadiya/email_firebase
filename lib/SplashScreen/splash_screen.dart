import 'dart:async';

import 'package:email_firebase/Utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin = FirebaseHelper.firebaseHelper.checkUser();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),
        () => Get.offAndToNamed(isLogin ? '/home' : '/login'));
    return SafeArea(
        child: Scaffold(
            body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(),
      child: Image.network(
          "https://img.freepik.com/free-vector/connected-world-concept-illustration_114360-3027.jpg?w=740&t=st=1685009308~exp=1685009908~hmac=e9eb6c15e2885ab4bb9ba267fc4b2dc9441194772bf157d4e40d4843dcece890",
          fit: BoxFit.cover),
    )));
  }
}
