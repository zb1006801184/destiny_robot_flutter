import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/material.dart';

class MineCommonItem extends StatefulWidget {
  //item index
  int index;
  //标题
  String title;
  //子标题
  String placerTitle;
  //item 点击时间
  Function itemClick;
  MineCommonItem({this.index, this.title, this.placerTitle, this.itemClick});
  @override
  _MineCommonItemState createState() => _MineCommonItemState();
}

class _MineCommonItemState extends State<MineCommonItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 55,
        width: Global.ksWidth,
        padding: EdgeInsets.only(left: 19.5, right: 17.5),
        margin: EdgeInsets.only(top: widget.index == 0 ? 5 : 1.5),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 15, color: Color(0xFF706863)),
            ),
            Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: Global.ksWidth - 79 - 17.5 - 5 - 20),
                  child: Text(
                    widget.placerTitle,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10, color: Color(0xFFD1D1D1)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 17),
                  width: 5,
                  height: 15,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        widget.itemClick(widget.index);
      },
    );
  }
}
