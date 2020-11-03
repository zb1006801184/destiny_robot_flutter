class SiftUserModel {
  int accountId;
  String nickname;
  String headImgUrl;
  int fateValue;
  double lon;
  double lat;

  SiftUserModel(
      {this.accountId,
      this.nickname,
      this.headImgUrl,
      this.fateValue,
      this.lon,
      this.lat});

  SiftUserModel.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    nickname = json['nickname'];
    headImgUrl = json['headImgUrl'];
    fateValue = json['fateValue'];
    lon = json['lon'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['nickname'] = this.nickname;
    data['headImgUrl'] = this.headImgUrl;
    data['fateValue'] = this.fateValue;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    return data;
  }
}
