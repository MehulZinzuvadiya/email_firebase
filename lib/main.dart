import 'package:email_firebase/Utils/Notification_Service.dart';
import 'package:email_firebase/addData/add_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'FireBase/View/home_screen.dart';
import 'LoginPage/View/login_screen.dart';
import 'SignUpPage/signup_screen.dart';
import 'SplashScreen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.notificationService.init();
  runApp(Sizer(
    builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(
            name: '/',
            page: () => SplashScreen(),
          ),
          GetPage(
            name: '/login',
            page: () => LoginScreen(),
          ),
          GetPage(
            name: '/signUp',
            page: () => SignUpScreen(),
          ),
          GetPage(
            name: '/home',
            page: () => HomeScreen(),
          ),
          GetPage(
            name: '/addData',
            page: () => AddDataScreen(),
          ),
        ],
      );
    },
  ));
}
