import 'package:flutter/material.dart';
import '../../unitls/nav_bar_config.dart';
class MapHome extends StatefulWidget {
  @override
  _MapHomeState createState() => _MapHomeState();
}

class _MapHomeState extends State<MapHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar('首页', context),
      body: Center(child: Text('首页'),),
    );
  }
}