import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:flutter/material.dart';
import '../../../widgets/mine_common_item.dart';
import '../../../widgets/single_select_picker.dart';

class PersonalBaseDataPage extends StatefulWidget {
  @override
  _PersonalBaseDataPageState createState() => _PersonalBaseDataPageState();
}

class _PersonalBaseDataPageState extends State<PersonalBaseDataPage> {
  final List _titles = ['学历', '学校', '专业', '家乡', '兴趣'];
  final List _placerTitles = ['请选择学历', '请输入学校名称', '请输入专业名称', '请选择家乡', '请选择兴趣'];
  //item 的点击
  void _itemClick(int index) {
    showPicker(context, (e){
      if (e != null) {
        print(e);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar('基本信息', context),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MineCommonItem(
            index: index,
            title: _titles[index],
            itemClick: _itemClick,
            placerTitle: _placerTitles[index],
          );
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
          children: [Text(_titles[index]), Icon(Icons.arrow_forward_ios)],
        ),
      ),
      onTap: () => _itemClick(index),
    );
  }
}
