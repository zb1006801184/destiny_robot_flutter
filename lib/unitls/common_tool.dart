import 'package:flutter/material.dart';

class CommonTool {
  void goLogin(BuildContext context) {
    Navigator.of(context).pushNamed('/LoginPage');
  }

  String getHourTime(String timeStr) {
    if (timeStr != null) {
      DateTime time = DateTime.parse(timeStr);
      return '${time.hour}:${time.minute}';
    }
    return '0:00';
  }
}
