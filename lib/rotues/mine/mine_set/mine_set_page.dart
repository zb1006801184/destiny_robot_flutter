import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:flutter/material.dart';
class MineSetPage extends StatefulWidget {
  @override
  _MineSetPageState createState() => _MineSetPageState();
}

class _MineSetPageState extends State<MineSetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar('设置', context),
      body: Center(child: Text('data'),),
    );
  }
}