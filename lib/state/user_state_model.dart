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

  //保存token
  savaTokenInfo(UserInfoModel model) async {
    String data = jsonEncode(model.toJson());
    SpUtil.setBool(DataName.LOGINSTATE, true);
    SpUtil.setString(DataName.TOKENINFO, data);
    Global.tokenModel = model;
    notifyListeners();
  }

  //保存用户个人信息
  savaUserInfo(UserInfoModel model) async {
    String data = jsonEncode(model.toJson());
    SpUtil.setString(DataName.PERSONINFO, data);
    Global.userModel = model;
    notifyListeners();
  }

  //返回全局用户信息
  UserInfoModel userInfoModel() {
    UserInfoModel userModel;
    var _userInfoModel = SpUtil.getString(DataName.PERSONINFO);
    if (_userInfoModel != null) {
      try {
        userModel = UserInfoModel.fromJson(jsonDecode(_userInfoModel));
      } catch (e) {
        print(e);
        userModel = null;
      }
    }
    return userModel;
  }
}
