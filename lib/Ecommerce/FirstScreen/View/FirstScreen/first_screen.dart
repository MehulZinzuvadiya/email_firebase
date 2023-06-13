import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../../Utils/firebase_helper.dart';
import '../../Controller/e_controller.dart';
import '../../Model/eModel.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  Econtroller econtroller = Get.put(Econtroller());
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    econtroller.userDetail.value = FirebaseHelper.firebaseHelper.UserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("FlipKart"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseHelper.firebaseHelper.signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30.sp,
                backgroundImage:
                    NetworkImage("${econtroller.userDetail['image']}"),
              ),
              SizedBox(height: 10.sp),
              Text(
                "${econtroller.userDetail['name']}",
                style: GoogleFonts.dancingScript(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.sp),
              Text(
                "${econtroller.userDetail['email']}",
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
      body: StreamBuilder(
        stream: FirebaseHelper.firebaseHelper.readProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "${snapshot.error}",
              ),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot? snapData = snapshot.data;

            econtroller.DataList.clear();

            for (var x in snapData!.docs) {
              eModel e1 = eModel(
                rating: x['rating'],
                price: x['price'],
                desc: x['desc'],
                name: x['name'],
                image: x['image'],
                key: x.id,
              );

              econtroller.DataList.add(e1);
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 300,
              ),
              itemCount: econtroller.DataList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    var key = econtroller.DataList[index].key;
                    FirebaseHelper.firebaseHelper.deleteProduct(key!);
                    Get.snackbar("Deleted", "OK");
                  },
                  onTap: () {
                    eModel emodel = eModel(
                      desc: econtroller.DataList[index].desc,
                      name: econtroller.DataList[index].name,
                      price: econtroller.DataList[index].price,
                      rating: econtroller.DataList[index].rating,
                      image: econtroller.DataList[index].image,
                      date: econtroller.DataList[index].date,
                      time: econtroller.DataList[index].time,
                      key: econtroller.DataList[index].key,
                      checkUpdate: 1,
                    );
                    Get.toNamed('/eSecond', arguments: emodel);
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 70.sp,
                                width: 70.sp,
                                child: Image.network(
                                  "${econtroller.DataList[index].image}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                "${econtroller.DataList[index].name}",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 5.sp),
                              Text(
                                "${econtroller.DataList[index].desc}",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 15.sp),
                              Row(
                                children: [
                                  Text(
                                    "${econtroller.DataList[index].rating}",
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    "⭐⭐⭐⭐",
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\INR ${econtroller.DataList[index].price}.00",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    height: 30.sp,
                                    width: 30.sp,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.deepPurple,
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10.sp,
                        left: 120.sp,
                        child: Text(
                          "💜",
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
            // return Text("123");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          eModel e1 = eModel(
            checkUpdate: 0,
          );
          Get.toNamed('/eSecond', arguments: e1);
        },
        backgroundColor: Colors.blue.shade400,
        child: Icon(
          Icons.add,
        ),
      ),
    ));
  }
}
