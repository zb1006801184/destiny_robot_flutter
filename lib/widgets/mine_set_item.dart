import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/material.dart';

class MineSetItem extends StatefulWidget {
  String title;
  String icon;
  MineSetItem({this.title, this.icon});
  @override
  _MineSetItemState createState() => _MineSetItemState();
}

class _MineSetItemState extends State<MineSetItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Global.ksWidth,
      height: 55,
      margin: EdgeInsets.only(top: 1),
      color: Colors.white,
      padding: EdgeInsets.only(left: 17, right: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _rowWidget(),
          Container(
            child: Image.asset('assets/images/list_icon_retu.png'),
          )
        ],
      ),
    );
  }

  Widget _rowWidget() {
    return Row(
      children: [
        Image.asset(widget.icon),
        Container(
          margin: EdgeInsets.only(left: 21),
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 15, color: Color(0xFF000000)),
          ),
        ),
      ],
    );
  }
}
