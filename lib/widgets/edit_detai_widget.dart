import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/material.dart';

//编辑资料-个人信息- 编辑(昵称/现居住地)
class EditDetailWidget extends StatefulWidget {
  String title;
  EditDetailWidget({this.title});
  @override
  _EditDetailWidgetState createState() => _EditDetailWidgetState();
}

class _EditDetailWidgetState extends State<EditDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: InkWell(
        child: Container(
            width: Global.ksWidth,
            height: Global.ksHeight,
            child: Center(
              child: Container(
                  width: 310,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: _buildColunWidget()),
            )),
        onTap: () {
          Navigator.of(context).pop(widget.title);
        },
      ),
    );
  }

  Widget _buildColunWidget() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 28),
          child: Text(
            "编辑" + widget.title,
            style: TextStyle(
                fontSize: 15,
                color: Color(0xFF706864),
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none),
          ),
        ),
        _buildInputBox(),
        Container(
            margin: EdgeInsets.only(top: 20),
            width: 258,
            height: 44,
            child: _buildBottomButton()),
      ],
    );
  }

  //输入框
  Widget _buildInputBox() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: 258,
      height: 33,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Color(0xFFEDEFF0)),
      child: TextField(
        style: TextStyle(fontSize: 10),
        showCursor: true,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 6.5, bottom: 14),
            hintStyle: TextStyle(color: Color(0xFFAEAFB7), fontSize: 10),
            hintText: '请输入' + widget.title),
      ),
    );
  }

  //底部俩个按钮
  Widget _buildBottomButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 125,
          height: 44,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Color(0xFFEDEFF0)),
          child:
              Center(child: _buildText(title: '取消', color: Color(0xFFFF7061))),
        ),
        Container(
          width: 125,
          height: 44,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Color(0xFFFF706E)),
          child: Center(child: _buildText(title: '确定', color: Colors.white)),
        ),
      ],
    );
  }

//文本样式
  Widget _buildText({String title, Color color}) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 15,
            color: color,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
      ),
    );
  }
}
