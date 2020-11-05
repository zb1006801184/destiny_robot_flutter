import 'package:city_pickers/city_pickers.dart';
import 'package:destiny_robot/network/api_service.dart';
import 'package:destiny_robot/state/provider_store.dart';
import 'package:destiny_robot/state/user_state_model.dart';

import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:destiny_robot/unitls/widget_unitls.dart';
import 'package:flutter/material.dart';
import '../../../widgets/mine_common_item.dart';
import '../../../widgets/single_select_picker.dart';
import '../../../widgets/edit_detai_widget.dart';
import '../../../widgets/interest_select_widget.dart';
import '../../../unitls/local_data.dart';
//编辑资料-基本信息

class PersonalBaseDataPage extends StatefulWidget {
  @override
  _PersonalBaseDataPageState createState() => _PersonalBaseDataPageState();
}

class _PersonalBaseDataPageState extends State<PersonalBaseDataPage> {
  final List _titles = ['学历', '学校', '专业', '家乡', '兴趣'];
  final List _placerTitles = ['请选择学历', '请输入学校名称', '请输入专业名称', '请选择家乡', '请选择兴趣'];
  final List _educations = ['高中', '专科', '本科', '硕士', '博士'];

  //item 的点击
  void _itemClick(int index) async {
    if (index == 0) {
      //学历
      showPicker(context, (e) {
        if (e != null) {
          _request(index, e);
        }
      }, dataList: _educations);
    } else if (index == 3) {
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
      _request(index, '${result.provinceName}-${result.cityName}');
    } else if (index == 4) {
      InterestSelectWidget().showInterestSelect(
          context, LocalData().intersTitles, sureCallBack: (data) {
        if (data.length > 0) {
          _request(index, data);
        }
      });
    } else {
      //编辑框
      showEditeBox(context, (e) {
        if (e != null) {
          _request(index, e);
        }
      }, title: _titles[index]);
    }
  }

  Future<String> _educationParam(String education) async {
    if (education == '高中') {
      return '1';
    }
    if (education == '专科') {
      return '2';
    }
    if (education == '本科') {
      return '3';
    }
    if (education == '硕士') {
      return '4';
    }
    if (education == '博士') {
      return '5';
    }
    return '0';
  }

  _updateInfo(int index, var value) {
    if (index == 0) {
      Global.userModel.education = int.parse(value);
    }
    if (index == 1) {
      Global.userModel.school = value;
    }
    if (index == 2) {
      Global.userModel.major = value;
    }
    if (index == 3) {
      Global.userModel.hometown = value;
    }
    if (index == 4) {
      Global.userModel.interest = value;
    }
    setState(() {});
  }

  void _request(int index, var value) async {
    List params = ['education', 'school', 'major', 'hometown', 'interest'];
    if (index == 0) {
      value = await _educationParam(value);
    }
    await ApiService.alterUserBaseInfoRequest({'${params[index]}': value});
    _updateInfo(index, value);
    savaUserInfo();
    print('修改成功');
  }

  void savaUserInfo() {
    Store.value<UserStateModel>(context, listen: false)
        .savaUserInfo(Global.userModel);
  }

  String interestStr(List intersest) {
    String result = '';
    if (intersest != null && intersest.length > 0) {
      intersest.forEach((e) => result = result + '、' + e);
      return result?.substring(1);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    var contents = [
      WidgetUnitls().educationStr(Global.userModel.education) ??
          _placerTitles[0],
      Global.userModel.school ?? _placerTitles[1],
      Global.userModel.major ?? _placerTitles[2],
      Global.userModel.hometown ?? _placerTitles[3],
      interestStr(Global.userModel.interest) ?? _placerTitles[4]
    ];
    var isShowContents = [
      Global.userModel.education != null ? true : false,
      Global.userModel.school != null ? true : false,
      Global.userModel.major != null ? true : false,
      Global.userModel.hometown != null ? true : false,
      Global.userModel.interest != null ? true : false,
    ];
    return Scaffold(
      appBar: NavBarConfig().configAppBar('基本信息', context),
      body: ListView.builder(
        itemBuilder: (context, index) {
          String title = _titles[index];
          return MineCommonItem(
            index: index,
            title: title,
            itemClick: _itemClick,
            placerTitle: contents[index],
            isShowContent: isShowContents[index],
            isShowStar: title == '学校' || title == '专业' ? true : false,
          );
        },
        itemCount: _titles.length,
      ),
    );
  }
}
