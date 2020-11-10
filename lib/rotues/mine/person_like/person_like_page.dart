import 'package:destiny_robot/im/widget/cachImage/cached_image_widget.dart';
import 'package:destiny_robot/models/sift_user_model.dart';
import 'package:destiny_robot/network/api_service.dart';
import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/them_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//我 - 我喜欢的/喜欢我的
class PersonLikePage extends StatefulWidget {
  int arguments;
  PersonLikePage({
    Key key,
    this.arguments,
  });
  @override
  _PersonLikePageState createState() => _PersonLikePageState();
}

class _PersonLikePageState extends State<PersonLikePage>
    with SingleTickerProviderStateMixin {
  TabController mController;
  List _mineLikeDataList = [];
  List _likeMineDataList = [];
  int _selectIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectIndex = widget.arguments;
    mController = TabController(
      length: 2,
      initialIndex: _selectIndex ?? 0,
      vsync: this,
    );
    mController.addListener(() {});
    _request();
  }

  void _request() async {
    ApiService.getMineLikePersonsRequest({'pageSize': '150', 'pageNum': '1'})
        .then((value) {
      setState(() {
        _mineLikeDataList = value;
      });
    });
    ApiService.getLikeMinePersonsRequest({'pageSize': '150', 'pageNum': '1'})
        .then((value) {
      setState(() {
        _likeMineDataList = value;
      });
    });
  }

  //左右切换的时候
  void _selectClick(int index) {}
  //item 点击

  void _itemClick(int listIndex, int index) {
    SiftUserModel model;
    if (listIndex == 0) {
      model = _mineLikeDataList[index];
    } else {
      model = _likeMineDataList[index];
    }

    print(model.nickname);
    // Map arg = {
    //   "coversationType": 1,
    //   "targetId": model?.accountId??'0',
    //   'name': model?.nickname
    // };
    // Navigator.pushNamed(context, "/conversation", arguments: arg);
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
      ],
      onTap: _selectClick,
    );
  }

  //list widget
  Widget _listWidget(int listIndex) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          child: _listItemWidget(index, listIndex),
          onTap: () => _itemClick(listIndex, index),
        );
      },
      itemCount:
          listIndex == 0 ? _mineLikeDataList.length : _likeMineDataList.length,
      itemExtent: 80,
    );
  }

//list item widget
  Widget _listItemWidget(int index, int listIndex) {
    SiftUserModel model;
    if (listIndex == 0) {
      model = _mineLikeDataList[index];
    } else {
      model = _likeMineDataList[index];
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rowWidget(model: model),
              Container(
                margin: EdgeInsets.only(right: 14),
                child: Text(
                  model.createdTime ?? '0:00',
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

  Widget _rowWidget({SiftUserModel model}) {
    return Row(
      children: [
        Container(
            width: 49,
            height: 49,
            margin: EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(49 / 2),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: model.headImgUrl,
                placeholder: (context, url) =>
                    Image.asset('assets/images/user_placer_image.jpg'),
              ),
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                model?.nickname ?? 'unkown',
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Text("缘分值${model.fateValue ?? 0}",
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
