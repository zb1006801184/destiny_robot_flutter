import 'package:destiny_robot/im/widget/cachImage/cached_image_widget.dart';
import 'package:destiny_robot/network/api_service.dart';
import 'package:destiny_robot/state/provider_store.dart';
import 'package:destiny_robot/state/user_state_model.dart';
import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:destiny_robot/widgets/sample_select.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PersonalDataAlbumPage extends StatefulWidget {
  @override
  _PersonalDataAlbumPageState createState() => _PersonalDataAlbumPageState();
}

class _PersonalDataAlbumPageState extends State<PersonalDataAlbumPage> {
  List images = [];

  void _selectImage() async {
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
      String headImage = image.path;
      var name =
          headImage.substring(headImage.lastIndexOf("/") + 1, headImage.length);
      FormData params = FormData.fromMap(
          {"file": await MultipartFile.fromFile(headImage, filename: name)});
      var url = await ApiService.uploadImageRequest(params);
      setState(() {
        images.add(url);
        Global.userModel.album = images;
        Store.value<UserStateModel>(context, listen: false)
            .savaUserInfo(Global.userModel);
      });
      ApiService.saveAlbumRequest({'album':images});
    });
  }

  void _tapClickImage(String imageUrl) {}

  @override
  Widget build(BuildContext context) {
    images = Global.userModel.album;
    return Scaffold(
      appBar: NavBarConfig().configAppBar('相册', context),
      body: Column(
        children: [
          _albumWidget(),
          _bottomText(),
        ],
      ),
    );
  }

  //相册列表
  Widget _albumWidget() {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.all(15),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemCount: images.length + 1,
          itemBuilder: (context, index) {
            return _itemWidget(index);
          }),
    ));
  }

  //底部提示文字
  Widget _bottomText() {
    return Container(
      margin: EdgeInsets.only(bottom: 33.5),
      child: Text(
        '照片最多可上传9张呦',
        style: TextStyle(color: Color(0xFFD1D1D1), fontSize: 11),
      ),
    );
  }

  //item
  Widget _itemWidget(int index) {
    if (index == images.length) {
      return Container(
        child: GestureDetector(
          child: Image.asset('assets/images/_s-ablum_upload.png'),
          onTap: _selectImage,
        ),
      );
    }
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: GestureDetector(
          child: CachedNetworkImage(
            imageUrl: images[index],
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Image.asset('assets/images/user_placer_image.jpg'),
          ),
          onTap: () {
            _tapClickImage(images[index]);
          },
        ),
      ),
    );
  }
}
