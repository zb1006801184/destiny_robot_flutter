import 'package:flutter/material.dart';

class AlterWidget extends StatefulWidget {
  String messageSting;
  Function callBackHandler;
  AlterWidget({Key key, this.messageSting, this.callBackHandler})
      : super(key: key);
  @override
  _AlterWidgetState createState() => _AlterWidgetState();

  static void showAlterWidget(BuildContext context, Function callBackHandler,
      {String message}) {
    Navigator.of(context)
        .push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) =>
                FadeTransition(
                    opacity: animation,
                    child: AlterWidget(
                      messageSting: message,
                      callBackHandler: callBackHandler,
                    ))))
        .then((e) {});
  }
}

class _AlterWidgetState extends State<AlterWidget> {
  String _messageSting;
  Function _callBackHandler;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageSting = widget.messageSting;
    _callBackHandler = widget.callBackHandler;
  }

//###############widgets###############
  //标题
  Widget _titleWidget() {
    return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.only(top: 28),
          child: Text(
            '提示',
            style: TextStyle(
                fontSize: 15,
                color: Color(
                  0xFF000000,
                ),
                fontWeight: FontWeight.w500),
          ),
        ));
  }

  //提示信息
  Widget _messageWidget() {
    return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            _messageSting,
            style: TextStyle(
                fontSize: 13,
                color: Color(
                  0xFF000000,
                ),
                fontWeight: FontWeight.w500),
          ),
        ));
  }

  //底部按钮
  Widget _bottomButtonWidget() {
    return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Container(
                  height: 44,
                  width: 125,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Color(0xFFEDEFF0)),
                  child: Center(
                    child: Text(
                      '取消',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF706863),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              GestureDetector(
                child: Container(
                  height: 44,
                  width: 125,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Color(0xFFFF6F6D)),
                  child: Center(
                    child: Text(
                      '确认',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _callBackHandler();
                },
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 200,
              width: 310,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  _titleWidget(),
                  _messageWidget(),
                  _bottomButtonWidget()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
