import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MineSetAboutPage extends StatefulWidget {
  @override
  _MineSetAboutPageState createState() => _MineSetAboutPageState();
}

class _MineSetAboutPageState extends State<MineSetAboutPage> {
  void _itemClick(int index) {
    print('$index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig().configAppBar('', context),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _topWidget(),
          _bottomWidget(),
        ],
      ),
    );
  }

  //top widget
  Widget _topWidget() {
    return Container(
      padding: EdgeInsets.only(top: 48),
      child: Column(
        children: [
          _headImage(),
          _titleAndVersion(),
          _centerWidget(),
        ],
      ),
    );
  }

  //bottom widget
  Widget _bottomWidget() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: '《使用协议》',
                  style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF010101),
                      fontWeight: FontWeight.w500),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      print('object');
                    }),
              TextSpan(
                text: '和',
                style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF010101),
                    fontWeight: FontWeight.w500),
              ),
              TextSpan(
                  text: '《隐私协议》',
                  style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF010101),
                      fontWeight: FontWeight.w500),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      print('object');
                    }),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              '版权归北京谛听机器人科技有限公司所有',
              style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF010101),
                  fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            'Copyright © 2020 AI',
            style: TextStyle(
                fontSize: 11,
                color: Color(0xFF010101),
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  //头像
  Widget _headImage() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/icon-83.5@2x.png')),
          borderRadius: BorderRadiusDirectional.circular(15)),
    );
  }

  //标题 和 版本
  Widget _titleAndVersion() {
    return Container(
      margin: EdgeInsets.only(top: 35.5),
      child: Column(
        children: [
          Container(
            child: Text(
              '恋爱机器人',
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 19),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
  //版本更新/分享好友

  Widget _centerWidget() {
    return Container(
      margin: EdgeInsets.only(top: 25.5),
      child: Column(
        children: [
          _itemWidget('版本更新', index: 0, subTitle: 'NEW'),
          _itemWidget('分享好友', index: 1)
        ],
      ),
    );
  }

  Widget _itemWidget(String title, {int index, String subTitle}) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 24.5),
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 37, right: 37),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 9.5),
                        child: Text(
                          subTitle ?? '',
                          style: TextStyle(
                              color: Color(0xFF706863),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Image.asset('assets/images/list_icon_retu.png')
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              margin: EdgeInsets.only(left: 37.5, right: 37.5, top: 21.5),
              color: Color(0xFFD1D1D1),
            ),
          ],
        ),
      ),
      onTap: () {
        _itemClick(index);
      },
    );
  }
}
