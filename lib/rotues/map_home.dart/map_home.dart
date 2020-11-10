import 'dart:async';

import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:destiny_robot/im/widget/cachImage/cached_image_widget.dart';
import 'package:destiny_robot/models/sift_list_model.dart';
import 'package:destiny_robot/models/sift_user_model.dart';
import 'package:destiny_robot/network/api_service.dart';
import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/toast_view.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../unitls/nav_bar_config.dart';

class MapHome extends StatefulWidget {
  @override
  _MapHomeState createState() => _MapHomeState();
}

class _MapHomeState extends State<MapHome> {
  //地图
  AmapController _controller;
  //定位坐标
  LatLng _centerLatLng = LatLng(39.95883870442708, 116.44932074652777);
  //是否在匹配
  bool _isMarry = false;
  //轨迹列表
  List<SiftListModel> _siftResultList = [];
  //历史轨迹选中了第几个
  int selectItemIndex;
  //是否允许点击历史轨迹
  bool isCanClick = true;
  //定时器
  Timer _timer;
  //匹配的人
  List _persons = [];
  //三分钟一次的位置
  List<LatLng> _locations = [];
  //当前选择的时间，默认当天
  DateTime _selectTime = DateTime.now();

  //折线数据
  LatLng _centerLatLng1 = LatLng(39.96883870442708, 116.44932074652777);
  LatLng _centerLatLng2 = LatLng(39.96883870442708, 116.47032074652777);
  LatLng _centerLatLng3 = LatLng(39.97883870442708, 116.44932074652777);
  LatLng _centerLatLng4 = LatLng(39.97953870442708, 116.44932074652777);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configData();
  }

  void _configData() async {
    await ApiService.getMatchListRequest().then((value) {
      setState(() {
        _siftResultList = value;
      });
    });
  }

  void _righClick() {
    print('right');
  }

  void _leftClick() async {
    print('left');

    DateTime result = await showDatePicker(
      context: context,
      locale: Locale('zh'),
      initialDate: _selectTime,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      selectableDayPredicate: (DateTime day) {
        return day.difference(DateTime.now()).inDays < 1;
      },
    );
    _selectTime = result??DateTime.now();

    ApiService.getMatchListRequest(params: {'matchDate': result.toString()})
        .then((value) {
      setState(() {
        _siftResultList = value;
      });
    });
  }

//匹配

  void _marryAction() async {
    if (Global.userModel.auditState != 1) {
      ToastView(
        title: '尚未实名认证！',
      ).showMessage();
      return;
    }
    setState(() {
      _isMarry = !_isMarry;
    });
    if (_isMarry == true) {
      starMach();
    } else {
      stopMach();
    }
  }

  //去匹配
  void starMach() async {
    //当前定位
    Location location =
        await AmapLocation.instance.fetchLocation(needAddress: true);
    _centerLatLng = location.latLng;
    _locations.add(location.latLng);
    _controller.setCenterCoordinate(location.latLng);
    // _controller.setAllGesturesEnabled(false);
    // await _controller?.showMyLocation(MyLocationOption(
    //     myLocationType: MyLocationType.Follow,
    //     iconProvider: AssetImage('assets/images/index_icon_daohang.png')));

    //请求匹配接口
    await ApiService.goToMatchRequest({
      'lat': location.latLng.latitude,
      'lon': location.latLng.longitude,
      'newTrail': true,
      'trailName': location.street ?? '三元桥'
    }).then((value) async {
      keepLocation();
      _persons = value;
      _controller.clear();
      _addPersonMarker(lists: _persons);
      await Future.delayed(Duration(seconds: 1), () {});
      _addPersonMarker(lists: _persons);
      await Future.delayed(Duration(seconds: 1), () {});
      _addPersonMarker(lists: _persons);
    });

    //初始位置
    _controller.addMarker(MarkerOption(
        latLng: _centerLatLng,
        iconProvider: AssetImage('assets/images/index_icon_pos.png')));
  }

  //停止匹配
  void stopMach() async {
    await ApiService.stopMatchRequest().then((value) {
      _timer?.cancel();
      print('停止匹配');
    }).catchError((e) {});
  }

  keepLocation() async {
    _timer = Timer.periodic(Duration(milliseconds: 1000 * 60 * 3), (t) async {
      print('匹配');
      Location location =
          await AmapLocation.instance.fetchLocation(needAddress: true);
      _locations.add(location.latLng);
      _locations.add(_centerLatLng3);

      //添加路线图
      await _controller.addPolyline(PolylineOption(
        latLngList: _locations,
        width: 20,
        strokeColor: Color(0xFFFC9E7E),
        lineJoinType: LineJoinType.Round,
      ));

      //请求匹配接口
      await ApiService.goToMatchRequest({
        'lat': location.latLng.latitude,
        'lon': location.latLng.longitude,
        'newTrail': false,
        'trailName': location.street ?? '三元桥'
      }).then((value) async {
        _persons = value;
        _addPersonMarker(lists: _persons);
        await Future.delayed(Duration(seconds: 1), () {});
        _addPersonMarker(lists: _persons);
        await Future.delayed(Duration(seconds: 1), () {});
        _addPersonMarker(lists: _persons);
      });
    });
  }

//添加自定义widget
  void _addPersonMarker({List<SiftUserModel> lists}) {
    _controller.addMarkers([
      for (SiftUserModel item in lists)
        MarkerOption(
            latLng: LatLng(item.lat, item.lon),
            title: item.nickname,
            snippet: '${item.accountId}',
            widget: Container(
              height: 55,
              width: 34,
              child: Column(
                children: [
                  Container(
                    width: 22,
                    height: 19,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/index_icon_heart.png'))),
                    child: Center(
                      child: Text(
                        '${item.fateValue}',
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(34 / 2),
                    child: CachedNetworkImage(
                      width: 34,
                      height: 34,
                      fit: BoxFit.cover,
                      imageUrl: item.headImgUrl,
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/default_portrait.jpg'),
                    ),
                  )
                ],
              ),
            )),
    ]);
  }

//地图相关回调

  void _mapBackAction() async {
    //单次定位
    Location location = await AmapLocation.instance.fetchLocation();
    _centerLatLng = location.latLng;
    _controller.setCenterCoordinate(location.latLng);
    await _controller?.showMyLocation(MyLocationOption(
        myLocationType: MyLocationType.Follow,
        iconProvider: AssetImage('assets/images/index_icon_daohang.png')));
  }

  //右侧历史轨迹列表的点击

  void _historyListClick(int index) async {
    if (isCanClick == false || _isMarry == true) {
      return;
    }
    //清理添加物
    _controller.clear();
    SiftListModel model = _siftResultList[index];
    List<LatLng> result = [];
    model.trailDetails.forEach((element) {
      TrailDetails localModel = element;
      result.add(LatLng(localModel.lat, localModel.lon));
    });
    //添加路线图
    await _controller.addPolyline(PolylineOption(
      latLngList: result,
      width: 20,
      strokeColor: Color(0xFFFC9E7E),
      lineJoinType: LineJoinType.Round,
    ));
    setState(() {
      selectItemIndex = index;
    });
    isCanClick = false;
    await ApiService.getMatchWithIDRequest({'id': model.id})
        .then((value) async {
      _addPersonMarker(lists: value);
      await Future.delayed(Duration(seconds: 1), () {});
      _addPersonMarker(lists: value);
      await Future.delayed(Duration(seconds: 1), () {});
      _addPersonMarker(lists: value);
      isCanClick = true;
    }).catchError((e){
print(e);
    });
  }

  //地图上的人物点击
  void onMarkerClicked(Marker marker) {
    marker.iosModel?.get_subtitle().then((value) => gotoChatPage(value));
    marker.androidModel?.getSnippet().then((value) => gotoChatPage(value));
  }

  void gotoChatPage(String value) {
    Map arg = { "accountId": '${value}'};
    Navigator.pushNamed(context, "/PersonHomePage", arguments: arg);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig()
          .configHomeMapAppBar('匹配', context, _leftClick, _righClick,time: _selectTime),
      body: Stack(children: [
        Column(
          children: [
            Expanded(
                child: Container(
              child: AmapView(
                mapType: MapType.Standard,
                showCompass: false,
                showZoomControl: false,
                tiltGestureEnabled: false,
                rotateGestureEnabled: false,
                zoomLevel: 15,
                onMarkerClicked: (Marker marker) {
                  onMarkerClicked(marker);
                },
                onMapClicked: (LatLng coord) {
                  print(coord);
                },
                markers: [],
                onMapCreated: (controller) async {
                  _controller = controller;
                  // //获取定位权限
                  await Permission.locationWhenInUse.request();

                  _mapBackAction();
                },
                autoRelease: true,
              ),
            )),
          ],
        ),
        _locationButton(),
        _marryButton(),
        _rightSelectList(),
      ]),
    );
  }

  //定位按钮
  Widget _locationButton() {
    return Positioned(
        right: 16.5,
        bottom: 92.5,
        child: GestureDetector(
          child: Container(
            width: 30,
            height: 30,
            child: Image.asset(
              'assets/images/index_button_reset.png',
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            _controller.setCenterCoordinate(_centerLatLng);
          },
        ));
  }

  //匹配按钮
  Widget _marryButton() {
    return Positioned(
        right: 6.5,
        bottom: 25,
        child: GestureDetector(
          child: Container(
            width: 51,
            height: 51,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(_isMarry == false
                        ? 'assets/images/index_button_start.png'
                        : 'assets/images/index_button_stop.png'),
                    fit: BoxFit.contain)),
            child: Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 6),
                child: Text(
                  '匹配',
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          onTap: _marryAction,
        ));
  }

  //右侧选择列表
  Widget _rightSelectList() {
    return Positioned(
        right: 0,
        top: 16.0,
        child: Container(
            color: Colors.white,
            width: 48.4,
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 12),
                  child: Image.asset('assets/images/index_icon_trail.png'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return _rightSelectItem(index);
                    },
                    itemCount: _siftResultList?.length ?? 0,
                  ),
                )
              ],
            )));
  }

  //右侧选择list item
  Widget _rightSelectItem(int index) {
    final List titles = ['三元桥', '双井', '健德门', '垂杨柳南里'];
    SiftListModel model = _siftResultList[index];
    return GestureDetector(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 48.4,
              padding: EdgeInsets.all(8.5),
              child: Text(
                model.name ?? '',
                style: TextStyle(
                    color: selectItemIndex == index
                        ? Color(0xFFD1D1D1)
                        : Color(0xFFf89264),
                    fontSize: 10),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              height: index == titles.length - 1 ? 0 : 0.5,
              margin: EdgeInsets.only(left: 7.5),
              color: Color(0xFFd9d9d9),
            ),
          ],
        ),
      ),
      onTap: () {
        _historyListClick(index);
      },
    );
  }
}
