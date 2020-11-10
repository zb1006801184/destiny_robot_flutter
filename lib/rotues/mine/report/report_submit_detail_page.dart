import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:flutter/material.dart';

class ReportSubmitDetailPage extends StatefulWidget {
  String arguments;
  ReportSubmitDetailPage({
    Key key,
    this.arguments,
  }) : super(key: key);
  @override
  _ReportSubmitDetailPageState createState() => _ReportSubmitDetailPageState();
}

class _ReportSubmitDetailPageState extends State<ReportSubmitDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar('匿名举报', context),
    );
  }
}
