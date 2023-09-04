import 'dart:async';
import 'dart:convert';

import 'package:api_test/Services/api.provider.dart';
import 'package:api_test/model/dashboard_model.dart';

// ignore: library_prefixes
import '../api.endpoints.dart' as EndPoint;

Future<List<DashboardModel>?> getDashboardDetails() async {
 
  var response = await ApiProvider.post(EndPoint.dashboard);
  if (response != null) {
    
    var responseObject = (json.decode(response));
   

    List<DashboardModel> userList = responseObject
        .map((i) => DashboardModel.fromJson(i))
        .toList()
        .cast<DashboardModel>();

    final ids = userList.map((e) => e.id).toSet();
    userList.retainWhere((x) => ids.remove(x.id));

    final dash = userList.toSet().toList();

    return dash;
  }

  return null;
}
