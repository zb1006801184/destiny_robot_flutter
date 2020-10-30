import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'calendar_utils.dart';

void incrementCounter(context, {Function callBack}) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
// 用Scaffold返回显示的内容，能跟随主题
      return GestureDetector(
          onTap: () {
            // Navigator.pop(context);
          },
          child: Scaffold(
              backgroundColor: Colors.transparent, // 设置透明背影
              body: Stack(children: <Widget>[
                PickBody(
                  callBack: callBack,
                )
              ])));
    },
  );
}

class PickBody extends StatefulWidget {
  Function callBack;
  PickBody({Key key, this.callBack}) : super(key: key);

  @override
  _PickBodyState createState() => _PickBodyState();
}

class _PickBodyState extends State<PickBody> {
  bool gongli = true;

  String sYear = "2000";

  String sMonth = '6';

  String sDay = '15';

  String sTime = '24';

  List year = [], month = [], yMonth = [], day = [], yday = [];

  List nMonth = ['正', '二', '三', '四', '五', '六', '七', '八', '九', '十', '冬', '腊'];

  List time = [
    '未知',
    '23:00-1:00(子时)',
    '1:00-3:00(丑时)',
    '3:00-5:00(寅时)',
    '5:00-7:00(卯辰)',
    '7:00-9:00(辰时)',
    '9:00-11:00(巳时)',
    '11:00-13:00(午时)',
    '13:00-15:00(未时)',
    '15:00-17:00(申时)',
    '17:00-19:00(酉时)',
    '19:00-21:00(戌时)',
    '21:00-23:00(亥时)',
  ];

  List nday = [
    '初一',
    '初二',
    '初三',
    '初四',
    '初五',
    '初六',
    '初七',
    '初八',
    '初九',
    '初十',
    '十一',
    '十二',
    '十三',
    '十四',
    '十五',
    '十六',
    '十七',
    '十八',
    '十九',
    '二十',
    '廿一',
    '廿二',
    '廿三',
    '廿四',
    '廿五',
    '廿六',
    '廿七',
    '廿八',
    '廿九',
    '三十',
    '三十一'
  ];

//默认年份
  FixedExtentScrollController yearController =
      new FixedExtentScrollController(initialItem: 20);

  FixedExtentScrollController monthController =
      new FixedExtentScrollController(initialItem: 5);

  FixedExtentScrollController dayController =
      new FixedExtentScrollController(initialItem: 14);

  FixedExtentScrollController timeController =
      new FixedExtentScrollController();

  @override
  void initState() {
// TODO: implement initState

    super.initState();

// 获取当天的日期，年份默认选择的是2000年,月份默认是6月，日期默认是15日，时间默认是不详

    DateTime today = DateTime.now();

// 请空之前的数据

    for (var y = 1980; y < today.year + 1; y++) {
      year.add('$y');
    }

    yMonth = [];

    for (int m = 1; m < 13; m++) {
      yMonth.add('$m');
    }

// 获取默认年份和月份之下的天数

    int count = getYangliDay(int.parse(sYear), int.parse(sMonth));

    yday = [];

    for (int m = 1; m < count + 1; m++) {
      yday.add('$m');
    }
  }

  void sureClick() {
    print('确定 关闭弹框');

    print(sYear);

    print(sMonth);

    print(sDay);

    print(sTime);

    int birthday =
        DateTime(int.parse(sYear), int.parse(sMonth), int.parse(sDay))
            .millisecondsSinceEpoch;

    Navigator.pop(context);
    widget.callBack({
      'birthdayStr': '${sYear}-${sMonth}-${sDay}  ${sTime}',
      'birthday': '${birthday}'
    });
  }
  //计算时间戳

  @override
  Widget build(BuildContext context) {
// 切换农历和阳历的时候更换月份和天的称呼

    if (gongli) {
      month = yMonth;

      day = yday;
    } else {
      month = nMonth;

      // int count = getNongliDay(int.parse(sYear), int.parse(sMonth));
      int count =
          CalendarUtils().monthDays(int.parse(sYear), int.parse(sMonth));

      print('农历的天数==${count}');

      List old = nday;

      List newDay = old.sublist(0, count);

// 初始化当前的选中的月份的天数

      day = newDay;
    }

    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
            height: 300,
            decoration: BoxDecoration(color: Colors.white),

// padding: EdgeInsets.all(10),

            child: Column(children: <Widget>[
              //顶部切换
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          // bottom:
                          //     BorderSide(width: 2, color: Color(0xFFE53B49))
                          )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: Text('取消',
                            style: TextStyle(color: Color(0xFFE53B49))),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            FlatButton(
                              child: Text('公历'),
                              onPressed: () {
                                setState(() {
                                  gongli = true;
                                });
                              },
                              color: gongli ? Color(0xFFE53B49) : Colors.white,
                              textColor:
                                  gongli ? Colors.white : Color(0xFFE53B49),
                              shape: BeveledRectangleBorder(
                                  side: BorderSide(
                                      color: Color(0xFFE53B49), width: 1),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(3),
                                      bottomLeft: Radius.circular(3))),
                            ),
                            FlatButton(
                              child: Text('农历'),
                              splashColor: Color(0xFFE53B49),
                              color: gongli ? Colors.white : Color(0xFFE53B49),
                              textColor:
                                  gongli ? Color(0xFFE53B49) : Colors.white,
                              shape: BeveledRectangleBorder(
                                  side: BorderSide(
                                      color: Color(0xFFE53B49), width: 1),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(3),
                                      bottomRight: Radius.circular(3))),
                              onPressed: () {
                                setState(() {
                                  gongli = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Text('确定',
                            style: TextStyle(color: Color(0xFFE53B49))),
                        onTap: sureClick,
                      ),
                    ],
                  )),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                            height: 200,
                            child: CupertinoPicker(
                              useMagnifier: true,

                              magnification: 1.2,

                              squeeze: 1,

                              diameterRatio: 1.5,

                              looping: false,

                              backgroundColor: Colors.transparent, //选择器背景色

                              itemExtent: 35, //item的高度

                              onSelectedItemChanged: (index) {
                                print('index === $index');

                                int selectYear = 1980 + index;

// 更改年的时候，查询选中的年和月的天数

                                print("选中年 = ${selectYear}");

                                setState(() {
                                  sYear = '$selectYear';

// 更换年的时候检测是阳历还是农历
                                  updateDay();

// monthController.jumpToItem(3);
                                });
                              },

                              scrollController: yearController,

                              children: XZItem(year, '年'),
                            ))),
                    Expanded(
                        flex: 1,
                        child: Container(
                            height: 200,
                            child: CupertinoPicker(
                              useMagnifier: true,

                              magnification: 1.2,

                              squeeze: 1,

                              diameterRatio: 1.5,

                              looping: false,

                              backgroundColor: Colors.transparent, //选择器背景色

                              itemExtent: 35, //item的高度

                              onSelectedItemChanged: (index) {
//选中item的位置索引

                                print("月index = $index}");

                                setState(() {
                                  sMonth = '${index + 1}';
                                });

                                sMonth = '${index + 1}';

                                updateDay();
                              },

                              scrollController: monthController,

                              children: XZItem(month, '月'),
                            ))),
                    Expanded(
                        flex: 1,
                        child: Container(
                            height: 200,
                            child: CupertinoPicker(
                              useMagnifier: true,

                              magnification: 1.2,

                              squeeze: 1,

                              diameterRatio: 1.5,

                              looping: false,

                              backgroundColor: Colors.transparent, //选择器背景色

                              itemExtent: 35, //item的高度

                              onSelectedItemChanged: (index) {
//选中item的位置索引

                                print("日index = $index}");

                                setState(() {
                                  sDay = '${index + 1}';
                                });

                                sDay = '${index + 1}';
                              },

                              scrollController: dayController,

                              children: XZItem(day, '日'),
                            ))),
                    Expanded(
                        flex: 2,
                        child: Container(
                            height: 200,
                            child: CupertinoPicker(
                              useMagnifier: true,

                              magnification: 1.2,

                              squeeze: 1,

                              diameterRatio: 1.5,

                              looping: false,

                              backgroundColor: Colors.transparent, //选择器背景色

                              itemExtent: 35, //item的高度

                              onSelectedItemChanged: (index) {
//选中item的位置索引

                                print("index = $index}");

                                setState(() {
                                  // if (index == 0) {
                                  //   sTime = '24';
                                  // } else {
                                  //   sTime = '${index - 1}';
                                  // }
                                  sTime = time[index];
                                });
                              },

                              scrollController: timeController,

                              children: XZItem(time, ''),
                            ))),
                  ])
            ])));
  }

  updateDay() {
    if (gongli) {
// 公历// 截取天数

      print('widget.sYear ==== ${sYear}');

      print('widget.sMonth ==== ${sMonth}');

      print('widget.sDay ==== ${sDay}');

      int count = getYangliDay(int.parse(sYear), int.parse(sMonth));

      print('count---$count');

      yday = [];

      for (int m = 1; m < count + 1; m++) {
        yday.add('$m');
      }
    } else {
      // int count = getNongliDay(int.parse(sYear), int.parse(sMonth));
      int count =
          CalendarUtils().monthDays(int.parse(sYear), int.parse(sMonth));

      print('农历的天数==${count}');

      List old = nday;

      List newDay = nday.sublist(0, count);

      print(old);

      print(newDay);

      day = newDay;
    }
  }

  List<Widget> XZItem(_data, type) {
    List<Widget> list = new List();

    for (var i = 0; i < _data.length; i++) {
      list.add(Text('${_data[i]}$type',
          style: TextStyle(color: Colors.black, fontSize: 14)));
    }

    return list;
  }
}

// 计算阳历的这个年份这个月份，天数有几天

getYangliDay(year, month) {
  int count = 0;

//判断大月份

  if (month == 1 ||
      month == 3 ||
      month == 5 ||
      month == 7 ||
      month == 8 ||
      month == 10 ||
      month == 12) {
    count = 31;
  }

//判断小月

  if (month == 4 || month == 6 || month == 9 || month == 11) {
    count = 30;
  }

//判断平年与闰年

  if (month == 2) {
    if (isLeapYear(year)) {
      count = 29;
    } else {
      count = 28;
    }
  }

  return count;
}

/**

* 是否是闰年

*/

bool isLeapYear(int year) {
  return ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
}
