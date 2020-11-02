import 'package:destiny_robot/im/widget/cachImage/cached_image_widget.dart';
import 'package:destiny_robot/network/api_service.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:destiny_robot/widgets/sample_select.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

//我-学生认证
class StudentAuthorPage extends StatefulWidget {
  @override
  _StudentAuthorPageState createState() => _StudentAuthorPageState();
}

class _StudentAuthorPageState extends State<StudentAuthorPage> {
  final List titles = ['拍照', '从相册中选择'];
  String _imagePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configData();
  }

  void _configData() async {
    var data = await ApiService.getStudentRequest();
    setState(() {
      _imagePath = data['data']['studentFront'];
    });
  }

//选择照片
  void _selectImageClick() async {
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
        _imagePath = url;
      });
    });
  }

  void _submitResult() async {
    if (_imagePath == null) {
      return;
    }
    var data =
        await ApiService.saveStudentRequest({'studentFront': _imagePath});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBarConfig()
            .configAppBar("学生认证", context, rightWidget: _actionsWidget()),
        body: ListView(
          children: [
            _selectImage(),
            _bottomText(),
          ],
        ));
  }

  //选择照片
  Widget _selectImage() {
    return GestureDetector(
      child: UnconstrainedBox(
        child: Container(
          margin: EdgeInsets.only(top: 19),
          width: 282.5,
          height: 407.5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _imagePath == null
                ? Image.asset(
                    'assets/images/student_card.png',
                    fit: BoxFit.fill,
                  )
                : CachedNetworkImage(fit: BoxFit.fill, imageUrl: _imagePath),
          ),
        ),
      ),
      onTap: _selectImageClick,
    );
  }

//底部提示文本
  Widget _bottomText() {
    return UnconstrainedBox(
      child: Container(
        constraints: BoxConstraints(maxWidth: 270.5),
        margin: EdgeInsets.only(top: 60),
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
      InkWell(
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
