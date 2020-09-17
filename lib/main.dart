import 'package:destiny_robot/unitls/sp_util.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'state/provider_store.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(Store.init(child: MyApp()));

  await enableFluttifyLog(false);
  //初始化地图
  await AmapService.init(
    iosKey: 'cbe00823663a07e543d2d54430432272',
    androidKey: 'c91e45151b799ec4bd6f73508e7d28ea',
  );
  
  //初始化定位
  await AmapCore.init('cbe00823663a07e543d2d54430432272');

}
