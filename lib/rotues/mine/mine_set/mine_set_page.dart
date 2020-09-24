import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:flutter/material.dart';
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
    List items = ['/MineSetAboutPage','/MineSetAboutPage'];
    Navigator.of(context).pushNamed(items[index]);
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
          onTap: () {
            print('退出登录');
          },
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
              onTap: (){
                _itemClick(index);
              },
            );
          },
          itemCount: _titles.length,
        ));
  }
}
