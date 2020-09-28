import 'dart:convert';

import 'package:destiny_robot/models/user_info_model.dart';
import 'package:destiny_robot/unitls/data_name_unitls.dart';
import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/cupertino.dart';

import '../unitls/sp_util.dart';

class UserStateModel extends ChangeNotifier {
  //   调用 notifyListeners(); 依赖的widget自动刷新
  //是否登录
  bool isLogin() {
    bool isLogin = SpUtil.getBool(DataName.LOGINSTATE, defValue: false);
    return isLogin;
  }

  //token
  savaTokenInfo(UserInfoModel model) async {
    String data = jsonEncode(model.toJson());
    SpUtil.setBool(DataName.LOGINSTATE, true);
    SpUtil.setString(DataName.TOKENINFO, data);
    Global.tokenModel = model;
    notifyListeners();
  }
  //用户个人信息
  savaUserInfo(UserInfoModel model) async {
    String data = jsonEncode(model.toJson());
    SpUtil.setString(DataName.PERSONINFO, data);
    Global.userModel = model;
    notifyListeners();
  }
}
