import 'package:flutter/material.dart';
class Mine extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('我的'),),
    );
  }
}