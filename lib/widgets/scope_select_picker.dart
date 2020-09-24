import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//范围选择器

void showScopePicker(BuildContext context, Function callBackHandler,
    {List leftDataList, List rightDataList}) {
  Navigator.of(context)
      .push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) =>
              FadeTransition(
                  opacity: animation,
                  child: ScopeSelectPicker(
                    leftDataList: leftDataList,
                    rightDataList: rightDataList,
                  ))))
      .then((e) {
    callBackHandler(e);
  });
}

class ScopeSelectPicker extends StatefulWidget {
  //数据源
  List leftDataList;
  List rightDataList;
  //确定回调
  Function sureClick;

  ScopeSelectPicker({this.leftDataList, this.rightDataList, this.sureClick});
  @override
  _ScopeSelectPickerState createState() => _ScopeSelectPickerState();
}

class _ScopeSelectPickerState extends State<ScopeSelectPicker> {
  //左侧选择
  String _selectLeftString;
  //右侧选择
  String _selectRightString;
  //左侧position
  int _leftPosition = 0;
  //右侧position
  int _rightPosition = 0;
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
                  width: Global.ksWidth,
                  decoration: BoxDecoration(
                      color: Color(0xFFEEEFF0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Row(
                    children: [
                      _leftPicker(),
                      _rightPicker(),
                    ],
                  )),
              _leftButton(),
              _rightButon(),
            ],
          ))
        ],
      ),
    );
  }

  //左侧取消按钮
  Widget _leftButton() {
    return Positioned(
        left: 0,
        top: 0,
        child: IconButton(
            icon: Text('取消'),
            onPressed: () {
              Navigator.of(context).pop();
            }));
  }

//右侧的确定按钮
  Widget _rightButon() {
    return Positioned(
        right: 0,
        top: 0,
        child: IconButton(
            icon: Text(
              '确定',
              style: TextStyle(color: Color(0xFFFF706E)),
            ),
            onPressed: () {
              Navigator.of(context).pop(
                  '${widget.leftDataList[_leftPosition]}-${widget.rightDataList[_rightPosition]}');
            }));
  }

  List<Widget> _itemLeftWidget({List dataList}) {
    if (_selectLeftString == null) {
      _selectLeftString = widget.leftDataList[0];
    }
    return [
      for (var item in dataList)
        Text(
          item,
          style: TextStyle(
              color: item == _selectLeftString
                  ? Color(0xFFFF706E)
                  : Color(0xFF968E8A)),
        ),
    ];
  }

  List<Widget> _itemRightWidget({List dataList}) {
    if (_selectRightString == null) {
      _selectRightString = widget.rightDataList[0];
    }
    return [
      for (var item in dataList)
        Text(
          item,
          style: TextStyle(
              color: item == _selectRightString
                  ? Color(0xFFFF706E)
                  : Color(0xFF968E8A)),
        ),
    ];
  }

  Widget _leftPicker() {
    return Container(
      width: Global.ksWidth / 2,
      height: 180,
      padding: EdgeInsets.only(left: 20),
      child: CupertinoPicker(
          itemExtent: 28,
          onSelectedItemChanged: (position) {
            _leftPosition = position;
            setState(() {
              _selectLeftString = widget.leftDataList[position];
            });
          },
          children: _itemLeftWidget(dataList: widget.leftDataList)),
    );
  }

  Widget _rightPicker() {
    return Container(
      width: Global.ksWidth / 2,
      padding: EdgeInsets.only(right: 20),
      height: 180,
      child: CupertinoPicker(
          itemExtent: 28,
          onSelectedItemChanged: (position) {
            _rightPosition = position;
            setState(() {
              _selectRightString = widget.rightDataList[position];
            });
          },
          children: _itemRightWidget(dataList: widget.rightDataList)),
    );
  }
}
