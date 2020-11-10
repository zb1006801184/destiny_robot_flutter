import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  String arguments;
  ReportPage({Key key, this.arguments}) : super(key: key);
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar('匿名举报', context),
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
