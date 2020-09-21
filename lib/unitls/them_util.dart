import 'package:flutter/material.dart';
import 'package:destiny_robot/state/them_model.dart';
import '../state/provider_store.dart';

class ThemUntil {
  static const String THEMSTATE = 'them_state'; //主题模式

  final ThemeData linghtData = ThemeData(
      textTheme: TextTheme(bodyText2: TextStyle(color: Color(0xFF181818))),
      scaffoldBackgroundColor: Color.fromRGBO(248, 251, 254, 1),
      primaryColor: Colors.white,
      primarySwatch: createMaterialColor(Color(0xFFFF6A70)),
      splashColor: Colors.green); //日间模式
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

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
