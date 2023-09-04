import 'package:api_test/Page/HomePage/home.body.dart';
import 'package:api_test/Page/HomePage/home.bottom.dart';
import 'package:api_test/Services/share_preferences/localstorage.dart';
import 'package:api_test/model/usermodel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
          
            return Scaffold(
              
              appBar: AppBar(),
              bottomNavigationBar: HomeBottom(),
              body: HomeBody(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  getDetails() async {
    currentUser.isRegister = await LocalStorage().getRegister();
    currentUser.islogin = await LocalStorage().getLogin();
  }
}
