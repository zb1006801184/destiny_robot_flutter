import 'package:destiny_robot/im/widget/cachImage/cached_image_widget.dart';
import 'package:destiny_robot/models/user_info_model.dart';
import 'package:destiny_robot/network/api_service.dart';
import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/widget_unitls.dart';
import 'package:flutter/material.dart';

class PersonHomePage extends StatefulWidget {
  Map arguments;
  PersonHomePage({
    Key key,
    this.arguments,
  }) : super(key: key);
  @override
  _PersonHomePageState createState() => _PersonHomePageState();
}

class _PersonHomePageState extends State<PersonHomePage> {
  String _accontId;
  UserInfoModel _model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _accontId = widget.arguments['accountId'];
    _request();
  }

  //数据
  void _request() async {
    ApiService.getOtherMessageWithIDRequest({'accountId': _accontId ?? ''})
        .then((value) {
      setState(() {
        _model = value;
      });
    });
  }

  void _likeNet() async {
    ApiService.addLikeRequest(_accontId).then((value) {
      setState(() {
        _model.isLike = !_model.isLike ?? true;
      });
    });
  }

//####################相关逻辑####################

  void _navItemClick(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pop();
        break;
      case 1:
        _likeNet();
        break;
      case 2:
        Map arg = {"coversationType": 1, "targetId": _accontId};
        Navigator.pushNamed(context, "/conversation", arguments: arg);
        break;
      default:
    }
  }

//####################widgets####################
  //顶部背景图
  Widget _topBGWidget() {
    return Positioned(
        child: Container(
      width: Global.ksWidth,
      height: 323,
      child: Image.asset(
        'assets/images/def_bg.png',
        fit: BoxFit.cover,
      ),
    ));
  }

  //顶部自定义导航栏
  Widget _topNavBarWidget() {
    return Positioned(
        child: Container(
      width: Global.ksWidth,
      height: Global.ksToolbarHeight + Global.ksStateHeight,
      padding: EdgeInsets.only(top: Global.ksStateHeight),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Image.asset(
                'assets/images/index_icon_return_white.png',
                fit: BoxFit.cover,
              ),
              padding: EdgeInsets.only(left: 10),
              onPressed: () {
                _navItemClick(0);
              }),
          Row(
            children: [
              IconButton(
                  icon: Image.asset(
                    _model?.isLike == true
                        ? 'assets/images/nav_icon_heart_press.png'
                        : 'assets/images/nav_icon_heart_normal.png',
                    fit: BoxFit.cover,
                  ),
                  padding: EdgeInsets.only(right: 0),
                  onPressed: () {
                    _navItemClick(1);
                  }),
              IconButton(
                  icon: Image.asset(
                    'assets/images/nav_icon_con_normal.png',
                    fit: BoxFit.cover,
                  ),
                  padding: EdgeInsets.only(right: 22),
                  onPressed: () {
                    _navItemClick(2);
                  }),
            ],
          )
        ],
      ),
    ));
  }

//滑动视图
  Widget _listViewWidget() {
    return Container(
      width: Global.ksWidth,
      height: Global.ksHeight,
      color: Colors.transparent,
      padding: EdgeInsets.only(left: 14, right: 14),
      child: CustomScrollView(
        slivers: [
          //顶部空白
          _boxBlankWidget(),
          //昵称box
          _boxNickNameWidget(),
          SliverToBoxAdapter(
            child: Container(
              height: 6.5,
            ),
          ),
          //信息box
          _boxMessageListWidget(),
          SliverToBoxAdapter(
            child: Container(
              height: 29,
            ),
          ),
          //图片list
          _imagesListWidget(_model?.album ?? []),
        ],
      ),
    );
  }

  Widget _boxBlankWidget() {
    return SliverToBoxAdapter(
      child: Container(
          height: 234,
          width: Global.ksWidth - 14 * 2,
          color: Colors.transparent),
    );
  }

  Widget _boxNickNameWidget() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        height: 128,
        child: Column(
          children: [
            _boxNickNameColumnTopWidget(),
            _boxNickNameColumnBottomWidget(),
          ],
        ),
      ),
    );
  }

  Widget _boxNickNameColumnTopWidget() {
    return Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 47,
            ),
            Row(
              children: [
                Text(_model?.nickname ?? 'unknow'),
                Container(
                  child: _model?.gender == 1
                      ? Image.asset('assets/images/user_icon_female.png')
                      : Image.asset('assets/images/user_icon_male.png'),
                  margin: EdgeInsets.only(left: 6),
                )
              ],
            ),
            Container(
              width: 37,
              height: 37,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/user_icon_frame.png'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_model?.fateValue ?? 0}',
                    style: TextStyle(fontSize: 12, color: Color(0xFFFF8484)),
                  ),
                  Text(
                    '缘分',
                    style: TextStyle(fontSize: 7, color: Color(0xFFFF8484)),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _boxNickNameColumnBottomWidget() {
    return Expanded(
        flex: 1,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: _titleImageWidget(
                    title: '${_model?.age ?? 0}岁',
                    imageUrl: 'assets/images/user_icon_age.png')),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 13.5,
                      width: 0.5,
                      color: Color(0xFF706863),
                    ),
                    _titleImageWidget(
                        title: '--',
                        imageUrl: 'assets/images/user_icon_heig.png'),
                    Container(
                      height: 13.5,
                      width: 0.5,
                      color: Color(0xFF706863),
                    ),
                  ],
                )),
            Expanded(
                flex: 1,
                child: _titleImageWidget(
                    title: '--',
                    imageUrl: 'assets/images/user_icon_place.png')),
          ],
        ));
  }

  Widget _titleImageWidget({String title, String imageUrl}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imageUrl),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
          ),
        )
      ],
    );
  }

  Widget _boxMessageListWidget() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(
          children: _messageListWidget(),
        ),
      ),
    );
  }

  List<Widget> _messageListWidget() {
    List<Widget> result = [];
    result.add(_messageItemWidget(title: '专业：', subTitle: _model?.major ?? ''));
    result.add(_messageItemWidget(
        title: '学历：',
        subTitle: WidgetUnitls().educationStr(_model?.education ?? -1)));
    result
        .add(_messageItemWidget(title: '学校：', subTitle: _model?.school ?? ''));
    result.add(
        _messageItemWidget(title: '籍贯：', subTitle: _model?.hometown ?? ''));
    result.add(_messageItemWidget(
        title: '兴趣：',
        subTitle: WidgetUnitls().interestStr(_model?.interest ?? [])));
    result.add(
        _messageItemWidget(title: '自我评价：', subTitle: _model?.details ?? ''));

    return result;
  }

  Widget _messageItemWidget({String title, String subTitle}) {
    return Container(
      padding: EdgeInsets.only(top: 14, bottom: 14, left: 20.5, right: 20.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          Expanded(
              child: Text(
            subTitle,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ))
        ],
      ),
    );
  }

  Widget _imagesListWidget(List imageList) {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, num index) {
            return Container(
              margin: EdgeInsets.only(top: 4.5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: imageList[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          childCount: imageList?.length ?? 0,
        ),
        itemExtent: 295);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _topBGWidget(),
          _listViewWidget(),
          _topNavBarWidget(),
        ],
      ),
    );
  }
}
