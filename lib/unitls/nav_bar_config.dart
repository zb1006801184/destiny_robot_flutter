import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/material.dart';
import 'package:destiny_robot/state/provider_store.dart';
import 'package:destiny_robot/state/them_model.dart';
import 'package:destiny_robot/unitls/them_util.dart';

class NavBarConfig {
  //默认导航栏样式
  AppBar configAppBar(String title, BuildContext context,
      {List<Widget> rightWidget = null}) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: ThemUntil().widgetColor(context), fontSize: 18),
      ),
      leading: IconButton(
          icon: Container(
            child: Image.asset('assets/images/nav_icon_return.png'),
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      actions: rightWidget,
      backgroundColor: ThemUntil().mainColor(context),
      elevation: 0, //阴影辐射范围
      brightness: ThemUntil().stateBarColor(context),
    );
  }

//一级路由appBar
  AppBar configTabbarAppBar(String title, BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: ThemUntil().widgetColor(context), fontSize: 18),
      ),
      backgroundColor: ThemUntil().mainColor(context),
      elevation: 0, //阴影辐射范围
      brightness: ThemUntil().stateBarColor(context),
    );
  }

  //首页路由
  AppBar configHomeMapAppBar(String title, BuildContext context,
      Function leftClick, Function rightClick,{DateTime time}) {
    return AppBar(
      backgroundColor: ThemUntil().mainColor(context),
      elevation: 0, //阴影辐射范围
      brightness: ThemUntil().stateBarColor(context),
      actions: [
        Container(
            width: Global.ksWidth,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLeftButton(leftClick,time: time),
                    GestureDetector(
                      child: Container(
                        height: 64,
                        margin: EdgeInsets.only(
                          right: 19,
                        ),
                        child: Image.asset(
                          'assets/images/index_nav_shaixuan.png',
                          width: 32,
                          height: 30,
                        ),
                      ),
                      onTap: rightClick,
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: ThemUntil().widgetColor(context),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            )),
      ],
    );
  }


  //个人主页
  AppBar configPersonHomePageAppBar(String title, BuildContext context,
      {List<Widget> rightWidget = null}) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: ThemUntil().widgetColor(context), fontSize: 18),
      ),
      leading: IconButton(
          icon: Container(
            child: Image.asset('assets/images/nav_icon_return.png'),
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      actions: rightWidget,
      backgroundColor: Colors.transparent,
      elevation: 0, //阴影辐射范围
      brightness: ThemUntil().stateBarColor(context),
    );
  }




  //左侧按钮
  Widget _buildLeftButton(Function leftClick,{DateTime time}) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 19),
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '${time.year}年${time.month}月${time.day}日',
              style: TextStyle(
                  color: Color(0xFFFF6572),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              margin: EdgeInsets.only(left: 6),
              child: Image.asset(
                'assets/images/index_nav_sel.png',
                width: 10,
                height: 8,
              ),
            )
          ],
        ),
      ),
      onTap: leftClick,
    );
  }
}
