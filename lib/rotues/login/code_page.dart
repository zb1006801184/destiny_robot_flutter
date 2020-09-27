import 'dart:async';

import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:destiny_robot/widgets/lcfarm_code_input.dart';
import 'package:flutter/material.dart';

class CodePage extends StatefulWidget {
  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  Timer _timer;
  int _count = 0;
  String _codeButtonString = '重新发送';

   codeButtonClick() {
     if(_count > 0) return;
    _count = 60;
    _timer = Timer.periodic(Duration(milliseconds: 1000), (t) {
      _count--;
      setState(() {
        _codeButtonString = _count == 0 ? '重新发送' : '重新发送'+'(${_count}s)';
      });
      if (_count == 0) {
        t.cancel();
      }
    });
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
        },
      ),
    );
  }

  Widget _sureButton() {
    return GestureDetector(child: UnconstrainedBox(
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
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    ),
    onTap: (){
      codeButtonClick();
    },
    );
  }
}
