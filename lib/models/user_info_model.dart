class UserInfoModel {
  String accessToken;
  String tokenType;
  String refreshToken;
  int expiresIn;
  String scope;
  String nickname;
  String headImgUrl;
  String gender;
  String birthday;
  String height;
  String address;
  String major;
  String education;
  String school;
  String hometown;
  String interest;
  String details;
  String idCardFront;
  String idCardReverse;
  String studentFront;
  String studentReverse;
  String auditState;
  String studentAuditState;
  String auditMsg;
  String matchingState;

  UserInfoModel(
      {this.accessToken,
      this.tokenType,
      this.refreshToken,
      this.expiresIn,
      this.scope,
      this.nickname,
      this.headImgUrl,
      this.gender,
      this.birthday,
      this.height,
      this.address,
      this.major,
      this.education,
      this.school,
      this.hometown,
      this.interest,
      this.details,
      this.idCardFront,
      this.idCardReverse,
      this.studentFront,
      this.studentReverse,
      this.auditState,
      this.studentAuditState,
      this.auditMsg,
      this.matchingState});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
    nickname = json['nickname'];
    headImgUrl = json['headImgUrl'];
    gender = json['gender'];
    birthday = json['birthday'];
    height = json['height'];
    address = json['address'];
    major = json['major'];
    education = json['education'];
    school = json['school'];
    hometown = json['hometown'];
    interest = json['interest'];
    details = json['details'];
    idCardFront = json['idCardFront'];
    idCardReverse = json['idCardReverse'];
    studentFront = json['studentFront'];
    studentReverse = json['studentReverse'];
    auditState = json['auditState'];
    studentAuditState = json['studentAuditState'];
    auditMsg = json['auditMsg'];
    matchingState = json['matchingState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['refresh_token'] = this.refreshToken;
    data['expires_in'] = this.expiresIn;
    data['scope'] = this.scope;
    data['nickname'] = this.nickname;
    data['headImgUrl'] = this.headImgUrl;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['height'] = this.height;
    data['address'] = this.address;
    data['major'] = this.major;
    data['education'] = this.education;
    data['school'] = this.school;
    data['hometown'] = this.hometown;
    data['interest'] = this.interest;
    data['details'] = this.details;
    data['idCardFront'] = this.idCardFront;
    data['idCardReverse'] = this.idCardReverse;
    data['studentFront'] = this.studentFront;
    data['studentReverse'] = this.studentReverse;
    data['auditState'] = this.auditState;
    data['studentAuditState'] = this.studentAuditState;
    data['auditMsg'] = this.auditMsg;
    data['matchingState'] = this.matchingState;
    return data;
  }
}