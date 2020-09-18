import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:flutter/material.dart';

class PersonalBaseDataPage extends StatefulWidget {
  @override
  _PersonalBaseDataPageState createState() => _PersonalBaseDataPageState();
}

class _PersonalBaseDataPageState extends State<PersonalBaseDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar('基本信息', context),
      body: Center(child: Text('基本信息'),),
    );
  }
}