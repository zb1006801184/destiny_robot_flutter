import 'package:flutter/material.dart';
class MapHome extends StatefulWidget {
  @override
  _MapHomeState createState() => _MapHomeState();
}

class _MapHomeState extends State<MapHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('地图'),),
      body: Center(child: Text('首页'),),
    );
  }
}