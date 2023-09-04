import 'package:api_test/Services/share_preferences/localstorage.dart';
import 'package:api_test/Utils/route.dart';
import 'package:api_test/Utils/toast.dart';
import 'package:api_test/model/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginBottom extends StatelessWidget {
  const LoginBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 143, 180, 244).withOpacity(0.7), width: 1),
         ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, MyRoute().homePageRoute);
              },
              icon: Icon(Icons.feed)),
          IconButton(
              color: Colors.blue,
              onPressed: () {
                toMassage(msg: "Chat is not available");
              },
              icon: Icon(Icons.chat)),
          IconButton(
              color: Colors.blue,
              onPressed: () {
                toMassage(msg: "Groups is not available");
              },
              icon: Icon(CupertinoIcons.group)),
          IconButton(
              color: Colors.blue,
              onPressed: () {
                toMassage(msg: "Albums is not available");
              },
              icon: Icon(Icons.album_outlined)),
          IconButton(
              color: Colors.orange,
              onPressed: () {
                toMassage(msg: "Profile");
              },
              icon: Icon(CupertinoIcons.person))
        ],
      ),
    );
  }
}
