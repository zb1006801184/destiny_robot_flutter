import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//单行选择器
void showPicker(BuildContext context, Function callBackHandler,
    {List dataList}) {
  Navigator.of(context)
      .push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) =>
              FadeTransition(
                  opacity: animation,
                  child: SingleSelectPicker(
                    dataList: dataList,
                  ))))
      .then((e) {
    callBackHandler(e);
  });
}

class SingleSelectPicker extends StatefulWidget {
  //数据源
  List dataList;
  //确定回调
  Function sureClick;

  SingleSelectPicker({this.dataList, this.sureClick});
  @override
  _SingleSelectPickerState createState() => _SingleSelectPickerState();
}

class _SingleSelectPickerState extends State<SingleSelectPicker> {
  int _position = 0;
  String _selectStr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Column(
        children: [
          InkWell(
            child: Container(
              height: Global.ksHeight - 180,
              width: Global.ksWidth,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Expanded(
              child: Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                    color: Color(0xFFEEEFF0),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: CupertinoPicker(
                    itemExtent: 28,
                    onSelectedItemChanged: (position) {
                      _position = position;
                      setState(() {
                        _selectStr = widget.dataList[position];
                      });
                    },
                    children: _itemWidget()),
              ),
              Positioned(
                  left: 0,
                  top: 0,
                  child: IconButton(
                      icon: Text('取消'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })),
              Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                      icon: Text(
                        '确定',
                        style: TextStyle(color: Color(0xFFFF706E)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(widget.dataList[_position]);
                      })),
            ],
          ))
        ],
      ),
    );
  }

  List<Widget> _itemWidget() {
    if (_selectStr == null) {
      _selectStr = widget.dataList[0];
    }
    return [
      for (var item in widget.dataList) Text(item,style: TextStyle(
        color: item==_selectStr?Color(0xFFFF706E):Color(0xFF968E8A)
      ),),
    ];
  }
}
