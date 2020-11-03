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
      String result = '';
      interestList.forEach((element) {
        result = result + '、';
      });
      result = result.substring(1);
      return result;
    }
    return '';
  }
}
