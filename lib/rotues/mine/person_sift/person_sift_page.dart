import 'package:city_pickers/city_pickers.dart';
import 'package:destiny_robot/models/sift_model.dart';
import 'package:destiny_robot/network/api_service.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:destiny_robot/unitls/widget_unitls.dart';
import 'package:destiny_robot/widgets/mine_common_item.dart';
import 'package:destiny_robot/widgets/single_select_picker.dart';
import 'package:flutter/material.dart';
import '../../../widgets/scope_select_picker.dart';
import '../../../widgets/interest_select_widget.dart';
import '../../../unitls/local_data.dart';

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
    '硕士',
    '博士',
  ];
  final List _sexs = ['男', '女', '不限'];

  SiftModel _model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configData();
  }

  void _configData() async {
    _model = await ApiService.getMatchRequest();
    setState(() {});
  }

//item click

  _itemClick(int index) async {
    if (index == 1 || index == 0) {
      //年龄 身高
      List data = index == 1 ? heights : ages;
      showScopePicker(context, (e) {
        if (e != null) {
          _request(index, e);
        }
      }, leftDataList: data[0], rightDataList: data[1]);
    }

    if (index == 2) {
      //学历
      showPicker(context, (e) {
        if (e != null) {
          _request(index, e);
        }
      }, dataList: _education);
    }
    if (index == 3) {
      //性别
      showPicker(context, (e) {
        _request(index, e);
      }, dataList: _sexs);
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
      _request(index, '${result.provinceName}-${result.cityName}');
    }

    if (index == 5) {
      InterestSelectWidget().showInterestSelect(
          context, LocalData().intersTitles, sureCallBack: (e) {
        try {
          _request(index, '',);
        } catch (r) {
          print(r);
        }
      });
    }
  }

  void _request(int index, var value, {List<dynamic> interestList}) async {
    Map params = {};
    try {
      _setValue(index, value,);
    } catch (e) {
      print(e);
    }
    params = {
      'ageMax': _model.ageMax,
      'ageMin': _model.ageMin,
      'education': _model.education,
      'gender': _model.gender,
      'heightMax': _model.heightMax,
      'heightMin': _model.heightMin,
      'hometown': _model.hometown,
      'interestList':null
    };

    ApiService.saveMatchRequest(params ?? {}).then((e) {});
  }

  void _setValue(int index, var value, {List<dynamic> interestList}) {
    String data = value??'';
    if (index == 0) {
      _model.ageMin = int.parse(data.substring(0, 2));
      _model.ageMax = int.parse(data.substring(4, 6));
    }
    if (index == 1) {
      _model.heightMin = int.parse(data.substring(0, 3));
      _model.heightMax = int.parse(data.substring(6, 9));
    }
    if (index == 2) {
      _model.education = WidgetUnitls().educationIndex(data);
    }
    if (index == 3) {
      _model.gender = WidgetUnitls().genderInt(data);
    }
    if (index == 4) {
      _model.hometown = data;
    }
    if (index == 5) {
      // try{
      //         _model.interestList = interestList;
      // }catch(e) {
      //   print(e);
      // }
      _model.interestList = ['12','234'];
    }

    setState(() {});
  }

  bool _isShowContent(int index) {
    if (_model == null) return false;
    if (index == 0 && _model.ageMin != null && _model?.ageMin > 0) {
      return true;
    }
    if (index == 1 && _model.heightMin != null && _model?.heightMin > 0) {
      return true;
    }
    if (index == 2 && _model?.education != null) {
      return true;
    }
    if (index == 3 && _model?.gender != null) {
      return true;
    }
    if (index == 4 && _model?.hometown != null && _model.hometown.length > 0) {
      return true;
    }
    if (index == 4 && _model?.interestList != null) {
      return true;
    }

    return false;
  }

  String _showContent(int index) {
    if (_model == null) return '';

    if (index == 0 && _model.ageMin != null && _model?.ageMin > 0) {
      return '${_model.ageMin}岁' + '-' + '${_model.ageMax}岁';
    }
    if (index == 1 && _model.heightMin != null && _model?.heightMin > 0) {
      return '${_model.heightMin}CM' + '-' + '${_model.heightMax}CM';
      ;
    }
    if (index == 2 && _model?.education != null) {
      return WidgetUnitls().educationStr(_model.education);
    }
    if (index == 3 && _model?.gender != null) {
      return WidgetUnitls().genderStr(_model.gender);
    }
    if (index == 4 && _model?.hometown != null && _model.hometown.length > 0) {
      return _model.hometown;
    }
    if (index == 4 && _model?.interestList != null) {
      return WidgetUnitls().interestStr(_model.interestList);
    }

    return _placerTitles[index];
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
            placerTitle: _showContent(index),
            isShowContent: _isShowContent(index),
          );
        },
        itemCount: _titles.length,
      ),
    );
  }
}
