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

  AppBar configCommenWriteAppBar(
      String title, BuildContext context, List actions) {
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
      actions: actions,
    );
  }

  AppBar configAppBarRobot(String title, BuildContext context) {
    Widget _buildLeadingWidget() {
      return GestureDetector(
        child: Container(
          padding: EdgeInsets.only(left: 18),
          //不添加装饰器空白部分无法响应点击
          decoration: BoxDecoration(),
          width: 32,
          height: 32,
          child: Row(
            children: [
              Image(
                image: AssetImage("images/nav_icon_back.png"),
                width: 10,
                height: 20,
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      );
    }

    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
      ),
      leading: _buildLeadingWidget(),
      backgroundColor: Store.value<ThemModel>(context).getThemeModel()
          ? Colors.black
          : Colors.white,
      elevation: 0, //阴影辐射范围
      brightness: Brightness.light,
    );
  }
}
