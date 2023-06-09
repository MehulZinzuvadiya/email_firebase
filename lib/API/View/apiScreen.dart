import 'package:email_firebase/API/Controller/api_controller.dart';
import 'package:email_firebase/Utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class APiScreen extends StatefulWidget {
  const APiScreen({super.key});

  @override
  State<APiScreen> createState() => _APiScreenState();
}

class _APiScreenState extends State<APiScreen> {
  TextEditingController txttitle = TextEditingController();
  TextEditingController txtbody = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: txttitle,
              decoration: InputDecoration(
                  label: Text("Title"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  focusColor: Colors.blue.shade100,
                  hintText: "title"),
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextField(
              controller: txtbody,
              decoration: InputDecoration(
                  label: Text("enter body"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  focusColor: Colors.blue.shade100,
                  hintText: "Body"),
            ),
            SizedBox(
              height: 10.sp,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
                onPressed: () {
                  String title = txttitle.text;
                  String body = txtbody.text;
                  APiController.aPiController.SendPushNotification(body, title);
                  Get.back();
                },
                child: Text(
                  "Send",
                  style: GoogleFonts.poppins(color: Colors.black),
                )),
          ],
        ),
      ),
    ));
  }
}
