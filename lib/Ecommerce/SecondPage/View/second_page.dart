import 'package:email_firebase/Ecommerce/FirstScreen/Controller/e_controller.dart';
import 'package:email_firebase/Ecommerce/FirstScreen/Model/eModel.dart';
import 'package:email_firebase/FireBase/Model/home_model.dart';
import 'package:email_firebase/FireBase/controller/home_controller.dart';
import 'package:email_firebase/Utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // String? name, image, desc, key, rating, price;
  // int? checkUpdate;

  TextEditingController txtname = TextEditingController();
  TextEditingController txtprice = TextEditingController();
  TextEditingController txtdate = TextEditingController(
      text:
          "${DateTime.now().day}/ ${DateTime.now().month}/ ${DateTime.now().year}");
  TextEditingController txttime = TextEditingController(
      text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
  TextEditingController txtimage = TextEditingController();
  TextEditingController txtdesc = TextEditingController();
  TextEditingController txtrating = TextEditingController();

  Econtroller econtroller = Get.put(Econtroller());
  eModel emodel = Get.arguments;

  void NewData() {
    txtname = TextEditingController(
      text: "${emodel.name}",
    );
    txtdate = TextEditingController(
      text: "${emodel.date}",
    );
    txttime = TextEditingController(
      text: "${emodel.time}",
    );
    txtprice = TextEditingController(
      text: "${emodel.price}",
    );
    txtdesc = TextEditingController(
      text: "${emodel.desc}",
    );
    txtimage = TextEditingController(
      text: "${emodel.image}",
    );
    txtrating = TextEditingController(
      text: "${emodel.rating}",
    );
  }

  void OldData() {
    txtname = TextEditingController();
    txtrating = TextEditingController();
    txtdate = TextEditingController(
        text:
            "${DateTime.now().day}/ ${DateTime.now().month}/ ${DateTime.now().year}");
    txttime = TextEditingController(
        text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
    txtprice = TextEditingController();
    txtimage = TextEditingController();
    txtdesc = TextEditingController();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emodel.checkUpdate == 1 ? NewData() : OldData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Insert Data"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            TextField(
              controller: txtname,
              decoration: InputDecoration(
                  label: const Text("Name"),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  focusColor: Colors.blue.shade100,
                  hintText: "Enter product name"),
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextField(
              controller: txtprice,
              decoration: InputDecoration(
                  label: const Text("Price"),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  focusColor: Colors.blue.shade100,
                  hintText: "Enter product price"),
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextField(
              controller: txtdate,
              decoration: InputDecoration(
                  label: const Text("Date"),
                  border: const OutlineInputBorder(
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
              decoration: const InputDecoration(
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
              controller: txtimage,
              decoration: const InputDecoration(
                  label: Text("Image"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  focusColor: Colors.blue,
                  hintText: "enter link"),
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextField(
              controller: txtrating,
              decoration: const InputDecoration(
                  label: Text("Rating"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  focusColor: Colors.blue,
                  hintText: "enter rating"),
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextField(
              controller: txtdesc,
              maxLines: 5,
              decoration: const InputDecoration(
                label: Text("Description"),
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
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              onPressed: () {
                emodel.checkUpdate == 0
                    ? FirebaseHelper.firebaseHelper.addProduct(
                        name: txtname.text,
                        rating: txtrating.text,
                        price: txtprice.text,
                        image: txtimage.text,
                        desc: txtdesc.text,
                      )
                    : FirebaseHelper.firebaseHelper.updateProduct(
                        name: txtname.text,
                        desc: txtdesc.text,
                        image: txtimage.text,
                        price: txtprice.text,
                        rating: txtrating.text,
                        key: emodel.key,
                      );
                Get.back();
              },
              child: Text(emodel.checkUpdate == 0 ? "Add" : "Update",
                  style: GoogleFonts.poppins(color: Colors.black)),
            ),
          ]),
        ),
      ),
    ));
  }
}
