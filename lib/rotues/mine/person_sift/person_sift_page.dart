import 'package:city_pickers/city_pickers.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:destiny_robot/widgets/mine_common_item.dart';
import 'package:destiny_robot/widgets/single_select_picker.dart';
import 'package:flutter/material.dart';
import '../../../widgets/scope_select_picker.dart';

//我-筛选
class PersonSiftPage extends StatefulWidget {
  @override
  _PersonSiftPageState createState() => _PersonSiftPageState();
}

class _PersonSiftPageState extends State<PersonSiftPage> {
  final List _titles = ['年龄', '身高', '学历', '性别', '家乡', '兴趣'];
  final List _placerTitles = [
    '请选择年龄范围',
    '请选择身高范围',
    '请选择学历',
    '请选择性别',
    '请选择家乡',
    '请选择兴趣'
  ];

  final List heights = [
    ['160CM', '165CM', '170CM', '175CM', '180CM', '185CM'],
    ['160CM', '165CM', '170CM', '175CM', '180CM', '185CM'],
  ];
  final List ages = [
    ['20岁', '21岁', '22岁', '23岁', '24岁', '25岁', '26岁'],
    ['20岁', '21岁', '22岁', '23岁', '24岁', '25岁', '26岁']
  ];

  final List _education = [
    '高中',
    '大专',
    '本科',
    '研究生',
    '博士',
  ];
  final List _sexs = ['男','女'];

//item click

  _itemClick(int index) async{
    if (index == 1||index ==0) {
      //年龄 身高
      List data = index==1?heights:ages;
      showScopePicker(context, (e) {
        print(e);
      }, leftDataList: data[0], rightDataList: data[1]);
    }

  if (index == 2) {
    //学历
    showPicker(context, (){

    },
    dataList: _education
    );

  }
  if (index == 3) {
    //性别
    showPicker(context, (){

    },
    dataList: _sexs
    );
  }
  if (index == 4) {
    //家乡

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

  }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar('筛选条件', context),
      body: ListView.builder(
        itemBuilder: (context, index) {
          String title = _titles[index];
          return MineCommonItem(
            index: index,
            title: title,
            itemClick: _itemClick,
            placerTitle: _placerTitles[index],
            // isShowStar: title == '学校' || title == '专业' ? true : false,
          );
        },
        itemCount: _titles.length,
      ),
    );
  }
}
