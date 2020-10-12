import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:flutter/material.dart';

class MineSetNotifyPage extends StatefulWidget {
  @override
  _MineSetNotifyPageState createState() => _MineSetNotifyPageState();
}

class _MineSetNotifyPageState extends State<MineSetNotifyPage> {
  // ==========widget==========
  Widget _titleWidget({String title}) {
    return Container(
      height: 46,
      width: Global.ksWidth,
      color: Colors.white,
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.only(top: 11, left: 16.5),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 15,
            color: Color(0xFFFF706863),
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _itemWidget({String title, String icon}) {
    return Container(
      height: 46,
      padding: EdgeInsets.only(left: 16, right: 17.5),
      color: Colors.white,
      width: Global.ksWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15, color: Color(0xFFFF000000)),
          ),
          Container(
            width: 30,
            height: 15,
            child: Image.asset(icon),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar('通知', context),
      body: ListView(
        children: [
          _titleWidget(title: '未打开恋爱机器人时'),
          _itemWidget(title: '新消息通知', icon: 'assets/images/switch_on.png'),
          _itemWidget(title: '通知显示详情', icon: 'assets/images/switch_off.png'),
          _titleWidget(title: '正在使用恋爱机器人时'),
          _itemWidget(title: '声音', icon: 'assets/images/switch_on.png'),
          _itemWidget(title: '振动', icon: 'assets/images/switch_off.png'),
        ],
      ),
    );
  }
}
