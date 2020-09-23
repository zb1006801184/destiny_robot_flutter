import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//tabbar - 我
class Mine extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {
  final _iconList = [
    'assets/images/me_icon_shiming.png',
    'assets/images/me_icon_student.png',
    'assets/images/me_icon_shaixuan.png',
    'assets/images/me_icon_kefu.png',
    'assets/images/me_icon_share.png',
    'assets/images/me_icon_set.png'
  ];
  //编辑个人资料点击
  void _editDataClick() {
    Navigator.of(context).pushNamed("/edit_data_page");
  }

  //喜欢我的/我喜欢的 点击
  void _mineLikeClick({String title}) {
    Navigator.of(context).pushNamed('/PersonLikePage');
  }

  //item点击
  void _itemClick(String title) {
    if (title == '实名认证') {
      Navigator.of(context).pushNamed('/PersonAuthorPages');
    }
    if (title == '学生认证') {
      Navigator.of(context).pushNamed('/StudentAuthorPage');
    }
    if (title == '人工客服') {
      _launchURL();
    }
    if (title == '筛选条件') {
      Navigator.of(context).pushNamed('/PersonSiftPage');
    }
    if (title == '设置') {
      Navigator.of(context).pushNamed('/MineSetPage');
    }
  }

  _launchURL() async {
    const phoneNum = 'tel:15070925726';
    if (await canLaunch(phoneNum)) {
      await launch(phoneNum);
    } else {
      throw 'Could not launch $phoneNum';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(245, 250, 254, 1),
        body: Stack(
          children: [
            _buildTopBgWidget(),
            _buildTitleWidget(),
            _buildListWidget(),
          ],
        ));
  }

  //顶部背景
  Widget _buildTopBgWidget() {
    return Positioned(
        top: -0.5,
        left: -0.5,
        child: Container(
          width: Global.ksWidth,
          height: 173,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/me_bg.png',
                  ),
                  fit: BoxFit.fill)),
        ));
  }

//标题
  Widget _buildTitleWidget() {
    return Positioned(
      top: 15 + Global.ksStateHeight,
      child: Container(
          width: Global.ksWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '我',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )),
    );
  }

  //整个滑动列表
  Widget _buildListWidget() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildTopItemMessageWidget(),
        _buildCommonItemWidget(title: '实名认证', iconSting: _iconList[0]),
        _buildCommonItemWidget(title: '学生认证', iconSting: _iconList[1]),
        _buildCommonItemWidget(title: '人工客服', iconSting: _iconList[2]),
        _buildCommonItemWidget(title: '筛选条件', iconSting: _iconList[3]),
        _buildCommonItemWidget(title: '分享', iconSting: _iconList[4]),
        _buildCommonItemWidget(title: '设置', iconSting: _iconList[5]),
      ],
    );
  }

  //个人信息item
  Widget _buildTopItemMessageWidget() {
    return Container(
      width: Global.ksWidth,
      height: 200,
      child: Stack(
        children: [
          _buildTopItemBoxWidget(),
          _buildHeadImageWidget(),
          _buildTopBackButton(),
        ],
      ),
    );
  }

  //个人信息-头像
  Widget _buildHeadImageWidget() {
    return Positioned(
        left: 36.5,
        bottom: 64.5,
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(75 / 2)),
        ));
  }

  //个人信息-白色背景框
  Widget _buildTopItemBoxWidget() {
    return Positioned(
        bottom: 0,
        left: 12,
        child: InkWell(
          child: Container(
            height: 114.5,
            width: Global.ksWidth - 12 * 2,
            padding: EdgeInsets.only(top: 20, bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: Global.ksWidth - 12 * 2 - 111 - 15),
                      margin: EdgeInsets.only(left: 111),
                      child: Text(
                        '迪士尼在逃公主',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      child: Image.asset('assets/images/user_icon_female.png'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildLikeWidget(title: '我喜欢的', numString: '2'),
                    _buildLikeWidget(title: '喜欢我的', numString: '5'),
                  ],
                ),
              ],
            ),
          ),
          onTap: _editDataClick,
        ));
  }

  //我喜欢的/喜欢我的
  Widget _buildLikeWidget({String title, String numString = '0'}) {
    return InkWell(
      child: Container(
        child: Column(
          children: [
            Container(
              child: Text(
                numString,
                style: TextStyle(color: Color(0xFFff8989), fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3),
              child: Text(
                title,
                style: TextStyle(color: Color(0xFFff8989), fontSize: 13),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        _mineLikeClick(title: title);
      },
    );
  }

  //个人信息-返回按钮
  Widget _buildTopBackButton() {
    return Positioned(
        right: 42,
        bottom: 53,
        child: Container(
          width: 5,
          height: 9,
          child: Image.asset('assets/images/list_icon_retu.png'),
        ));
  }

//列表相同的Item
  Widget _buildCommonItemWidget(
      {String title, String iconSting, String subtitleString}) {
    return GestureDetector(
      child: Container(
        height: 52,
        width: Global.ksWidth - 12 * 2,
        margin: EdgeInsets.only(left: 12, right: 12, top: 7.5),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 15,
                  height: 15,
                  child: Image.asset(
                    iconSting,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 15, color: Color(0xFF6F6763)),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 27.5),
              width: 5,
              height: 9,
              child: Image.asset('assets/images/list_icon_retu.png'),
            )
          ],
        ),
      ),
      onTap: () {
        _itemClick(title);
      },
    );
  }
}
