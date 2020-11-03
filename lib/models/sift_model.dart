class SiftModel {
  int ageMax;
  int ageMin;
  int education;
  int gender;
  int heightMax;
  int heightMin;
  String hometown;
  List<dynamic> interestList;

  SiftModel(
      {this.ageMax,
      this.ageMin,
      this.education,
      this.gender,
      this.heightMax,
      this.heightMin,
      this.hometown,
      this.interestList});

  SiftModel.fromJson(Map<String, dynamic> json) {
    ageMax = json['ageMax']??null;
    ageMin = json['ageMin']??null;
    education = json['education']??null;
    gender = json['gender']??null;
    heightMax = json['heightMax']??null;
    heightMin = json['heightMin']??null;
    hometown = json['hometown']??null;
    interestList = json['interestList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ageMax'] = this.ageMax;
    data['ageMin'] = this.ageMin;
    data['education'] = this.education;
    data['gender'] = this.gender;
    data['heightMax'] = this.heightMax;
    data['heightMin'] = this.heightMin;
    data['hometown'] = this.hometown;
    data['interestList'] = this.interestList;
    return data;
  }
}