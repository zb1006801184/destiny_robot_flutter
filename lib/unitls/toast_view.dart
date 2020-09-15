import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastView extends StatelessWidget {
  String title;
  ToastView({
    Key key,
    this.title,
  }) : super(key: key);

  showMessage() {
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        // textColor: "linear-gradient(to right, #2A2A2A, #2A2A2A)",
        // webPosition: "center"
        );
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}