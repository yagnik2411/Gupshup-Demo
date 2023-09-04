import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


toMassage({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    fontSize: 10,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    backgroundColor: Colors.blueAccent,
  );
}
