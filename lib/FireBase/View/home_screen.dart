import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_firebase/FireBase/Model/home_model.dart';
import 'package:email_firebase/FireBase/controller/home_controller.dart';
import 'package:email_firebase/Utils/notification_service.dart';
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
        actions: [
          IconButton(
              onPressed: () async {
                await NotificationService.notificationService
                    .showSimpleNotification();
              },
              icon: Icon(Icons.notifications_active)),
          IconButton(
              onPressed: () async {
                await NotificationService.notificationService.zonedSchedule();
              },
              icon: Icon(Icons.timer)),
          IconButton(
              onPressed: () async {
                await NotificationService.notificationService
                    .showNotificationWithSound();
              },
              icon: Icon(Icons.circle_notifications)),
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
              SizedBox(
                height: 10.sp,
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
                  backgroundColor: Colors.red.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HomeModel h1 = HomeModel(
            checkupdate: 0,
          );
          Get.toNamed('/addData', arguments: h1);
        },
        backgroundColor: Colors.blue.shade400,
        child: Icon(
          Icons.add,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseHelper.firebaseHelper.getTask(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            QuerySnapshot? Snapdata = snapshot.data;

            for (var x in Snapdata!.docs) {
              Map? data = x.data() as Map;

              var title = data['title'];
              var priority = data['priority'];
              var date = data['date'];
              var time = data['time'];
              var notes = data['notes'];

              HomeModel h1 = HomeModel(
                time: time,
                priority: priority,
                notes: notes,
                date: date,
                title: title,
                key: x.id,
              );
              homeController.DataList.add(h1);
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 200,
              ),
              itemCount: homeController.DataList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    HomeModel homeModel = HomeModel(
                      title: homeController.DataList[index].title,
                      date: homeController.DataList[index].date,
                      time: homeController.DataList[index].time,
                      notes: homeController.DataList[index].notes,
                      priority: homeController.DataList[index].priority,
                      checkupdate: 1,
                    );
                    Get.toNamed("/addData", arguments: homeModel);
                  },
                  onLongPress: () {
                    var key = homeController.DataList[index].key;
                    FirebaseHelper.firebaseHelper.deletedata(key!);
                    Get.snackbar("Delete", "success");
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${homeController.DataList[index].title}",
                                style: GoogleFonts.poppins(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade800,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "${homeController.DataList[index].priority}",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${homeController.DataList[index].notes}",
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${homeController.DataList[index].date}"),
                            Text("${homeController.DataList[index].time}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
            // return ListView.builder(
            //   itemBuilder: (context, index) {
            //     return ListTile(
            //       title: Text("${taskList[index].title}"),
            //       subtitle: Text("${taskList[index].priority}"),
            //     );
            //   },
            //   itemCount: taskList.length,
            // );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }
}
