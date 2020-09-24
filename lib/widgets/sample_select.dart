import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/material.dart';

void showSampleSelect(BuildContext context, 
    {List dataList,Function callBackHandler}) {
  Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) =>
          FadeTransition(
              opacity: animation,
              child: SampleSelect(
                dataList: dataList,
                callBackHandler: callBackHandler,
              ))));
}

class SampleSelect extends StatefulWidget {
  List dataList;
  Function callBackHandler;
  SampleSelect({this.dataList, this.callBackHandler});
  @override
  _SampleSelectState createState() => _SampleSelectState();
}

class _SampleSelectState extends State<SampleSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _bottomWidget(),
        ],
      ),
    );
  }

  //bottomWidget
  Widget _bottomWidget() {
    return Container(
      height: 180,
      width: Global.ksWidth,
      color: Color(0xFFEDEFF0),
      child: Column(
        children: [
          _listWidget(),
          GestureDetector(
            child: Container(
              height: 44,
              margin: EdgeInsets.only(bottom: 16.5, left: 14.5, right: 14.5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(22)),
              child: Center(
                child: Text('取消'),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

//List widget
  Widget _listWidget() {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) {
        return _itemWidget(index);
      },
      itemCount: widget.dataList.length ?? 0,
    ));
  }

  Widget _itemWidget(int index) {
    return InkWell(child: Container(
      height: 50,
      padding: EdgeInsets.only(left: 20, right: 20),
      width: Global.ksWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.dataList[index],
            style: TextStyle(color: Color(0xFF706863), fontSize: 14),
          ),
          Container(
              height: 0.5,
              margin: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 15),
              color: Color(0xFFD1D1D1)),
        ],
      ),
    ),
    onTap: (){
      Navigator.of(context).pop();
      widget.callBackHandler(index);
    },
    );
  }
}
