import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:flutter/material.dart';

class PersonalDataAlbumPage extends StatefulWidget {
  @override
  _PersonalDataAlbumPageState createState() => _PersonalDataAlbumPageState();
}

class _PersonalDataAlbumPageState extends State<PersonalDataAlbumPage> {
  @override
  Widget build(BuildContext context) {
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
          itemCount: 6,
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
    return Container(
      color: Colors.red,
    );
  }
}
