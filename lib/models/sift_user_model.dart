import 'package:destiny_robot/unitls/common_tool.dart';

class SiftUserModel {
  int accountId;
  String nickname;
  String headImgUrl;
  int fateValue;
  String createdTime;
  double lon;
  double lat;
  String interest;

  SiftUserModel(
      {this.accountId,
      this.nickname,
      this.headImgUrl,
      this.fateValue,
      this.lon,
      this.lat,
      this.interest
      });

  SiftUserModel.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    nickname = json['nickname'];
    headImgUrl = json['headImgUrl'];
    fateValue = json['fateValue'];
    createdTime = CommonTool().getHourTime(json['createdTime']);
    lon = json['lon'];
    lat = json['lat'];
    interest = json['interest']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['nickname'] = this.nickname;
    data['headImgUrl'] = this.headImgUrl;
    data['fateValue'] = this.fateValue;
    data['createdTime'] = this.createdTime;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    return data;
  }
}
