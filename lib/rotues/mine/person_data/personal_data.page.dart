import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:destiny_robot/widgets/edit_detai_widget.dart';
import 'package:flutter/material.dart';
import '../../../widgets/mine_common_item.dart';

//我-编辑资料-个人信息
class PersonalDataPage extends StatefulWidget {
  @override
  _PersonalDataPageState createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  final _titles = ['昵称', '性别', '生辰', '身高', '现居住地'];
  final _placerTitles = ['请输入小于16个字的昵称', '请选择性别', '请选择生辰', '请选择身高', '请选择居住地'];
  //item 点击
  void _itemClick(int index) {
    Navigator.of(context)
        .push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) =>
                FadeTransition(
                    opacity: animation,
                    child: EditDetailWidget(
                      title: _titles[index],
                    ))))
        .then((e) {
      print(e + 'zz');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar('个人信息', context),
      body: Column(
        children: [_buildHeadImage(), Expanded(child: _buildList())],
      ),
    );
  }

  //顶部选择头像
  Widget _buildHeadImage() {
    return Container(
      height: 153,
      width: Global.ksWidth,
      color: Colors.white,
      padding: EdgeInsets.only(top: 11.5),
      child: Column(
        children: [
          Container(
            width: 93,
            height: 93,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(93 / 2)),
            child: Stack(
              children: [
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 24,
                      height: 24,
                      color: Colors.blue,
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7),
            child: Text(
              '头像会用作公开资料',
              style: TextStyle(fontSize: 10, color: Color(0xFFD1D1D1)),
            ),
          ),
        ],
      ),
    );
  }

  //list item

  Widget _buildList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return MineCommonItem(
          title: _titles[index],
          placerTitle: _placerTitles[index],
          index: index,
          itemClick: _itemClick,
        );
      },
      itemCount: _titles.length,
    );
  }
}
