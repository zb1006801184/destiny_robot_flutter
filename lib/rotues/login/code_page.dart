import 'dart:async';

import 'package:destiny_robot/im/util/http_util.dart';
import 'package:destiny_robot/models/user_info_model.dart';
import 'package:destiny_robot/network/api_service.dart';
import 'package:destiny_robot/rotues/main/home_page.dart';
import 'package:destiny_robot/state/provider_store.dart';
import 'package:destiny_robot/state/user_state_model.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:destiny_robot/widgets/lcfarm_code_input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:developer' as developer;

class CodePage extends StatefulWidget {
  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  Timer _timer;
  int _count = 0;
  String _codeButtonString = '发送验证码';
  String _code;

  codeButtonClick() {
    if (_count > 0) return;
    _count = 60;
    _timer = Timer.periodic(Duration(milliseconds: 1000), (t) {
      _count--;
      setState(() {
        _codeButtonString = _count == 0 ? '重新发送' : '重新发送' + '(${_count}s)';
      });
      if (_count == 0) {
        t.cancel();
      }
    });
  }

  void _loginAction() async {
    
    Map map = new Map();
    map["region"] = 86;
    map["phone"] = 15070925726;
    map["password"] = 'Zb368464';
    //token信息
    UserInfoModel model =
        await ApiService.getOauthTokenRequest('15070925727', '1234');
    Store.value<UserStateModel>(context, listen: false).savaTokenInfo(model);
    //获取个人信息
    UserInfoModel userModel =
        await ApiService.getUserInfoRequest().catchError((e) {
      print(e);
    });
    Store.value<UserStateModel>(context, listen: false).savaUserInfo(userModel);
    ApiService.getRongYunTokenRequest().then((value) {
      _saveUserInfo('15070925727', value['data']['rongToken']);
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => new HomePage()),
          (route) => route == null);
    });
    return;



    //http://api-sealtalk.rongcloud.cn/user/login
    //http://api.sealtalk.im/user/login
    HttpUtil.post("http://api-sealtalk.rongcloud.cn/user/login", (data) {
      if (data != null) {
        Map body = data;
        int errorCode = body["code"];
        if (errorCode == 200) {
          Map result = body["result"];
          String id = result["id"];
          String token = result["token"];
          _saveUserInfo('15070925726', token);
          developer.log("Login Success, $map", name: 'pageName');
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => new HomePage()),
              (route) => route == null);
        } else if (errorCode == -1) {
          Fluttertoast.showToast(msg: "网络未连接，请连接网络重试");
        } else {
          Fluttertoast.showToast(msg: "服务器登录失败，errorCode： $errorCode");
        }
      } else {
        developer.log("data is null", name: 'pageName');
      }
    }, params: map);
  }

  void _saveUserInfo(String id, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("id", id);
    prefs.setString("token", token);
    prefs.setString("phone", '15070925726');
    prefs.setString("password", 'Zb368464');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar('', context),
      body: Container(
        color: Color(0xffffffff),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 36.0, left: 32.0),
              child: Text(
                '输入验证码',
                style: TextStyle(
                  color: Color(0xFFFF000000),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _inputCode(),
            Container(
              margin: EdgeInsets.only(left: 40.0),
              child: Text(
                '验证码已发送至18612340968',
                style: TextStyle(
                    color: Color(0xFFFF010101),
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ),
            _sureButton(),
          ],
        ),
      ),
    );
  }

  Widget _inputCode() {
    return Container(
      padding: EdgeInsets.only(left: 40.0, top: 15.0, right: 40.0),
      child: CodeInputTextField(
        countdown: 0,
        codeLength: 4,
        autoFocus: true,
        onSubmit: (code) {
          print('submit code:$code');
          //登录
          _loginAction();
        },
      ),
    );
  }

  Widget _sureButton() {
    return GestureDetector(
      child: UnconstrainedBox(
        child: Container(
          height: 44,
          width: 245,
          margin: EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
              color: Color(0xFFFFD2D2D2),
              borderRadius: BorderRadius.circular(22)),
          child: Center(
            child: Text(
              _codeButtonString,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      onTap: () {
        codeButtonClick();
      },
    );
  }
}
