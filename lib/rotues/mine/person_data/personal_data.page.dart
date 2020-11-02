import 'package:city_pickers/city_pickers.dart';
import 'package:destiny_robot/im/widget/cachImage/cached_image_widget.dart';
import 'package:destiny_robot/models/user_info_model.dart';
import 'package:destiny_robot/network/api_service.dart';
import 'package:destiny_robot/state/provider_store.dart';
import 'package:destiny_robot/state/user_state_model.dart';

import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:destiny_robot/widgets/edit_detai_widget.dart';
import 'package:destiny_robot/widgets/sample_select.dart';
import 'package:destiny_robot/widgets/single_select_picker.dart';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../widgets/mine_common_item.dart';
import '../../../widgets/edit_detai_widget.dart';
import '../../../widgets/pickCalendar/pickCalendar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

//我-编辑资料-个人信息
class PersonalDataPage extends StatefulWidget {
  @override
  _PersonalDataPageState createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  final _titles = ['昵称', 'ID', '性别', '生辰', '身高', '现居住地'];
  var _placerTitles = [
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
  final params = ['nickname', '', 'gender', 'birthday', 'height', 'address'];
  String headImage;
  UserInfoModel _userInfoModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userInfoModel = Global.userModel;
  }

  //item 点击
  void _itemClick(int index) async {
    String value;
    if (index == 1) return;
    if (index == 4 || index == 2) {
      //身高 性别
      showPicker(
        context,
        (e) {
          if (e != null) {
            value = e;
            _request(value, index);
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

      _request('${result.provinceName}-${result.cityName}', index);
    } else if (index == 3) {
      incrementCounter(context, callBack: (v) {
        _request(v, index);
      });
    } else {
      //编辑框
      showEditeBox(context, (e) async {
        if (e != null) {
          value = e;
          _request(value, index);
        }
      }, title: _titles[index]);
    }
  }

  void _request(value, int index) async {
    if (index == 2) {
      value == '男' ? value = '0' : value = '1';
    }
    if (index == 4) {
      value = value.substring(0, 3);
    }

    var respon = await ApiService.alterUserInfoRequest(
        index == 3 ? value : {params[index].toString(): value});

    if (respon == null) {
      return;
    }

    if (index == 0) {
      setState(() {
        _userInfoModel.nickname = value;
      });
    }
    if (index == 2) {
      setState(() {
        _userInfoModel.gender = int.parse(value);
      });
    }
    if (index == 3) {
      setState(() {
        _userInfoModel.birthdayStr = value['birthdayStr'];
      });
    }
    if (index == 4) {
      setState(() {
        _userInfoModel.height = int.parse(value);
      });
    }
    if (index == 5) {
      setState(() {
        _userInfoModel.address = value;
      });
    }
    savaUserInfo();
  }

  Future<void> _selectImage() async {
    var cameraStatus = await Permission.camera.status;
    var photosStatus = await Permission.photos.status;

    if (cameraStatus.isUndetermined || photosStatus.isUndetermined) {
      await Permission.camera.request();
      await Permission.photos.request();
    }
    showSampleSelect(context, dataList: ['拍照', '从相册中选择'],
        callBackHandler: (index) async {
      PickedFile image = await ImagePicker().getImage(
          source: index == 0 ? ImageSource.camera : ImageSource.gallery);
      headImage = image.path;
      var name =
          headImage.substring(headImage.lastIndexOf("/") + 1, headImage.length);
      FormData params = FormData.fromMap(
          {"file": await MultipartFile.fromFile(headImage, filename: name)});
      var url = await ApiService.uploadImageRequest(params);
      var respon = await ApiService.alterUserInfoRequest({'headImgUrl': url});
      setState(() {
        _userInfoModel.headImgUrl = url;
      });
      savaUserInfo();
    });
  }

  void savaUserInfo() {
    Store.value<UserStateModel>(context, listen: false)
        .savaUserInfo(_userInfoModel);
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
            child: Stack(
              children: [
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(93 / 2),
                    child: CachedNetworkImage(
                      width: 93,
                      height: 93,
                      fit: BoxFit.cover,
                      imageUrl: _userInfoModel.headImgUrl ?? '',
                      placeholder: (context, url) => Image.asset(
                        'assets/images/user_placer_image.jpg',
                        fit: BoxFit.cover,
                        height: 93,
                        width: 93,
                      ),
                    ),
                  ),
                  onTap: _selectImage,
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/personal_icon_camera.png'))),
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
          placerTitle: placerTitle(index),
          index: index,
          itemClick: _itemClick,
          isShowStar: title == '性别' || title == '生辰' ? true : false,
          isShowContent: isShowContent(index),
        );
      },
      itemCount: _titles.length,
    );
  }

  String placerTitle(int index) {
    if (index == 0 && _userInfoModel.nickname != null) {
      return _userInfoModel.nickname;
    }
    if (index == 1) {
      // return _userInfoModel.ID
    }
    if (index == 2 && _userInfoModel?.gender != null) {
      return _userInfoModel.gender == 0 ? '男' : '女';
    }
    if (index == 3 && _userInfoModel?.birthdayStr != null) {
      return _userInfoModel.birthdayStr;
    }
    if (index == 4 && _userInfoModel?.height != null) {
      return _userInfoModel.height.toString();
    }
    if (index == 5 && _userInfoModel?.address != null) {
      return _userInfoModel.address;
    }
    return _placerTitles[index];
  }

  bool isShowContent(int index) {
    if (index == 0 && _userInfoModel.nickname != null) {
      return true;
    }
    if (index == 1) {
      return true;
    }
    if (index == 2 && _userInfoModel.gender != null) {
      return true;
    }
    if (index == 3 && _userInfoModel.birthdayStr != null) {
      return true;
    }
    if (index == 4 && _userInfoModel.height != null) {
      return true;
    }
    if (index == 5 && _userInfoModel.address != null) {
      return true;
    }

    return false;
  }
}
