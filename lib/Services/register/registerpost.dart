import 'dart:convert';

import 'package:api_test/Services/share_preferences/localstorage.dart';
import 'package:api_test/Utils/api.link.dart';
import 'package:api_test/Utils/route.dart';
import 'package:api_test/Utils/toast.dart';
import 'package:api_test/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:platform_device_id_v3/platform_device_id.dart';

class RegisterPost {
  validateUser({required String email, required BuildContext context}) async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    
    var res = await http.post(
      Uri.parse(ApiLink().validateUser),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: json.encoder.convert({
        "Username": email,
        "DeviceId": deviceId.toString(),
        "isTrusted": "true"
      }),
    );
  
    var data = json.decode(res.body);
    if (data.toString() == "Code Sent") {
      Navigator.pushReplacementNamed(context, MyRoute().otpPageRoute);
    } else {
      currentUser.islogin = true;
      LocalStorage().setLogin();
      UserData().setToken(data.toString());
      Navigator.pushReplacementNamed(context, MyRoute().homePageRoute);
    }
    ;
  }

  gettingJsonToken(
      {required String email,
      required String otp,
      required BuildContext context}) async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    var res = await http.post(Uri.parse(ApiLink().gettingJsonToken),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: json.encoder.convert(
            {"Username": email, "DeviceId": deviceId.toString(), "Code": otp}));
    
    var data = json.decode(res.body);
   
    if (data["action"].toString() == "Failed") {
      toMassage(msg: "Invalid OTP");
    } else {
      if (data["code"] == "New User") {
        Navigator.pushReplacementNamed(context, MyRoute().registerPageRoute);
      } else {
        currentUser.islogin = true;
        LocalStorage().setLogin();
        UserData().setToken(data["code"].toString());
        Navigator.pushReplacementNamed(context, MyRoute().homePageRoute);
      }
    }
  }

  registerUser() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    var res = await http.post(Uri.parse(ApiLink().registerUser),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: json.encoder.convert({
          "FirstName": currentUser.firstName,
          "LastName": currentUser.lastName,
          "Email": currentUser.email,
          "PhoneNumber": currentUser.phoneNumber,
          "DisplayName": currentUser.userName,
          "DeviceId": deviceId.toString(),
        }));
  
    var data = json.decode(res.body);
   
    UserData().setToken(data.toString());
  }

  autoLogin() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    await http.post(Uri.parse(ApiLink().autoLoginUser),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: json.encoder.convert({
          "Username": currentUser.email,
          "DeviceId": deviceId.toString(),
        }));
  }
}
