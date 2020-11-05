import 'package:flutter/material.dart';

class CommonTool {
  void goLogin(BuildContext context) {
    Navigator.of(context).pushNamed('/LoginPage');
  }


  String getHourTime(String timeStr) {
    DateTime time = DateTime.parse(timeStr);
  if (timeStr != null) {
    return '${time.hour}:${time.minute}';
  }
    return '0:00';
  }
}
