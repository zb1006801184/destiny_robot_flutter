import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

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
    '时辰未知',
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

    print('count---$count');

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

      int count = getNongliDay(int.parse(sYear), int.parse(sMonth));

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
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 2, color: Color(0xFFE53B49)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: Text('取消',
                            style: TextStyle(color: Color(0xFFE53B49))),
                        onTap: () {
                          print('关闭弹框');

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
      int count = getNongliDay(int.parse(sYear), int.parse(sMonth));

      print('农历的天数==${count}');

      List old = day;

      List newDay = old.sublist(0, count);

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

// 计算阳历的这个年份这个月份，天数有几天

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

* 以2014年的数据0x955ABF为例说明：

* 1001 0101 0101 1010 1011 1111

* 闰九月 农历正月初一对应公历1月31号

*/

final List<int> LUNAR_INFO = [
  0x84B6BF,

/*1900*/

  0x04AE53,
  0x0A5748,
  0x5526BD,
  0x0D2650,
  0x0D9544,
  0x46AAB9,
  0x056A4D,
  0x09AD42,
  0x24AEB6,
  0x04AE4A,

/*1901-1910*/

  0x6A4DBE,
  0x0A4D52,
  0x0D2546,
  0x5D52BA,
  0x0B544E,
  0x0D6A43,
  0x296D37,
  0x095B4B,
  0x749BC1,
  0x049754,

/*1911-1920*/

  0x0A4B48,
  0x5B25BC,
  0x06A550,
  0x06D445,
  0x4ADAB8,
  0x02B64D,
  0x095742,
  0x2497B7,
  0x04974A,
  0x664B3E,

/*1921-1930*/

  0x0D4A51,
  0x0EA546,
  0x56D4BA,
  0x05AD4E,
  0x02B644,
  0x393738,
  0x092E4B,
  0x7C96BF,
  0x0C9553,
  0x0D4A48,

/*1931-1940*/

  0x6DA53B,
  0x0B554F,
  0x056A45,
  0x4AADB9,
  0x025D4D,
  0x092D42,
  0x2C95B6,
  0x0A954A,
  0x7B4ABD,
  0x06CA51,

/*1941-1950*/

  0x0B5546,
  0x555ABB,
  0x04DA4E,
  0x0A5B43,
  0x352BB8,
  0x052B4C,
  0x8A953F,
  0x0E9552,
  0x06AA48,
  0x6AD53C,

/*1951-1960*/

  0x0AB54F,
  0x04B645,
  0x4A5739,
  0x0A574D,
  0x052642,
  0x3E9335,
  0x0D9549,
  0x75AABE,
  0x056A51,
  0x096D46,

/*1961-1970*/

  0x54AEBB,
  0x04AD4F,
  0x0A4D43,
  0x4D26B7,
  0x0D254B,
  0x8D52BF,
  0x0B5452,
  0x0B6A47,
  0x696D3C,
  0x095B50,

/*1971-1980*/

  0x049B45,
  0x4A4BB9,
  0x0A4B4D,
  0xAB25C2,
  0x06A554,
  0x06D449,
  0x6ADA3D,
  0x0AB651,
  0x095746,
  0x5497BB,

/*1981-1990*/

  0x04974F,
  0x064B44,
  0x36A537,
  0x0EA54A,
  0x86B2BF,
  0x05AC53,
  0x0AB647,
  0x5936BC,
  0x092E50,
  0x0C9645,

/*1991-2000*/

  0x4D4AB8,
  0x0D4A4C,
  0x0DA541,
  0x25AAB6,
  0x056A49,
  0x7AADBD,
  0x025D52,
  0x092D47,
  0x5C95BA,
  0x0A954E,

/*2001-2010*/

  0x0B4A43,
  0x4B5537,
  0x0AD54A,
  0x955ABF,
  0x04BA53,
  0x0A5B48,
  0x652BBC,
  0x052B50,
  0x0A9345,
  0x474AB9,

/*2011-2020*/

  0x06AA4C,
  0x0AD541,
  0x24DAB6,
  0x04B64A,
  0x6a573D,
  0x0A4E51,
  0x0D2646,
  0x5E933A,
  0x0D534D,
  0x05AA43,

/*2021-2030*/

  0x36B537,
  0x096D4B,
  0xB4AEBF,
  0x04AD53,
  0x0A4D48,
  0x6D25BC,
  0x0D254F,
  0x0D5244,
  0x5DAA38,
  0x0B5A4C,

/*2031-2040*/

  0x056D41,
  0x24ADB6,
  0x049B4A,
  0x7A4BBE,
  0x0A4B51,
  0x0AA546,
  0x5B52BA,
  0x06D24E,
  0x0ADA42,
  0x355B37,

/*2041-2050*/

  0x09374B,
  0x8497C1,
  0x049753,
  0x064B48,
  0x66A53C,
  0x0EA54F,
  0x06AA44,
  0x4AB638,
  0x0AAE4C,
  0x092E42,

/*2051-2060*/

  0x3C9735,
  0x0C9649,
  0x7D4ABD,
  0x0D4A51,
  0x0DA545,
  0x55AABA,
  0x056A4E,
  0x0A6D43,
  0x452EB7,
  0x052D4B,

/*2061-2070*/

  0x8A95BF,
  0x0A9553,
  0x0B4A47,
  0x6B553B,
  0x0AD54F,
  0x055A45,
  0x4A5D38,
  0x0A5B4C,
  0x052B42,
  0x3A93B6,

/*2071-2080*/

  0x069349,
  0x7729BD,
  0x06AA51,
  0x0AD546,
  0x54DABA,
  0x04B64E,
  0x0A5743,
  0x452738,
  0x0D264A,
  0x8E933E,

/*2081-2090*/

  0x0D5252,
  0x0DAA47,
  0x66B53B,
  0x056D4F,
  0x04AE45,
  0x4A4EB9,
  0x0A4D4C,
  0x0D1541,
  0x2D92B5 /*2091-2099*/
];
