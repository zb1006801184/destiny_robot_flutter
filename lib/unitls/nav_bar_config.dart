import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/material.dart';
import 'package:destiny_robot/state/provider_store.dart';
import 'package:destiny_robot/state/them_model.dart';
import 'package:destiny_robot/unitls/them_util.dart';

class NavBarConfig {
  //默认导航栏样式
  AppBar configAppBar(String title, BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: ThemUntil().widgetColor(context), fontSize: 18),
      ),
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Store.value<ThemModel>(context).getThemeModel()
                ? Colors.white
                : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
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
      Function leftClick, Function rightClick) {
    return AppBar(
      // title: Text(
      //   title,
      //   style: TextStyle(color: ThemUntil().widgetColor(context), fontSize: 18),
      // ),
      backgroundColor: ThemUntil().mainColor(context),
      elevation: 0, //阴影辐射范围
      brightness: ThemUntil().stateBarColor(context),
      // leading: _buildLeftButton(leftClick),
      actions: [
        Container(
          width: Global.ksWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLeftButton(leftClick),
              Text(
                title,
                style: TextStyle(
                    color: ThemUntil().widgetColor(context),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
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
        ),
      ],
    );
  }

  //左侧按钮
  Widget _buildLeftButton(Function leftClick) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 19),
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '今天',
              style: TextStyle(
                  color: Color(0xFFFF6572),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Image.asset(
                'assets/images/index_nav_sel.png',
                width: 10,
                height: 6,
              ),
            )
          ],
        ),
      ),
      onTap: leftClick,
    );
  }
}
