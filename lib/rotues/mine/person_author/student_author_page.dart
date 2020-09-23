import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:flutter/material.dart';

//我-学生认证
class StudentAuthorPage extends StatefulWidget {
  @override
  _StudentAuthorPageState createState() => _StudentAuthorPageState();
}

class _StudentAuthorPageState extends State<StudentAuthorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBarConfig()
            .configAppBar("学生认证", context, rightWidget: _actionsWidget()),
        body: ListView(
          children: [
            _selectImage(),
            _bottomText(),
          ],
        ));
  }

  //选择照片
  Widget _selectImage() {
    return Container(
      margin: EdgeInsets.only(top: 19),
      width: 282.5,
      height: 407.5,
      child: Image.asset('assets/images/student_card.png'),
    );
  }
//底部提示文本
  Widget _bottomText() {
    return UnconstrainedBox(
      child: Container(
        constraints: BoxConstraints(maxWidth: 270.5),
        margin: EdgeInsets.only(top: 60),
        child: Text(
          '说明：\n1、平台会严格保密您的个人信息，防止信息泄露\n2、您的个人信息我们只会与公安部对接验证您的信息真伪，并不做任何其他行为\n3、审核通过的用户才会对外显示。否则别的用户不能以任何方式看到您',
          style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 11,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
//右侧按钮
  List<Widget> _actionsWidget() {
    return [
      InkWell(
        child: Container(
          margin: EdgeInsets.only(right: 17),
          width: 44,
          child: Center(
            child: Text(
              '完成',
              style: TextStyle(
                  color: Color(0xFFFF6B6F),
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        onTap: () {
          print("完成");
        },
      )
    ];
  }
}
