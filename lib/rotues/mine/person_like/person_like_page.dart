import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/them_util.dart';
import 'package:flutter/material.dart';
//我 - 我喜欢的/喜欢我的
class PersonLikePage extends StatefulWidget {
  @override
  _PersonLikePageState createState() => _PersonLikePageState();
}

class _PersonLikePageState extends State<PersonLikePage>
    with SingleTickerProviderStateMixin {
  TabController mController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: configAppBar('title', context),
          body: TabBarView(controller: mController, children: [
            _listWidget(0),
            _listWidget(1),
          ]),
        ));
  }

  //导航栏
  AppBar configAppBar(String title, BuildContext context) {
    return AppBar(
      leading: Text(''),
      backgroundColor: ThemUntil().mainColor(context),
      elevation: 0, //阴影辐射范围
      brightness: ThemUntil().stateBarColor(context),
      actions: [
        Container(
          width: Global.ksWidth,
          child: Stack(
            children: [
              Positioned(
                  child: IconButton(
                      icon: Container(
                        child: Image.asset('assets/images/nav_icon_return.png'),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      })),
              Center(
                child: _tabbarWidget(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //顶部tabbar
  TabBar _tabbarWidget() {
    return TabBar(
        isScrollable: true,
        controller: mController,
        labelColor: Color(0xFFFF6B6F),
        unselectedLabelColor: Color(0xFF000000),
        indicatorWeight: 3,
        indicatorPadding: EdgeInsets.only(left: 15, right: 15),
        tabs: [
          Tab(
            text: '我喜欢的',
          ),
          Tab(
            text: '喜欢我的',
          ),
        ]);
  }

  //list widget
  Widget _listWidget(int listIndex) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _listItemWidget(index);
      },
      itemCount: 4,
      itemExtent: 80,
    );
  }

//list item widget
  Widget _listItemWidget(int index) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rowWidget(),
              Container(
                margin: EdgeInsets.only(right: 14),
                child: Text(
                  '13:12',
                  style: TextStyle(color: Color(0xFFD1D1D1), fontSize: 10),
                ),
              ),
            ],
          ),
          _lineWidget(),
        ],
      ),
    );
  }

  Widget _rowWidget() {
    return Row(
      children: [
        Container(
          width: 49,
          height: 49,
          margin: EdgeInsets.only(right: 10),
          color: Colors.red,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                "娜娜",
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Text("缘分值90",
                style: TextStyle(color: Color(0xFF999491), fontSize: 12)),
          ],
        ),
      ],
    );
  }

  //分割线
  Widget _lineWidget() {
    return Positioned(
        right: 0,
        bottom: 0,
        child: Container(
          height: 0.5,
          width: Global.ksWidth - 73.5,
          color: Color(0xFFF1F1F1),
        ));
  }
}
