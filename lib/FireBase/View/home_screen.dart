import 'package:email_firebase/FireBase/controller/home_controller.dart';
import 'package:email_firebase/Utils/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.userDetail.value = FirebaseHelper.firebaseHelper.UserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Firebase Authentication",
          style: GoogleFonts.lato(
            fontSize: 22,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          height: 10.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade700,
                Colors.blue.shade100,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.clamp,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30.sp,
                backgroundImage:
                    NetworkImage("${homeController.userDetail['image']}"),
              ),
              SizedBox(height: 10.sp),
              Text(
                "${homeController.userDetail['name']}",
                style: GoogleFonts.dancingScript(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.sp),
              Text(
                "${homeController.userDetail['email']}",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Logged In as = ${homeController.userDetail['email']}",
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseHelper.firebaseHelper.signOut();
                },
                child: Text(
                  'LogOut',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
