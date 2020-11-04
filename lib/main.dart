import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/platform_unitls.dart';
import 'package:destiny_robot/unitls/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'state/provider_store.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  Global.init().then((e) {
    runApp(Store.init(child: MyApp()));
  });

  if (PlatformUtils.isAndroid) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light);

    SystemChrome.setSystemUIOverlayStyle(style);
  }

  await enableFluttifyLog(false);
  //初始化地图
  await AmapService.init(
    iosKey: 'cb185f64c4234f28297b93046d9bb241',
    androidKey: 'c91e45151b799ec4bd6f73508e7d28ea',
  );

  //初始化定位
  await AmapCore.init('cb185f64c4234f28297b93046d9bb241');
}
