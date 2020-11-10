import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/material.dart';

//对话-更多弹框
class MoreListSelectWidget extends StatefulWidget {
  List dataList;
  Function callBackHandler;
  MoreListSelectWidget({Key key, this.dataList, this.callBackHandler})
      : super(key: key);
  @override
  _MoreListSelectWidgetState createState() => _MoreListSelectWidgetState();

  static void showSelectWidget(BuildContext context, Function callBackHandler,
      {List dataList}) {
    Navigator.of(context)
        .push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) =>
                FadeTransition(
                    opacity: animation,
                    child: MoreListSelectWidget(
                      dataList: dataList,
                      callBackHandler: callBackHandler,
                    ))))
        .then((e) {
      // callBackHandler(e);
    });
  }
}

class _MoreListSelectWidgetState extends State<MoreListSelectWidget> {
  List _dataList;
  Function _callBackHandler;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataList = widget.dataList ?? [];
    _callBackHandler = widget.callBackHandler;
  }

  Widget _item(String title, {int index}) {
    if (index == _dataList?.length ?? 0) {
      return Container(
        height: 80,
        child: Center(
            child: GestureDetector(
          child: Container(
            height: 44,
            width: Global.ksWidth - 40,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(44 / 2)),
            child: Center(
              child: Text(
                '取消',
                style: TextStyle(fontSize: 14, color: Color(0xFF706863)),
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        )),
      );
    }
    String title = _dataList[index];
    return GestureDetector(
      child: Container(
        height: 50,
        color: Color(0xFF0EDEFF0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Text(
              title,
              style: TextStyle(
                  fontSize: 14,
                  color: title == '举报' ? Color(0xFFFF6F6D) : Color(0xFF706863)),
            ),
            Container(
              height: 0.5,
              margin: EdgeInsets.only(left: 19, right: 19),
              color: Color(0xFFD1D1D1),
            ),
          ],
        ),
      ),
      onTap: () {
        _callBackHandler(title);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              child: Container(
                width: Global.ksWidth,
                height: (_dataList?.length * 50.0) + 80.0 + 20,
                decoration: BoxDecoration(color: Color(0xFFEDEFF0)),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return _item('', index: index);
                  },
                  itemCount: _dataList.length + 1,
                ),
              ))
        ],
      ),
    );
  }
}
