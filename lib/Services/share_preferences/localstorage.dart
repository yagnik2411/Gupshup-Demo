import 'package:api_test/model/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  var local = SharedPreferences.getInstance();

  Future<String> getdata(String key) async {
    var pref = await local;
    return pref.getString(key)!;
  }

  setData(String key, String value) async {
    var pref = await local;
    pref.setString(key, value);
  }

  setLogin() async {
    var pref = await local;

    pref.setBool("isLogin", currentUser.islogin);
  }

  Future<bool> getLogin() async {
    var pref = await local;
    return  pref.getBool("isLogin") ?? false;
  }

  setRegister() async {
    var pref = await local;
    pref.setBool("isRegister", currentUser.isRegister);
  }

  Future<bool> getRegister() async {
    var pref = await local;
    return pref.getBool("isRegister") ?? false;
  }

  clearData() async {
    var pref = await local;
    pref.clear();
  }
}

class UserData {
  storeData() {
    LocalStorage().setData("email", currentUser.email);
    LocalStorage().setData("firstName", currentUser.firstName);
    LocalStorage().setData("lastName", currentUser.lastName);
    LocalStorage().setData("phoneNumber", currentUser.phoneNumber);
    LocalStorage().setData("userName", currentUser.userName);
    LocalStorage().setData("jsonToken", currentUser.jsonToken);
  }

  setToken(String token) async {
    await LocalStorage().setData("jsonToken", token);
  }

  getdata() async {
    currentUser.email = await LocalStorage().getdata("email");
    currentUser.firstName = await LocalStorage().getdata("firstName");
    currentUser.lastName = await LocalStorage().getdata("lastName");
    currentUser.phoneNumber = await LocalStorage().getdata("phoneNumber");
    currentUser.userName = await LocalStorage().getdata("userName");
    currentUser.jsonToken = await LocalStorage().getdata("jsonToken");
  }

  Future<String> getJsonToken() async {
    String s = await LocalStorage().getdata("jsonToken");
    currentUser.jsonToken = s;
    return s;
  }
}
