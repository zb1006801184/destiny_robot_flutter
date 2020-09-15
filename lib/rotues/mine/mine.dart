import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/material.dart';

class Mine extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {
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
        child: Container(
      width: Global.ksWidth,
      height: 173,
      color: Colors.red,
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
        _buildCommonItemWidget(title: '实名认证'),
        _buildCommonItemWidget(title: '筛选条件'),
        _buildCommonItemWidget(title: '人工客服'),
        _buildCommonItemWidget(title: '设置'),
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
                    color: Colors.black,
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
        ));
  }

  //我喜欢的/喜欢我的
  Widget _buildLikeWidget({String title, String numString = '0'}) {
    return Container(
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
    );
  }

  //个人信息-返回按钮
  Widget _buildTopBackButton() {
    return Positioned(
        right: 42,
        bottom: 53,
        child: Container(
          width: 5,
          height: 10,
          color: Colors.red,
        ));
  }

//列表相同的Item
  Widget _buildCommonItemWidget({String title, String iconSting}) {
    return Container(
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
                color: Colors.greenAccent,
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
            height: 10,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
