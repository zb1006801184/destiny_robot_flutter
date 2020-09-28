import 'dart:convert';
import 'dart:ui';
import 'package:destiny_robot/models/user_info_model.dart';
import 'package:destiny_robot/unitls/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data_name_unitls.dart';

class Global {
  //全局用户信息
  static UserInfoModel userModel;
  static UserInfoModel tokenModel;

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

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    var loginState = SpUtil.getBool(DataName.LOGINSTATE);
    if (loginState == true) {
      print("已登录");
    } else {
      print("未登录");
    }
    var _userInfoModel = SpUtil.getString(DataName.PERSONINFO);
    if (_userInfoModel != null) {
      try {
        userModel = UserInfoModel.fromJson(jsonDecode(_userInfoModel));
      } catch (e) {
        print(e);
      }
    }
    var _tokenModel = SpUtil.getString(DataName.TOKENINFO);
    if (_tokenModel != null) {
      try {
        tokenModel = UserInfoModel.fromJson(jsonDecode(_tokenModel));
      } catch (e) {
        print(e);
      }
    }
  }
}
