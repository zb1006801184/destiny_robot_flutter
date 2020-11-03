import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/material.dart';

class InterestSelectWidget extends StatefulWidget {
  List dataList;
  Function sureCallBack;
  InterestSelectWidget({this.dataList, this.sureCallBack});

  void showInterestSelect(BuildContext context, List dataList,
      {Function sureCallBack}) {
    Navigator.of(context)
        .push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) =>
                FadeTransition(
                    opacity: animation,
                    child: InterestSelectWidget(
                      dataList: dataList,
                      sureCallBack: sureCallBack,
                    ))))
        .then((e) {});
  }

  @override
  _InterestSelectWidgetState createState() => _InterestSelectWidgetState();
}

class _InterestSelectWidgetState extends State<InterestSelectWidget> {
  List <dynamic>resultList = [];
  //########widget########
  Widget title = Container(
    margin: EdgeInsets.only(top: 28),
    child: Center(
      child: Text(
        '兴趣爱好',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),
  );

  Widget _girdViewWidget() {
    return Container(
      width: 310.0 - 32,
      height: 262,
      margin: EdgeInsets.only(top: 8),
      child: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 2.0,
        mainAxisSpacing: 11.5,
        crossAxisSpacing: 13.0,
        children: _listItems(),
      ),
    );
  }

  List<Widget> _listItems() {
    List<Widget> result = [];
    widget.dataList.forEach((element) {
      result.add(GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              border: new Border.all(color: Color(0xFFFFFF6F6D), width: 1),
              borderRadius: BorderRadius.circular(15),
              color: resultList.contains(element)
                  ? Color(0xFFFFFF6F6D)
                  : Colors.white),
          child: Center(
            child: Text(
              element,
              style: TextStyle(
                  color: resultList.contains(element)
                      ? Colors.white
                      : Color(0xFFFFFF6F6D),
                  fontSize: 11),
            ),
          ),
        ),
        onTap: () {
          siftSelect(element);
        },
      ));
    });
    return result;
  }

  Widget _noticeWidget() {
    return Container(
      width: Global.ksWidth,
      padding: EdgeInsets.only(left: 16, top: 16),
      child: Text(
        "*请最多选择六项",
        style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFFFF000C)),
      ),
    );
  }

  Widget _bottomButtonWidget() {
    return Container(
      margin: EdgeInsets.only(top: 18.5),
      width: 260,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _button(
              bgcolor: Color(0xFFFFEDEFF0),
              titleColor: Color(0xFFFF706863),
              title: '取消'),
          _button(
              bgcolor: Color(0xFFFFFF6F6D),
              titleColor: Color(0xFFFFFFFEFE),
              title: '确定'),
        ],
      ),
    );
  }

  Widget _button({Color bgcolor, Color titleColor, String title}) {
    return GestureDetector(
      child: Container(
        height: 44,
        width: 125,
        decoration: BoxDecoration(
            color: bgcolor, borderRadius: BorderRadius.circular(22)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 15,
            ),
          ),
        ),
      ),
      onTap: () {
        _buttonClick(title: title);
      },
    );
  }

//########action#########

//取消、确认按钮点击
  void _buttonClick({String title}) {
    if (title == '确定') {
      widget.sureCallBack(resultList);
    }
    Navigator.of(context).pop();
  }

//筛选是否选中
  void siftSelect(String title) {
    if (resultList.contains(title)) {
      resultList.remove(title);
    } else {
      if (resultList.length >= 5) return;
      resultList.add(title);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: InkWell(
        child: Center(
          child: GestureDetector(
            child: Container(
              height: 450,
              width: 310,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  title,
                  _girdViewWidget(),
                  _noticeWidget(),
                  _bottomButtonWidget(),
                ],
              ),
            ),
            onTap: () {},
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
