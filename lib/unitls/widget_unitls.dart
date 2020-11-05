import 'package:destiny_robot/unitls/global.dart';
import 'package:flutter/material.dart';

class WidgetUnitls {
  String educationStr(int education) {
    if (education == 0) {
      return '不限';
    }
    if (education == 1) {
      return '高中';
    }
    if (education == 2) {
      return '专科';
    }
    if (education == 3) {
      return '本科';
    }
    if (education == 4) {
      return '硕士';
    }
    if (education == 5) {
      return '博士';
    }
    return '无';
  }

  int educationIndex(String education) {
    if (education == '不限') {
      return 0;
    }
    if (education == '高中') {
      return 1;
    }
    if (education == '专科') {
      return 2;
    }
    if (education == '本科') {
      return 3;
    }
    if (education == '硕士') {
      return 4;
    }
    if (education == '博士') {
      return 5;
    }
    return -1;
  }

  String genderStr(int gender) {
    if (gender == 0) {
      return '男';
    }
    if (gender == 1) {
      return '女';
    }
    if (gender == 2) {
      return '不限';
    }
  }

  int genderInt(String gender) {
    if (gender == '男') {
      return 0;
    }
    if (gender == '女') {
      return 1;
    }
    if (gender == '不限') {
      return 2;
    }
    return -1;
  }

  String interestStr(List interestList) {
    if (interestList.length > 0) {
      var result = StringBuffer();
      interestList.forEach((element) {
        result.write(element);
        if (result.length > 0) {
          result.write('、');
        }
      });
      return result.toString();
    }
    return '';
  }

  //我的-实名认证、学生认证  显示内容

  String mineAythorStr(String title) {
    if (title == '实名认证') {
      if (Global.userModel?.auditState == 1) {
        return '已认证';
      } else {
        return '未实名认证';
      }
    }
    if (title == '学生认证') {
      if (Global.userModel?.studentAuditState == 1) {
        return '已认证';
      } else {
        return '认证获得优先匹配权利';
      }
    }
  }
}
