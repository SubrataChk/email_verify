import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sizer/sizer.dart';

showMessage(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.redAccent,
      textColor: Colors.black,
      fontSize: 13.sp);
}
