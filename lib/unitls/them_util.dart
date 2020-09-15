import 'package:flutter/material.dart';
import 'package:destiny_robot/state/them_model.dart';
import '../state/provider_store.dart';

class ThemUntil {
  static const String THEMSTATE = 'them_state'; //主题模式

 final ThemeData linghtData = ThemeData(
      textTheme: TextTheme(bodyText2: TextStyle(color: Color(0xFF181818))),
      scaffoldBackgroundColor: Color(0xFFEDEDED),
      primaryColor: Color(0xFFff6472)); //日间模式
  final ThemeData darktData = ThemeData(
      scaffoldBackgroundColor: Color(0xFF121212),
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))); //夜间模式

//主题背景颜色
  Color mainColor(BuildContext context) {
    return Store.value<ThemModel>(context).getThemeModel()
        ? Color(0xFF121212)
        : Color(0xFFF4F5F7);
  }

  //部分widget颜色
  Color widgetColor(BuildContext context) {
    return Store.value<ThemModel>(context).getThemeModel()
        ? Color(0xFFF4F5F7)
        : Color(0xFF121212);
  }

  //部分图标颜色
  Color iconColor(BuildContext context) {
    return Store.value<ThemModel>(context).getThemeModel() ? Colors.grey : null;
  }

  //状态栏
  Brightness stateBarColor(BuildContext context) {
    return Store.value<ThemModel>(context).getThemeModel()
        ? Brightness.dark
        : Brightness.light;
  }

  //加载web蒙版背景颜色
  Color webBGColor(BuildContext context) {
    return Store.value<ThemModel>(context).getThemeModel()
        ? Color(0xFF121212)
        : Colors.transparent;
  }

  //评论底部颜色
  Color commentBottomColor(BuildContext context) {
    return Store.value<ThemModel>(context).getThemeModel()
        ? Color(0xFF181818)
        : Color(0xFFF4F5F7);
  }

  //白色/黑色
  Color settingColor(BuildContext context) {
    return Store.value<ThemModel>(context).getThemeModel()
        ? Color(0xFF181818)
        : Colors.white;
  }
}
