import 'package:flutter/material.dart';
import 'package:destiny_robot/state/them_model.dart';
import '../state/provider_store.dart';

class ThemUntil {
  static const String THEMSTATE = 'them_state'; //主题模式

 final ThemeData linghtData = ThemeData(
      textTheme: TextTheme(bodyText2: TextStyle(color: Color(0xFF181818))),
      scaffoldBackgroundColor: Color.fromRGBO(248, 251, 254, 1),
      primaryColor: Colors.white); //日间模式
  final ThemeData darktData = ThemeData(
      scaffoldBackgroundColor: Color(0xFF121212),
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))); //夜间模式

//导航栏颜色
  Color mainColor(BuildContext context) {
    return Store.value<ThemModel>(context).getThemeModel()
        ? Color(0xFF121212)
        : Color(0xFFFFFFFF);
  }

  //部分widget颜色
  Color widgetColor(BuildContext context) {
    return Store.value<ThemModel>(context).getThemeModel()
        ? Colors.white
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



}
