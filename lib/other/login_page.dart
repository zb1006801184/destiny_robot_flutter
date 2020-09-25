import 'package:destiny_robot/rotues/main/home_page.dart';
import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/material.dart';
import '../im/util/http_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as developer;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String pageName = "example.LoginPage";
  TextEditingController _assount = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.get("phone");
    String password = prefs.get("password");

    _assount.text = phone;
    _password.text = password;
  }

  void _loginAction() {
    Map map = new Map();
    map["region"] = 86;
    map["phone"] = int.parse(_assount.text);
    map["password"] = _password.text;

    HttpUtil.post("http://api.sealtalk.im/user/login", (data) {
      if (data != null) {
        Map body = data;
        int errorCode = body["code"];
        if (errorCode == 200) {
          Map result = body["result"];
          String id = result["id"];
          String token = result["token"];
          _saveUserInfo(_assount.text, token);
          developer.log("Login Success, $map", name: pageName);
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => new HomePage()),
              (route) => route == null);
        } else if (errorCode == -1) {
          Fluttertoast.showToast(msg: "网络未连接，请连接网络重试");
        } else {
          Fluttertoast.showToast(msg: "服务器登录失败，errorCode： $errorCode");
        }
      } else {
        developer.log("data is null", name: pageName);
      }
    }, params: map);
  }

  void _saveUserInfo(String id, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("id", id);
    prefs.setString("token", token);
    prefs.setString("phone", _assount.text);
    prefs.setString("password", _password.text);
  }

  @override
  Widget build(BuildContext context) {
    final logo = new Hero(
      tag: 'hero',
      child: Container(
        width: 100,
        height: 100,
        child: Image.asset('assets/images/logo.png'),
      ),
    );

    final account = TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      controller: _assount,
      decoration: InputDecoration(
          hintText: 'SealTalk 账号',
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _password,
      decoration: InputDecoration(
          hintText: 'SealTalk 密码',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: MaterialButton(
        minWidth: 200.0,
        height: 42.0,
        onPressed: () {
          _loginAction();
        },
        color: Colors.lightBlueAccent,
        child: Text(
          '登 录',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    AppBar appBar = AppBar(
      elevation: 0,
      leading: IconButton(
          icon: Image.asset('assets/images/login_nav_del.png'),
          onPressed: () {
            print('object');
          }),
      actions: [
        IconButton(
            icon: Image.asset('assets/images/login_icon_phone.png'),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              print('object1');
            })
      ],
    );
    //底部按钮
    final _bottomWidget = Positioned(
      bottom: 40,
      left: (Global.ksWidth - 146) / 2,
      child: Container(
        width: 146,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '问题反馈',
              style: TextStyle(color: Color(0xFFFF010101), fontSize: 13),
            ),
            Container(
              width: 1,
              height: 16.5,
              color: Color(0xFFFFD1D1D1),
            ),
            Text(
              '找回账号',
              style: TextStyle(color: Color(0xFFFF010101), fontSize: 13),
            ),
          ],
        ),
      ),
    );
    //标题
    final _titleWidget = Container(
      width: Global.ksWidth,
      padding: EdgeInsets.only(left: 17, top: 36),
      child: Text(
        '手机号登录',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );

    //输入框
    final _inputWidget = Container(
      width: Global.ksWidth,
      padding: EdgeInsets.only(left: 41.5, top: 49, right: 41.5),
      child: Row(
        children: [
          Text(
            '+86',
            style: TextStyle(
                color: Color(0xFFFF000000),
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
          Container(
            width: 1,
            height: 16.5,
            margin: EdgeInsets.only(left: 17, right: 17),
            color: Color(0xFFFFD1D1D1),
          ),
          Expanded(
              child: Container(
            height: 30,
            child: TextField(
              controller: _assount,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 0,bottom: 12),
                  hintText: '请输入电话号码',
                  hintStyle: TextStyle(fontSize: 15)
                  ),
            ),
          ))
        ],
      ),
    );

    return Scaffold(
        appBar: appBar,
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            children: [
              InkWell(
                child: Container(
                  width: Global.ksWidth,
                  height: Global.ksHeight,
                  child: Column(
                    children: [
                      _titleWidget,
                      _inputWidget,
                    ],
                  ),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
              _bottomWidget,
            ],
          ),
        ));
  }
}
