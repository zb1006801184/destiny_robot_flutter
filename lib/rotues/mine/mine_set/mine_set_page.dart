import 'package:destiny_robot/rotues/login/login_page.dart';
import 'package:destiny_robot/unitls/data_name_unitls.dart';
import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:destiny_robot/unitls/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart' as prefix;
import '../../../widgets/mine_set_item.dart';

class MineSetPage extends StatefulWidget {
  @override
  _MineSetPageState createState() => _MineSetPageState();
}

class _MineSetPageState extends State<MineSetPage> {
  final List _titles = ['新消息通知', '关于我们'];
  final List _icons = [
    'assets/images/set_icon_new.png',
    'assets/images/set_icon_us.png'
  ];

  //item click
  void _itemClick(int index) {
    List items = ['/MineSetNotifyPage', '/MineSetAboutPage'];
    Navigator.of(context).pushNamed(items[index]);
  }

  void _logout() async {
    prefix.RongIMClient.disconnect(false);
    SpUtil.remove(DataName.LOGINSTATE);
        SpUtil.remove(DataName.PERSONINFO);

    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) => new LoginPage()),
        (route) => route == null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar('设置', context),
      body: Stack(
        children: [
          _listWidget(),
          _bottomButton(),
        ],
      ),
    );
  }

  Widget _bottomButton() {
    return Positioned(
        left: 14.5,
        right: 14.5,
        bottom: 17,
        child: InkWell(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
                color: Color(0xFFFF6F6D),
                borderRadius: BorderRadiusDirectional.circular(22)),
            child: Center(
              child: Text(
                '退出登录',
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
          ),
          onTap: _logout,
        ));
  }

  Widget _listWidget() {
    return Container(
        width: Global.ksWidth,
        height: Global.ksHeight,
        margin: EdgeInsets.only(top: 4),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              child: MineSetItem(title: _titles[index], icon: _icons[index]),
              onTap: () {
                _itemClick(index);
              },
            );
          },
          itemCount: _titles.length,
        ));
  }
}
