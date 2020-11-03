class SiftListModel {
  int id;
  String name;
  List<TrailDetails> trailDetails;

  SiftListModel({this.id, this.name, this.trailDetails});

  SiftListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['trailDetails'] != null) {
      trailDetails = new List<TrailDetails>();
      json['trailDetails'].forEach((v) {
        trailDetails.add(new TrailDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.trailDetails != null) {
      data['trailDetails'] = this.trailDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrailDetails {
  double lon;
  double lat;

  TrailDetails({this.lon, this.lat});

  TrailDetails.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    return data;
  }
}