import 'package:destiny_robot/im/widget/cachImage/cached_image_widget.dart';
import 'package:destiny_robot/network/api_service.dart';
import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:destiny_robot/unitls/toast_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../widgets/sample_select.dart';
import 'package:image_picker/image_picker.dart';

//我-实名认证
class PersonAuthorPages extends StatefulWidget {
  @override
  _PersonAuthorPagesState createState() => _PersonAuthorPagesState();
}

class _PersonAuthorPagesState extends State<PersonAuthorPages> {
  final List titles = ['拍照', '从相册中选择'];
  //正面
  String _peopleImagePath;
  //反面
  String _reverseImagePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configData();
  }

  void configData() async {
    var data = await ApiService.getIDCardRequest();
    _peopleImagePath = data['data']['idCardFront'];
    _reverseImagePath = data['data']['idCardReverse'];
    setState(() {
    });
  }

  //选择照片
  void _selectImageClick(int selectIndex) async {
    var cameraStatus = await Permission.camera.status;
    var photosStatus = await Permission.photos.status;

    if (cameraStatus.isUndetermined || photosStatus.isUndetermined) {
      await Permission.camera.request();
      await Permission.photos.request();
    }
    showSampleSelect(context, dataList: titles, callBackHandler: (index) async {
      PickedFile image = await ImagePicker().getImage(
          source: index == 0 ? ImageSource.camera : ImageSource.gallery);

      String headImage = image.path;
      var name =
          headImage.substring(headImage.lastIndexOf("/") + 1, headImage.length);
      FormData params = FormData.fromMap(
          {"file": await MultipartFile.fromFile(headImage, filename: name)});
      var url = await ApiService.uploadImageRequest(params);

      setState(() {
        selectIndex == 0 ? _peopleImagePath = url : _reverseImagePath = url;
      });
    });
  }

//完成
  void _submitResult() async {
    if (_peopleImagePath == null) {
      ToastView(
        title: '人像面为空！',
      ).showMessage();
      return;
    }
    if (_reverseImagePath == null) {
      ToastView(
        title: '国徽面为空！',
      ).showMessage();
      return;
    }
    await ApiService.saveIDCardRequest(
        {'idCardFront': _peopleImagePath, 'idCardReverse': _reverseImagePath});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBarConfig()
            .configAppBar("实名认证", context, rightWidget: _actionsWidget()),
        body: ListView(
          children: [
            _selectImages(0),
            _selectImages(1),
            _bottomText(),
          ],
        ));
  }

  //正/反 选择证件照
  Widget _selectImages(int index) {
    List images = ['assets/images/ID_front.png', 'assets/images/ID_back.png'];
    String image;
    index == 0 ? image = _peopleImagePath : image = _reverseImagePath;
    return GestureDetector(
      child: Container(
        width: Global.ksWidth,
        padding: EdgeInsets.only(left: 49, right: 49, top: 20.5),
        height: 216.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: image == null
              ? Image.asset(
                  images[index],
                  fit: BoxFit.fill,
                )
              : CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: image,
                  placeholder: (context, url) =>
                      Image.asset('assets/images/user_placer_image.jpg'),
                ),
        ),
      ),
      onTap: () {
        _selectImageClick(index);
      },
    );
  }

//底部提示文本
  Widget _bottomText() {
    return UnconstrainedBox(
      child: Container(
        constraints: BoxConstraints(maxWidth: 270.5),
        margin: EdgeInsets.only(top: 20),
        child: Text(
          '说明：\n1、平台会严格保密您的个人信息，防止信息泄露\n2、您的个人信息我们只会与公安部对接验证您的信息真伪，并不做任何其他行为\n3、审核通过的用户才会对外显示。否则别的用户不能以任何方式看到您',
          style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 11,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

//右侧按钮
  List<Widget> _actionsWidget() {
    return [
      GestureDetector(
        child: Container(
          margin: EdgeInsets.only(right: 17),
          width: 44,
          child: Center(
            child: Text(
              '完成',
              style: TextStyle(
                  color: Color(0xFFFF6B6F),
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        onTap: _submitResult,
      )
    ];
  }
}
