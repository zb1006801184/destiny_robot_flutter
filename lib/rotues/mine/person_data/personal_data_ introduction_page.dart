import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:flutter/material.dart';

//编辑资料-自我介绍
class PersonalDataIntroductionPage extends StatefulWidget {
  @override
  _PersonalDataIntroductionPageState createState() =>
      _PersonalDataIntroductionPageState();
}

class _PersonalDataIntroductionPageState
    extends State<PersonalDataIntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar('自我介绍', context),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _inputWidget(),
          _lines(),
          Expanded(child: InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          )),
          _bottomButton(),
        ],
      ),
    );
  }

//lines
  Widget _lines() {
    return Container(
      width: Global.ksWidth,
      height: 10,
      color: Colors.white,
    );
  }

//底部按钮
  Widget _bottomButton() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 17),
        height: 44,
        width: Global.ksWidth - 29,
        decoration: BoxDecoration(
            color: Color(0xFFFF6F6D),
            borderRadius: BorderRadiusDirectional.circular(22)),
        child: Center(
          child: Text(
            '提交',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
      ),
      onTap: () {
        print('提交');
      },
    );
  }

//输入框
  Widget _inputWidget() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 247.5,
      width: Global.ksWidth,
      color: Colors.white,
      child: TextField(
        style: TextStyle(fontSize: 15),
        showCursor: true,
        maxLength: 150,
        maxLines: 100,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: Color(0xFFAEAFB7), fontSize: 15),
            hintText: '请输入你的自我介绍'),
      ),
    );
  }
}
