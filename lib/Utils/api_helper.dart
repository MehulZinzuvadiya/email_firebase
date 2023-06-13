import 'dart:convert';
import 'dart:io';

import 'package:email_firebase/Utils/firebase_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  Future<String> postApiCall(String subtitle, String title) async {
    String? apiLink = "https://fcm.googleapis.com/fcm/send";
    Uri uri = Uri.parse(apiLink);
    final body = {
      "to":
          "cj_duMQSQUiefCQIULDbut:APA91bESDIrVXmXJw5fVrCSEAILAyYJwOCbaez-OmkoZLeLqjPW5ZfcDyDThOf1czXL5YDLtI2w9dfqoTnBc7Co8kgSX9JZAs-3MhXzB6M7TLOONXz0oCZSzL9vRP31hE3pBWnldD9nW",
      "notification": {
        "body": subtitle,
        "title": title,
      }
    };
    var response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'key=AAAAxiI5hIc:APA91bFoKMepaMTzRnhofiIKxZS0eLfUnQ2X_sLD40UnQAjgdCK8_PjlLT2XKdnEBkQp-DwNB_E2Dcn_4a7i-uSyOhkBcASrfOoddAYf0yeVd9HsjywHnboai-2uA_KS_ny46EUiuy90'
      },
    );
    if (response.statusCode == 200) {
      return "message sent!!";
    }
    return "Something went wrong";
  }
}
