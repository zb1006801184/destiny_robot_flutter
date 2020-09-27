import 'package:destiny_robot/im/pages/conversation_list_page.dart';
import 'package:destiny_robot/im/util/db_manager.dart';
import 'package:destiny_robot/im/util/event_bus.dart';
import 'package:destiny_robot/im/util/user_info_datesource.dart';
import 'package:destiny_robot/other/contacts_page.dart';
import 'package:destiny_robot/rotues/login/login_page.dart';
import 'package:destiny_robot/rotues/map_home.dart/map_home.dart';
import 'package:destiny_robot/rotues/mine/mine.dart';
import 'package:flutter/material.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String pageName = "example.HomePage";
  final List<BottomNavigationBarItem> tabbarList = [
    new BottomNavigationBarItem(
      icon: Image(image: AssetImage("assets/images/tabar_index_normal.png")),
      activeIcon:
          Image(image: AssetImage("assets/images/tabar_index_selected.png")),
      title: new Text("首页"),
    ),
    new BottomNavigationBarItem(
      icon: Image(image: AssetImage("assets/images/tabar_message_normal.png")),
      activeIcon:
          Image(image: AssetImage("assets/images/tabar_message_selected.png")),
      title: new Text("消息"),
    ),
    new BottomNavigationBarItem(
      icon: new Icon(
        Icons.perm_contact_calendar,
        color: Colors.grey,
      ),
      title: new Text("通讯录"),
    ),
    new BottomNavigationBarItem(
      icon: Image(image: AssetImage("assets/images/tabar_me_normal.png")),
      activeIcon:
          Image(image: AssetImage("assets/images/tabar_me_selected.png")),
      title: new Text("我"),
    ),
  ];
  final List<Widget> vcList = [
    MapHome(),
    ConversationListPage(),
    ContactsPage(),
    Mine(),
  ];

  int curIndex = 0;

  @override
  void initState() {
    super.initState();
    _initUserInfoCache();
    initPlatformState();
  }

  initPlatformState() async {
    //1.初始化 im SDK
    // RongIMClient.init(RongAppKey);

    //2.连接 im SDK
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("token");
    if (token != null && token.length > 0) {
      // int rc = await RongIMClient.connect(token);
      RongIMClient.connect(token, (int code, String userId) {
        developer.log("connect result " + code.toString(), name: pageName);
        EventBus.instance.commit(EventKeys.UpdateNotificationQuietStatus, {});
        if (code == 31004 || code == 12) {
          developer.log("connect result " + code.toString(), name: pageName);
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => new LoginPage()),
              (route) => route == null);
        } else if (code == 0) {
          developer.log("connect userId" + userId, name: pageName);
          // 连接成功后打开数据库
          // _initUserInfoCache();
        }
      });
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => new LoginPage()),
          (route) => route == null);
    }
  }

  // 初始化用户信息缓存
  void _initUserInfoCache() {
    DbManager.instance.openDb();
    UserInfoCacheListener cacheListener = UserInfoCacheListener();
    cacheListener.getUserInfo = (String userId) {
      return UserInfoDataSource.generateUserInfo(userId);
    };
    cacheListener.getGroupInfo = (String groupId) {
      return UserInfoDataSource.generateGroupInfo(groupId);
    };
    UserInfoDataSource.setCacheListener(cacheListener);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        items: tabbarList,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            curIndex = index;
          });
        },
        currentIndex: curIndex,
        selectedItemColor: Color(0xFFFF6371),
        unselectedItemColor: Color(0xFF6F6763),
      ),
      body: IndexedStack(
        index: curIndex,
        children: vcList,
      ),
    );
  }
}
