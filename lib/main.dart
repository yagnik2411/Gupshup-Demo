import 'package:api_test/Page/register/emailpage.dart';
import 'package:api_test/Page/LoginPage/loginpage.dart';
import 'package:api_test/Page/register/otppage.dart';
import 'package:api_test/Page/register/registerpage.dart';
import 'package:api_test/Utils/route.dart';
import 'package:flutter/material.dart';

import 'Page/HomePage/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MyRoute().homePageRoute,
      routes: {
        MyRoute().homePageRoute: (context) => const HomePage(),
        MyRoute().emailPageRoute: (context) => const EmailPage(),
        MyRoute().otpPageRoute: (context) => const OtpPage(),
        MyRoute().registerPageRoute: (context) => const RegisterPage(),
        MyRoute().LoginPageRoute: (context) => const LoginPage(),
        
      },
    );
  }
}
