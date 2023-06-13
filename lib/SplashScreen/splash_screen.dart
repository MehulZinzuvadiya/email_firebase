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
        () => Get.offAndToNamed(isLogin ? '/eFirst' : '/login'));
    return SafeArea(
        child: Scaffold(
            body: Center(
              child: Container(
      decoration: BoxDecoration(),
      child: Image.network(
          "https://as1.ftcdn.net/v2/jpg/05/07/73/68/1000_F_507736877_7Oc9fLH0l9dbhv6P4TpyJwqJJRg7s8RW.jpg",
          fit: BoxFit.cover),
    ),
            )));
  }
}
