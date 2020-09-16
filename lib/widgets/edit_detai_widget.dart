import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/material.dart';
//编辑资料-个人信息- 编辑(昵称/性别/生辰/身高/现居住地)
class EditDetailWidget extends StatefulWidget {
  String title;
  EditDetailWidget({this.title});
  @override
  _EditDetailWidgetState createState() => _EditDetailWidgetState();
}

class _EditDetailWidgetState extends State<EditDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        width: Global.ksWidth,
        height: Global.ksHeight,
        child: Center(
          child: Text(widget.title),
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}
