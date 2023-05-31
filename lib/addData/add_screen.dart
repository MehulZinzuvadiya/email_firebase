import 'package:email_firebase/Utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  // time,priority,notes,date,title

  TextEditingController txttitle = TextEditingController();
  TextEditingController txtnotes = TextEditingController();
  TextEditingController txtdate = TextEditingController();
  TextEditingController txttime = TextEditingController();
  TextEditingController txtpriority = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Insert Detail"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            TextField(
              controller: txttitle,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                  focusColor: Colors.blue.shade100, hintText: "title"),
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextField(
              controller: txtpriority,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  focusColor: Colors.blue.shade100, hintText: "priority"),
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextField(
              controller: txtdate,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  focusColor: Colors.blue.shade100, hintText: "date"),
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextField(
              controller: txttime,
              decoration:
                  InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      focusColor: Colors.blue, hintText: "time"),
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextField(
              controller: txtnotes,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                focusColor: Colors.blue,
                hintText: "Notes",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseHelper.firebaseHelper.addTask(
                  title: txttitle.text,
                  date: txtdate.text,
                  notes: txtnotes.text,
                  priority: txtpriority.text,
                  time: txttime.text,
                );
                Get.back();
              },
              child: Text("Add"),
            ),
          ]),
        ),
      ),
    ));
  }
}
