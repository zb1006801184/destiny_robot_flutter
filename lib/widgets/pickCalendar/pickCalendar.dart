import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'calendar_utils.dart';

void incrementCounter(context) {
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
              body: Stack(children: <Widget>[PickBody()])));
    },
  );
}

class PickBody extends StatefulWidget {
  PickBody({Key key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
// 切换农历和阳历的时候更换月份和天的称呼

    if (gongli) {
      month = yMonth;

      day = yday;
    } else {
      month = nMonth;

      // int count = getNongliDay(int.parse(sYear), int.parse(sMonth));
      int count = CalendarUtils().monthDays(int.parse(sYear), int.parse(sMonth));

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
                        onTap: () {
                          print('确定 关闭弹框');

                          print(sYear);

                          print(sMonth);

                          print(sDay);

                          print(sTime);

                          Navigator.pop(context);
                        },
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
                                  if (index == 0) {
                                    sTime = '24';
                                  } else {
                                    sTime = '${index - 1}';
                                  }
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
      int count = CalendarUtils().monthDays(int.parse(sYear), int.parse(sMonth));

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

// 计算阴历的这个年份这个月份，天数有几天

int getNongliDay(int year, int month) {
  if ((LUNAR_INFO[year - 1900] & (0x100000 >> month)) == 0)
    return 29;
  else
    return 30;
}

/**

* 用来表示1900年到2099年间农历年份的相关信息，共24位bit的16进制表示，其中：

* 1. 前4位表示该年闰哪个月；

* 2. 5-17位表示农历年份13个月的大小月分布，0表示小，1表示大；

* 3. 最后7位表示农历年首（正月初一）对应的公历日期。

* <p/>

* 以2004年的数据0x955ABF为例说明：

* 1001 0101 0101 1010 1011 1111

* 闰九月 农历正月初一对应公历1月31号

*/

final List<int> LUNAR_INFO = [
  0x04bd8, 0x04ae0, 0x0a570, 0x054d5, 0x0d260, 0x0d950, 0x16554, 0x056a0,
  0x09ad0, 0x055d2, //1900-1909
  0x04ae0, 0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0b540, 0x0d6a0, 0x0ada2,
  0x095b0, 0x14977, //1910-1919
  0x04970, 0x0a4b0, 0x0b4b5, 0x06a50, 0x06d40, 0x1ab54, 0x02b60, 0x09570,
  0x052f2, 0x04970, //1920-1929
  0x06566, 0x0d4a0, 0x0ea50, 0x06e95, 0x05ad0, 0x02b60, 0x186e3, 0x092e0,
  0x1c8d7, 0x0c950, //1930-1939
  0x0d4a0, 0x1d8a6, 0x0b550, 0x056a0, 0x1a5b4, 0x025d0, 0x092d0, 0x0d2b2,
  0x0a950, 0x0b557, //1940-1949
  0x06ca0, 0x0b550, 0x15355, 0x04da0, 0x0a5b0, 0x14573, 0x052b0, 0x0a9a8,
  0x0e950, 0x06aa0, //1950-1959
  0x0aea6, 0x0ab50, 0x04b60, 0x0aae4, 0x0a570, 0x05260, 0x0f263, 0x0d950,
  0x05b57, 0x056a0, //1960-1969
  0x096d0, 0x04dd5, 0x04ad0, 0x0a4d0, 0x0d4d4, 0x0d250, 0x0d558, 0x0b540,
  0x0b6a0, 0x195a6, //1970-1979
  0x095b0, 0x049b0, 0x0a974, 0x0a4b0, 0x0b27a, 0x06a50, 0x06d40, 0x0af46,
  0x0ab60, 0x09570, //1980-1989
  0x04af5, 0x04970, 0x064b0, 0x074a3, 0x0ea50, 0x06b58, 0x055c0, 0x0ab60,
  0x096d5, 0x092e0, //1990-1999
  0x0c960, 0x0d954, 0x0d4a0, 0x0da50, 0x07552, 0x056a0, 0x0abb7, 0x025d0,
  0x092d0, 0x0cab5, //2000-2009
  0x0a950, 0x0b4a0, 0x0baa4, 0x0ad50, 0x055d9, 0x04ba0, 0x0a5b0, 0x15176,
  0x052b0, 0x0a930, //2010-2019
  0x07954, 0x06aa0, 0x0ad50, 0x05b52, 0x04b60, 0x0a6e6, 0x0a4e0, 0x0d260,
  0x0ea65, 0x0d530, //2020-2029
  0x05aa0, 0x076a3, 0x096d0, 0x04afb, 0x04ad0, 0x0a4d0, 0x1d0b6, 0x0d250,
  0x0d520, 0x0dd45, //2030-2039
  0x0b5a0, 0x056d0, 0x055b2, 0x049b0, 0x0a577, 0x0a4b0, 0x0aa50, 0x1b255,
  0x06d20, 0x0ada0, //2040-2049
  /**Add By JJonline@JJonline.Cn**/
  0x14b63, 0x09370, 0x049f8, 0x04970, 0x064b0, 0x168a6, 0x0ea50, 0x06b20,
  0x1a6c4, 0x0aae0, //2050-2059
  0x0a2e0, 0x0d2e3, 0x0c960, 0x0d557, 0x0d4a0, 0x0da50, 0x05d55, 0x056a0,
  0x0a6d0, 0x055d4, //2060-2069
  0x052d0, 0x0a9b8, 0x0a950, 0x0b4a0, 0x0b6a6, 0x0ad50, 0x055a0, 0x0aba4,
  0x0a5b0, 0x052b0, //2070-2079
  0x0b273, 0x06930, 0x07337, 0x06aa0, 0x0ad50, 0x14b55, 0x04b60, 0x0a570,
  0x054e4, 0x0d160, //2080-2089
  0x0e968, 0x0d520, 0x0daa0, 0x16aa6, 0x056d0, 0x04ae0, 0x0a9d4, 0x0a2d0,
  0x0d150, 0x0f252, //2090-2099
  0x0d520
];
