import 'package:flutter/material.dart';

class InterestSelectWidget extends StatefulWidget {
  List dataList;
  InterestSelectWidget({this.dataList});

  void showInterestSelect(BuildContext context, List dataList) {
    Navigator.of(context)
        .push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) =>
                FadeTransition(
                    opacity: animation,
                    child: InterestSelectWidget(
                      dataList: dataList,
                    ))))
        .then((e) {});
  }

  @override
  _InterestSelectWidgetState createState() => _InterestSelectWidgetState();
}

class _InterestSelectWidgetState extends State<InterestSelectWidget> {
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
      margin: EdgeInsets.only(top: 26),
      color: Colors.red,
    );
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
