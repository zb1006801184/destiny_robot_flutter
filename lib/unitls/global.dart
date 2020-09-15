import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Global {
//设备宽高
  static double ksWidth = _width;
  static double ksHeight = _height;
//导航栏的高度
  static double ksToolbarHeight = kToolbarHeight;
//状态栏高度
  static double ksStateHeight = MediaQueryData.fromWindow(window).padding.top;
  static double ksBottomBar = kBottomNavigationBarHeight;
  static double get _width {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
    return mediaQuery.size.width;
  }
  static double get _height {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
    return mediaQuery.size.height;
  }

}
