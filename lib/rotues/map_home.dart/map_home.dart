import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:destiny_robot/unitls/global.dart';
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

  //折线数据
  LatLng _centerLatLng1 = LatLng(39.96883870442708, 116.44932074652777);
  LatLng _centerLatLng2 = LatLng(39.96883870442708, 116.47032074652777);
  LatLng _centerLatLng3 = LatLng(39.97883870442708, 116.44932074652777);
  LatLng _centerLatLng4 = LatLng(39.97953870442708, 116.44932074652777);

  void _righClick() {
    print('right');
  }

  void _leftClick() async {
    print('left');

    var result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2021),
      selectableDayPredicate: (DateTime day) {
        return day.difference(DateTime.now()).inDays < 1;
      },
    );
    print('$result');
  }

//匹配

  void _marryAction() async {
    //添加路线图
    await _controller.addPolyline(PolylineOption(
      latLngList: [
        _centerLatLng,
        _centerLatLng1,
        _centerLatLng2,
        _centerLatLng3
      ],
      width: 20,
      strokeColor: Color(0xFFFC9E7E),
      lineJoinType: LineJoinType.Round,
    ));

    _addPersonMarker();
    await Future.delayed(Duration(seconds: 1), () {});
    _addPersonMarker();

    //初始位置
    _controller.addMarker(MarkerOption(
        latLng: _centerLatLng4,
        iconProvider: AssetImage('assets/images/index_icon_pos.png')));
  }

//添加自定义widget
  void _addPersonMarker() {
    _controller.addMarkers([
      for (var item in [_centerLatLng1, _centerLatLng2])
        MarkerOption(
            latLng: item,
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
                        '99',
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      ),
                    ),
                  ),
                  Image(
                      width: 34,
                      height: 34,
                      image: AssetImage('assets/images/default_portrait.png')),
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
    //连续定位
    // int index = 0;
    // Stream<Location> stream = await AmapLocation.instance.listenLocation();
    // await for (final location in stream) {
    //   _controller.setCenterCoordinate(location.latLng);
    //   index += 1;
    //   print('zzz${location.address}:${index}');
    // }

    await _controller?.showMyLocation(MyLocationOption(
        myLocationType: MyLocationType.Follow,
        iconProvider: AssetImage('assets/images/index_icon_daohang.png')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarConfig()
          .configHomeMapAppBar('匹配', context, _leftClick, _righClick),
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
                  print(marker.iosModel.get_title());
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
                    itemCount: 4,
                  ),
                )
              ],
            )));
  }

  //右侧选择list item
  Widget _rightSelectItem(int index) {
    final List titles = ['三元桥', '双井', '健德门', '垂杨柳南里'];
    return GestureDetector(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 48.4,
              padding: EdgeInsets.all(8.5),
              child: Text(
                titles[index],
                style: TextStyle(color: Color(0xFFf89264), fontSize: 10),
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
        print('${titles[index]}');
      },
    );
  }
}
