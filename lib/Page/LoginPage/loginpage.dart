import 'package:api_test/Page/LoginPage/loginBottom.dart';
import 'package:api_test/Services/share_preferences/localstorage.dart';
import 'package:api_test/Utils/route.dart';
import 'package:api_test/model/usermodel.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const LoginBottom(),
      body: Center(
        child: Container(
          color: Colors.white,
          height: 50,
          margin: const EdgeInsetsDirectional.only(bottom: 10, start: 5, end: 5),
          width: MediaQuery.of(context).size.width/2,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              elevation: MaterialStateProperty.all(2),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.black)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(55),
                ),
              ),
            ),
            onPressed: () {
              GetButtonProcess(context);
            },
            child: Text(
              getButtonName(),
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }

  String getButtonName() {
    if (currentUser.islogin == true) {
      return "Log Out";
    } else {
      return "Register/Login";
    }
  }

  void GetButtonProcess(BuildContext context) {
    if (currentUser.islogin == true) {
      currentUser.islogin = false;
      currentUser.isRegister = false;
      LocalStorage().setLogin();
      LocalStorage().setRegister();
      LocalStorage().clearData();

      Navigator.pushReplacementNamed(context, MyRoute().homePageRoute);
    } else if (currentUser.islogin == false && currentUser.isRegister == true) {
      Navigator.pushReplacementNamed(context, MyRoute().emailPageRoute);
    } else {
      Navigator.pushReplacementNamed(context, MyRoute().emailPageRoute);
    }
  }
}
