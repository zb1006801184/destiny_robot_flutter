import 'package:destiny_robot/unitls/sp_util.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'state/provider_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(Store.init(child: MyApp()));
}
