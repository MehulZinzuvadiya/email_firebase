import 'package:email_firebase/API/View/apiScreen.dart';
import 'package:email_firebase/Utils/Notification_Service.dart';
import 'package:email_firebase/addData/add_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'Ecommerce/FirstScreen/View/FirstScreen/first_screen.dart';
import 'Ecommerce/SecondPage/View/second_page.dart';
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
        // initialRoute: '/api',
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
            name: '/todo',
            page: () => HomeScreen(),
          ),
          GetPage(
            name: '/addData',
            page: () => AddDataScreen(),
          ),
          GetPage(
            name: '/api',
            page: () => APiScreen(),
          ),
          GetPage(
            name: '/eFirst',
            page: () => FirstScreen(),
          ),
          GetPage(
            name: '/eSecond',
            page: () => SecondPage(),
          ),
        ],
      );
    },
  ));
}
