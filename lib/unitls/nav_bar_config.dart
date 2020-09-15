import 'package:flutter/material.dart';
import 'package:destiny_robot/state/provider_store.dart';
import 'package:destiny_robot/state/them_model.dart';
import 'package:destiny_robot/unitls/them_util.dart';

class NavBarConfig {
  //默认导航栏样式
  AppBar configAppBar(String title, BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: ThemUntil().widgetColor(context), fontSize: 18),
      ),
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Store.value<ThemModel>(context).getThemeModel()
                ? Colors.white
                : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      backgroundColor: ThemUntil().mainColor(context),
      elevation: 0, //阴影辐射范围
      brightness: ThemUntil().stateBarColor(context),
    );
  }
//一级路由appBar
 AppBar configTabbarAppBar(String title, BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: ThemUntil().widgetColor(context), fontSize: 18),
      ),
      // leading: null,
      backgroundColor: ThemUntil().mainColor(context),
      elevation: 0, //阴影辐射范围
      brightness: ThemUntil().stateBarColor(context),
    );
  }

}
