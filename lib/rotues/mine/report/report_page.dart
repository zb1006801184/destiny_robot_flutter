import 'package:destiny_robot/unitls/local_data.dart';
import 'package:destiny_robot/unitls/nav_bar_config.dart';
import 'package:flutter/material.dart';
import '../../../widgets/alter_widget.dart';

class ReportPage extends StatefulWidget {
  String arguments;
  ReportPage({Key key, this.arguments}) : super(key: key);
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<String> _titles = LocalData.reportTitles;
  List<String> _subTitles = LocalData.reportSubTitles;

  //#####################逻辑处理#####################
  _itemClick(int index) {
    if (index == 0) {
      AlterWidget.showAlterWidget(context, () {
        print('object');
      }, message: '确定举报用户信息作假吗 ？');
    }
    if (index == 1) {
      Navigator.of(context).pushNamed('/ReportSubmitDetailPage',arguments: widget.arguments);
    }
  }

  //#####################widgets#####################
  Widget _itemWidget(int index) {
    return Container(
      margin: EdgeInsets.only(top: 1),
      padding: EdgeInsets.only(left: 17, right: 17),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _titles[index],
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w500),
              ),
              Text(
                _subTitles[index],
                style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFD1D1D1),
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Image.asset('assets/images/list_icon_retu.png')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBarConfig().configAppBar('匿名举报', context),
        body: Padding(
          padding: EdgeInsets.only(top: 6),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                child: _itemWidget(index),
                onTap: () {
                  _itemClick(index);
                },
              );
            },
            itemExtent: 60,
            itemCount: 2,
          ),
        ));
  }
}
