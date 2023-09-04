import 'package:api_test/Services/register/registerpost.dart';
import 'package:api_test/Services/share_preferences/localstorage.dart';
import 'package:api_test/Utils/route.dart';
import 'package:api_test/model/usermodel.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Register',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                TextFormField(
                  enabled: false,
                  initialValue: currentUser.email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    labelText: "Email",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {
                    currentUser.firstName = value;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    hintText: "eg: abcd",
                    hintStyle: TextStyle(
                      color: Colors.deepPurple.withOpacity(0.4),
                    ),
                    labelText: "First Name",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {
                    currentUser.lastName = value;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    hintText: "eg: abcd",
                    hintStyle: TextStyle(
                      color: Colors.deepPurple.withOpacity(0.4),
                    ),
                    labelText: "Last Name",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {
                    currentUser.userName = value;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    hintText: "eg: abcd",
                    hintStyle: TextStyle(
                      color: Colors.deepPurple.withOpacity(0.4),
                    ),
                    labelText: "Display Name",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {
                    currentUser.phoneNumber = value;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    hintText: "eg: 1234567890",
                    hintStyle: TextStyle(
                      color: Colors.deepPurple.withOpacity(0.4),
                    ),
                    labelText: "Phone Number",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    UserData().storeData();
                    currentUser.islogin = true;
                    currentUser.isRegister = true;
                    LocalStorage().setLogin();
                    await RegisterPost().registerUser();
                    Navigator.pushReplacementNamed(
                        context, MyRoute().homePageRoute);
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      const Size(100, 50),
                    ),
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
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )
                
              ],
            ),
          ),
        ));
  }

  
}
