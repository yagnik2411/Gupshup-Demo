import 'dart:convert';

import 'package:api_test/Page/HomePage/home.post.dart';
import 'package:api_test/Services/dashboard/dashboard.service.dart';
import 'package:api_test/model/dashboard_model.dart';
import 'package:api_test/model/usermodel.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String image = "";
  @override
  Widget build(BuildContext context) {
    return currentUser.islogin == true
        ? FutureBuilder(
            future: getDashboard(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: dashboardList.length,
                    itemBuilder: (context, index) {
                      image = "";

                      

                    

                      return HomePost( index: index);
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
        : const Center(child: Text("Please Login or Register"));
  }

  getDashboard() async {
    dashboardList = await getDashboardDetails() ?? [];
  }
}
