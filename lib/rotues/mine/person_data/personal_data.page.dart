import 'package:city_pickers/city_pickers.dart';

import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:destiny_robot/widgets/edit_detai_widget.dart';
import 'package:destiny_robot/widgets/single_select_picker.dart';

import 'package:flutter/material.dart';
import '../../../widgets/mine_common_item.dart';
import '../../../widgets/edit_detai_widget.dart';

//我-编辑资料-个人信息
class PersonalDataPage extends StatefulWidget {
  @override
  _PersonalDataPageState createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  final _titles = ['昵称', 'ID', '性别', '生辰', '身高', '现居住地'];
  final _placerTitles = [
    '请输入小于16个字的昵称',
    '123456789',
    '请选择性别',
    '请选择生辰',
    '请选择身高',
    '请选择居住地'
  ];
  final _heights = [
    '155CM',
    '160CM',
    '165CM',
    '170CM',
    '175CM',
    '180CM',
    '190CM',
  ];
  final _sexs = ['男', '女'];

  //item 点击
  void _itemClick(int index) async {
    if (index == 1) return;
    if (index == 4 || index == 2) {
      //身高 性别
      showPicker(
        context,
        (e) {
          if (e != null) {
            print(e);
          }
        },
        dataList: index == 4 ? _heights : _sexs,
      );
    } else if (index == 5) {
      //现居住地
      Result result = await CityPickers.showCityPicker(
        context: context,
        height: 180,
        showType: ShowType.pc,
        theme: ThemeData(accentColor: Colors.red),
        cancelWidget: Text(
          '取消',
          style: TextStyle(fontSize: 14, color: Color(0xFF706864)),
        ),
        confirmWidget: Text(
          '完成',
          style: TextStyle(fontSize: 14, color: Color(0xFFFF706E)),
        ),
      );

      print(result.provinceName);
    } else {
      //编辑框
      showEditeBox(context, (e) {
        if (e != null) {
          print(e);
        }
      }, title: _titles[index]);
    }
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
        String title = _titles[index];
        return MineCommonItem(
          title: title,
          placerTitle: _placerTitles[index],
          index: index,
          itemClick: _itemClick,
          isShowStar: title == '性别' || title == '生辰' ? true : false,
          isShowContent: title == 'ID' ? true : false,
        );
      },
      itemCount: _titles.length,
    );
  }
}
