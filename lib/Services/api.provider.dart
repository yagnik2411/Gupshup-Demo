import 'dart:async';
import 'dart:io';

import 'package:api_test/Services/share_preferences/localstorage.dart';
import 'package:http/http.dart' as http;

// ignore: library_prefixes
import 'api.endpoints.dart' as EndPoint;
import 'dashboard/custom.execption.dart';

class ApiProvider {
  static Future<dynamic> get(String url, {bool useBaseurl = false}) async {
    var responseJson;
    final String apiUrl = useBaseurl ? url : EndPoint.baseUrl + url;
    try {
      var uriUrl = Uri.parse(apiUrl);

      final response = await http.get(uriUrl);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  static Future<dynamic> post(String url) async {
    var responseJson;
    final String apiUrl = EndPoint.baseUrl + url;

    try {
      var uriUrl = Uri.parse(apiUrl);

      final response = await http.post(uriUrl, headers: await getheaders());
      
      responseJson = _response(response);
      
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  static Future<Map<String, String>> getheaders() async {
    String token = await UserData().getJsonToken();
    
    Map<String, String> headerData = {
      'Content-Type': 'application/json',
      "Authorization": 'Bearer $token'
    };
    
    return headerData;
  }

  static dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.body;
        return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorisedException(response.body);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
