import 'package:destiny_robot/network/api_service.dart';
import 'package:destiny_robot/rotues/main/home_page.dart';
import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/platform_unitls.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jverify/jverify.dart';
import '../../im/util/http_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:developer' as developer;

import 'once_login_page.dart';

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
  Timer _timer;
  int _count = 0;
  String _codeButtonString = '获取验证码';
  bool isAgree = true;

  /// 统一 key
  final String f_result_key = "result";

  /// 错误码
  final String f_code_key = "code";

  /// 回调的提示信息，统一返回 flutter 为 message
  final String f_msg_key = "message";

  /// 运营商信息
  final String f_opr_key = "operator";

  String _platformVersion = 'Unknown';
  String _result = "token=";
  var controllerPHone = new TextEditingController();
  final Jverify jverify = new Jverify();
  bool _loading = false;
  String _token;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

//获取验证码
  codeButtonClick() {
    if (isAgree == false) {
      Fluttertoast.showToast(msg: "请勾选同意协议", gravity: ToastGravity.CENTER);
      return;
    }
    _count = 60;
    _timer = Timer.periodic(Duration(milliseconds: 1000), (t) {
      _count--;
      if (mounted) {
        setState(() {
        _codeButtonString = _count == 0 ? '获取验证码' : '$_count' + '秒后重新获取';
      });
      }
      
      if (_count == 0) {
        t.cancel();
      }
    });

    Navigator.of(context).pushNamed('/CodePage', arguments: _assount.text);
  }

//关闭按钮的点击

//一键登录的点击
  void oneButtonLogin() async {
    // FocusScope.of(context).requestFocus(FocusNode());
    loginAuth();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      elevation: 0,
      leading: IconButton(
          icon: Image.asset('assets/images/login_nav_del.png'),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            }
          }),
      actions: [
        IconButton(
            icon: Image.asset('assets/images/login_icon_phone.png'),
            onPressed: oneButtonLogin)
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
                contentPadding: EdgeInsets.only(left: 0, bottom: 12),
                hintText: '请输入电话号码',
                hintStyle: TextStyle(fontSize: 15),
                border: InputBorder.none,
              ),
            ),
          ))
        ],
      ),
    );
    final _lines = Container(
      width: Global.ksHeight,
      height: 0.8,
      margin: EdgeInsets.only(left: 40, right: 46, top: 8),
      color: Color(0xFFFFD1D1D1),
    );

    //是否同意协议
    final _agreement = Container(
      width: Global.ksWidth,
      padding: EdgeInsets.only(left: 40.5, right: 45, top: 19.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Image.asset(
              isAgree == true
                  ? 'assets/images/_s-login_checkbox_sel.png'
                  : 'assets/images/login_checkbox_cac.png',
              width: 15,
              height: 15,
            ),
            onTap: () {
              setState(() {
                isAgree = !isAgree;
              });
            },
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 10),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: '我已阅读并同意',
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF010101),
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                    text: '《使用协议》',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFFFFF6F6D),
                        fontWeight: FontWeight.w500),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        print('object');
                      }),
                TextSpan(
                  text: '和',
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF010101),
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                    text: '《隐私协议》',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFFFFF6F6D),
                        fontWeight: FontWeight.w500),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        print('object');
                      }),
                TextSpan(
                  text: '并授权恋爱机器人获得手机号码。',
                  style: TextStyle(
                      height: 2,
                      fontSize: 13,
                      color: Color(0xFF010101),
                      fontWeight: FontWeight.w500),
                ),
              ]),
            ),
          ))
        ],
      ),
    );

    //获取验证码按钮
    final _codeButton = GestureDetector(
      child: Container(
        height: 44,
        width: 245,
        margin: EdgeInsets.only(top: 23),
        decoration: BoxDecoration(
            color: _count > 0 ? Color(0xFFD1D1D1) : Color(0xFFFFFF6F6D),
            borderRadius: BorderRadius.circular(22)),
        child: Center(
          child: Text(
            _codeButtonString,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
          ),
        ),
      ),
      onTap: () {
        if (_count > 0) return;
        codeButtonClick();
      },
    );

    return Scaffold(
        appBar: appBar,
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
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
                      _lines,
                      _agreement,
                      _codeButton,
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

  /// SDK 请求授权一键登录
  void loginAuth() {
    setState(() {
      _loading = true;
    });
    jverify.checkVerifyEnable().then((map) {
      bool result = map[f_result_key];
      if (result) {
        final screenSize = MediaQuery.of(context).size;
        final screenWidth = screenSize.width;
        final screenHeight = screenSize.height;
        bool isiOS = PlatformUtils.isIOS;

        JVUIConfig uiConfig = JVUIConfig();

        uiConfig.navColor = Colors.white.value;
        uiConfig.navText = "";
        uiConfig.navReturnImgPath = "login_nav_del"; //图片必须存在

        uiConfig.logoWidth = 64;
        uiConfig.logoHeight = 64;
        //uiConfig.logoOffsetX = isiOS ? 0 : null;//(screenWidth/2 - uiConfig.logoWidth/2).toInt();
        uiConfig.logoOffsetY = 50;
        uiConfig.logoVerticalLayoutItem = JVIOSLayoutItem.ItemSuper;
        uiConfig.logoHidden = false;
        uiConfig.logoImgPath = "logo";

        uiConfig.numberFieldWidth = 200;
        uiConfig.numberFieldHeight = 40;
        uiConfig.numFieldOffsetY = 15;
        uiConfig.numberVerticalLayoutItem = JVIOSLayoutItem.ItemLogo;
        uiConfig.numberColor = Color(0xFFFF000000).value;
        uiConfig.numberSize = 15;

        uiConfig.sloganHidden = true;

        uiConfig.logBtnWidth = 245;
        uiConfig.logBtnHeight = 44;
        uiConfig.logBtnOffsetY = 80;
        uiConfig.logBtnVerticalLayoutItem = JVIOSLayoutItem.ItemNumber;
        uiConfig.logBtnText = "本机一键登录";
        uiConfig.logBtnTextColor = Colors.white.value;
        uiConfig.logBtnTextSize = 15;
        uiConfig.logBtnBackgroundPath = 'button_pink';
        uiConfig.loginBtnNormalImage = "button_pink"; //图片必须存在
        uiConfig.loginBtnPressedImage = "button_pink"; //图片必须存在
        uiConfig.loginBtnUnableImage = "button_pink"; //图片必须存在

        uiConfig.privacyHintToast =
            true; //only android 设置隐私条款不选中时点击登录按钮默认显示toast。

        uiConfig.privacyState = true; //设置默认勾选
        uiConfig.privacyCheckboxSize = 20;
        uiConfig.checkedImgPath = "check_image"; //图片必须存在
        uiConfig.uncheckedImgPath = "uncheck_image"; //图片必须存在
        uiConfig.privacyCheckboxInCenter = true;
        //uiConfig.privacyCheckboxHidden = false;

        // uiConfig.privacyOffsetX = isiOS ? (20 + uiConfig.privacyCheckboxSize) : null;
        uiConfig.privacyOffsetY = (Global.ksHeight - 550).toInt(); // 距离底部距离
        uiConfig.privacyOffsetX = 80;
        uiConfig.privacyVerticalLayoutItem = JVIOSLayoutItem.ItemLogin;
        uiConfig.clauseName = "使用协议";
        uiConfig.clauseUrl = "http://www.baidu.com";
        uiConfig.clauseBaseColor = Colors.black.value;
        uiConfig.clauseNameTwo = "隐私协议";
        uiConfig.clauseUrlTwo = "http://www.hao123.com";
        uiConfig.clauseColor = Colors.red.value;
        uiConfig.privacyText = ["登录即代表阅读并同意", "、", "和", "并授权恋爱机器人获得本机号码。"];
        uiConfig.privacyTextSize = 13;
        uiConfig.authStatusBarStyle = JVIOSBarStyle.StatusBarStyleDarkContent;
        uiConfig.privacyStatusBarStyle = JVIOSBarStyle.StatusBarStyleDefault;
        uiConfig.modelTransitionStyle =
            JVIOSUIModalTransitionStyle.CrossDissolve;

        uiConfig.statusBarColorWithNav = true;
        uiConfig.virtualButtonTransparent = true;

        uiConfig.privacyStatusBarColorWithNav = true;
        uiConfig.privacyVirtualButtonTransparent = true;

        uiConfig.needStartAnim = true;
        uiConfig.needCloseAnim = true;

        uiConfig.privacyNavColor = Colors.white.value;
        uiConfig.privacyNavTitleTextColor = Colors.black.value;
        uiConfig.privacyNavTitleTextSize = 16;

        uiConfig.privacyNavTitleTitle = null; //only ios
        uiConfig.privacyNavTitleTitle1 = "使用协议";
        uiConfig.privacyNavTitleTitle2 = "隐私协议";
        uiConfig.privacyNavReturnBtnImage = "login_nav_del"; //图片必须存在;

        JVCustomWidget textWidget =
            JVCustomWidget('123', JVCustomWidgetType.button);
        textWidget.title = "其他登录";
        textWidget.left = ((Global.ksWidth - 245) / 2).toInt();
        textWidget.top = 320;
        textWidget.width = 245;
        textWidget.height = 44;
        textWidget.titleFont = 15;
        textWidget.textAlignment = JVTextAlignmentType.center;
        textWidget.isClickEnable = true;
        textWidget.titleColor = Colors.white.value;
        textWidget.btnNormalImageName = 'button_pink';
        jverify.addClikWidgetEventListener('123', (eventId) {
          if ('123' == eventId) {
            jverify.dismissLoginAuthView();
          }
        });

        /// 添加自定义的 控件 到授权界面
        List<JVCustomWidget> widgetList = [
          textWidget,
        ];

        /// 步骤 1：调用接口设置 UI
        jverify.setCustomAuthorizationView(true, uiConfig,
            landscapeConfig: uiConfig, widgets: widgetList);

        /// 步骤 2：调用一键登录接口

        /// 方式一：使用同步接口 （如果想使用异步接口，则忽略此步骤，看方式二）
        /// 先，添加 loginAuthSyncApi 接口回调的监听
        jverify.addLoginAuthCallBackListener((event) {
          setState(() {
            _loading = false;
            _result = "监听获取返回数据：[${event.code}] message = ${event.message}";
          });
          print(
              "通过添加监听，获取到 loginAuthSyncApi 接口返回数据，code=${event.code},message = ${event.message},operator = ${event.operator}");
        });

        /// 再，执行同步的一键登录接口
        jverify.loginAuthSyncApi(autoDismiss: true);
      } else {
        Fluttertoast.showToast(msg: "网络条件不允许！");
      }
    });
  }

  Future<void> initPlatformState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.get("phone");
    String password = prefs.get("password");

    _assount.text = phone;
    _password.text = password;

    String platformVersion;

    // 初始化 SDK 之前添加监听
    jverify.addSDKSetupCallBackListener((JVSDKSetupEvent event) {
      print("receive sdk setup call back event :${event.toMap()}");
    });

    jverify.setDebugMode(true); // 打开调试模式
    jverify.setup(
        appKey: "f7f5f138d028e05467f8ac6b", //"你自己应用的 AppKey",
        channel: "devloper-default"); // 初始化sdk,  appKey 和 channel 只对ios设置有效

    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });

    /// 授权页面点击时间监听
    jverify.addAuthPageEventListener((JVAuthPageEvent event) {
      print("receive auth page event :${event.toMap()}");
    });
  }
}
