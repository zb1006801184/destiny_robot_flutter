import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../unitls/nav_bar_config.dart';

class MapHome extends StatefulWidget {
  @override
  _MapHomeState createState() => _MapHomeState();
}

class _MapHomeState extends State<MapHome> {
  AmapController _controller;
  LatLng _centerLatLng;
  void _righClick() {
    print('right');
  }

  void _leftClick() {
    print('left');
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
    ));
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
        )
      ]),
    );
  }
}
