import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/material.dart';

class MineCommonItem extends StatefulWidget {
  //item index
  int index;
  //标题
  String title;
  //子标题
  String placerTitle;
  //是否显示星星
  bool isShowStar;
  //子标题样式(内容true,提示false )
  bool isShowContent;
  //item 点击时间
  Function itemClick;
  MineCommonItem(
      {this.index,
      this.title,
      this.placerTitle,
      this.isShowStar,
      this.isShowContent,
      this.itemClick});
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
            RichText(
                text: TextSpan(
                    text: widget.title,
                    style: TextStyle(color: Color(0xFF000000)),
                    children: <TextSpan>[
                  TextSpan(
                      text: widget.isShowStar == true ? ' *' : '',
                      style: TextStyle(color: Color(0xFFFE0301))),
                ])),
            Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: Global.ksWidth - 79 - 17.5 - 5 - 20),
                  child: Text(
                    widget.placerTitle,
                    overflow: TextOverflow.ellipsis,
                    style: widget.isShowContent == true
                        ? TextStyle(fontSize: 14, color: Color(0xFF706864))
                        : TextStyle(fontSize: 10, color: Color(0xFFD1D1D1)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 17),
                  width: 5,
                  height: 9,
                  child: Image.asset('assets/images/list_icon_retu.png'),
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
