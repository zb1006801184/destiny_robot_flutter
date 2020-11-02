import 'package:destiny_robot/models/user_info_model.dart';
import 'package:destiny_robot/network/api_service.dart';
import 'package:destiny_robot/state/provider_store.dart';
import 'package:destiny_robot/state/user_state_model.dart';
import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:destiny_robot/unitls/toast_view.dart';
import 'package:flutter/material.dart';

//编辑资料-自我介绍
class PersonalDataIntroductionPage extends StatefulWidget {
  @override
  _PersonalDataIntroductionPageState createState() =>
      _PersonalDataIntroductionPageState();
}

class _PersonalDataIntroductionPageState
    extends State<PersonalDataIntroductionPage> {
  TextEditingController _controller = TextEditingController();
  UserInfoModel _model;
  void _request() async {
    ApiService.saveUserDetailRequest({'details': _controller.text ?? ''})
        .then((value) {
      if (value != null) {
        ToastView(
          title: "提交成功！",
        ).showMessage();
        _model.details = _controller.text;
        Store.value<UserStateModel>(context, listen: false)
            .savaUserInfo(_model);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _model = Store.value<UserStateModel>(context, listen: true).userInfoModel();
    _controller.text = _model.details ?? '';
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
      onTap: _request,
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
        controller: _controller,
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
