import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:flutter/material.dart';

//我-编辑资料
class EditDataPage extends StatefulWidget {
  @override
  _EditDataPageState createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  final List _titles = ['个人信息', '基本信息', '自我介绍', '相册'];
  final pushVc = [
    '/PersonalDataPage',
    '/PersonalBaseDataPage',
    '/PersonalDataIntroductionPage',
    '/PersonalDataAlbumPage'
  ];
  //item 的点击
  void _itemClick(int index) {
    if (pushVc[index] != null) Navigator.of(context).pushNamed(pushVc[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar('编辑资料', context),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return _buildListItem(index);
        },
        itemCount: _titles.length,
      ),
    );
  }

  //list item

  Widget _buildListItem(int index) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: index == 0 ? 3 : 1),
        padding: EdgeInsets.only(left: 19.5, right: 19.5),
        width: Global.ksWidth,
        height: 55,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_titles[index]),
            Image.asset(
              'assets/images/list_icon_retu.png',
              width: 5,
              height: 9,
            ),
          ],
        ),
      ),
      onTap: () => _itemClick(index),
    );
  }
}
