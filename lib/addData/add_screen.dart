import 'package:email_firebase/FireBase/Model/home_model.dart';
import 'package:email_firebase/FireBase/controller/home_controller.dart';
import 'package:email_firebase/Utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  TextEditingController txtdate = TextEditingController(
      text:
          "${DateTime.now().day}/ ${DateTime.now().month}/ ${DateTime.now().year}");
  TextEditingController txttime = TextEditingController(
      text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
  TextEditingController txtpriority = TextEditingController();

  HomeController homeController = Get.put(HomeController());

  HomeModel homeModel = Get.arguments;

  void NewData() {
    txttitle = TextEditingController(
      text: "${homeModel.title}",
    );
    txtdate = TextEditingController(
      text: "${homeModel.date}",
    );
    txttime = TextEditingController(
      text: "${homeModel.time}",
    );
    txtpriority = TextEditingController(
      text: "${homeModel.priority}",
    );
    txtnotes = TextEditingController(
      text: "${homeModel.notes}",
    );
  }

  void OldData() {
    txttitle = TextEditingController();
    txtpriority = TextEditingController();
    txtdate = TextEditingController(
        text:
            "${DateTime.now().day}/ ${DateTime.now().month}/ ${DateTime.now().year}");
    txttime = TextEditingController(
        text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
    txtnotes = TextEditingController();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeModel.checkupdate == 1 ? NewData() : OldData();
  }

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
              controller: txtpriority,
              decoration: InputDecoration(
                  label: Text("Priority"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  focusColor: Colors.blue.shade100,
                  hintText: "priority"),
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextField(
              controller: txtdate,
              decoration: InputDecoration(
                  label: Text("Date"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  focusColor: Colors.blue.shade100,
                  hintText: "date"),
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextField(
              controller: txttime,
              decoration: InputDecoration(
                  label: Text("Time"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  focusColor: Colors.blue,
                  hintText: "time"),
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextField(
              controller: txtnotes,
              maxLines: 5,
              decoration: InputDecoration(
                label: Text("Notes"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                focusColor: Colors.blue,
                hintText: "Start typing..",
              ),
            ),
            SizedBox(
              height: 5.sp,
            ),
            ElevatedButton(
              onPressed: () {
                homeModel.checkupdate == 0
                    ? FirebaseHelper.firebaseHelper.addTask(
                        title: txttitle.text,
                        date: txtdate.text,
                        notes: txtnotes.text,
                        priority: txtpriority.text,
                        time: txttime.text,
                      )
                    : FirebaseHelper.firebaseHelper.updateTask(
                        time: txttime.text,
                        priority: txtpriority.text,
                        notes: txtnotes.text,
                        date: txtdate.text,
                        title: txttitle.text,
                        key: homeModel.key,
                      );
                Get.back();
              },
              child: Text(homeModel.checkupdate == 0 ? "Add" : "Update",
                  style: GoogleFonts.poppins()),
            ),
          ]),
        ),
      ),
    ));
  }
}
