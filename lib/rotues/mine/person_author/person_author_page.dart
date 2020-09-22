import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:flutter/material.dart';
//我-实名认证
class PersonAuthorPages extends StatefulWidget {
  @override
  _PersonAuthorPagesState createState() => _PersonAuthorPagesState();
}

class _PersonAuthorPagesState extends State<PersonAuthorPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar("实名认证", context),
      body: ListView(
        children: [
          
        ],
      )
    );
  }
}
