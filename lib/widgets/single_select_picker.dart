import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showPicker(BuildContext context, Function callBackHandler) {
  Navigator.of(context)
      .push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) =>
              FadeTransition(opacity: animation, child: SingleSelectPicker())))
      .then((e) {
    callBackHandler(e);
  });
}

class SingleSelectPicker extends StatefulWidget {
  List dataList ;
  SingleSelectPicker({this.dataList});
  @override
  _SingleSelectPickerState createState() => _SingleSelectPickerState();
}

class _SingleSelectPickerState extends State<SingleSelectPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Column(
        children: [
          InkWell(
            child: Container(
              height: Global.ksHeight - 200,
              width: Global.ksWidth,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Container(
            height: 200,
            color: Colors.white,
            child: CupertinoPicker(
                itemExtent: 28,
                onSelectedItemChanged: (position) {},
                children: _itemWidget()),
          )
        ],
      ),
    );
  }

  List<Widget> _itemWidget() {
    return [
      Text("0"),
      Text("1"),
      Text("2"),
      Text("3"),
      Text("4"),
    ];
  }
}
