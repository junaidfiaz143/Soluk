import '../../challenges/model/comments_modal.dart';

class GetInfluencerModel {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  GetInfluencerModel(
      {this.status,
        this.responseCode,
        this.responseDescription,
        this.responseDetails});

  GetInfluencerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    responseDescription = json['responseDescription'];
    responseDetails = json['responseDetails'] != null
        ? new ResponseDetails.fromJson(json['responseDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['responseCode'] = this.responseCode;
    data['responseDescription'] = this.responseDescription;
    if (this.responseDetails != null) {
      data['responseDetails'] = this.responseDetails!.toJson();
    }
    return data;
  }
}

class ResponseDetails {
  String? imageUrl;
  String? introUrl;
  String? workTitle;
  String? intro;
  String? goals;
  String? credentials;
  String? requirements;
  List<Tags>? tags;
  User? userInfo;
  int? rating;

  ResponseDetails({
    this.imageUrl,
    this.introUrl,
    this.workTitle,
    this.intro,
    this.goals,
    this.credentials,
    this.requirements,
    this.tags,
    this.userInfo,
    this.rating,
  });

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    introUrl = json['introUrl'];
    workTitle = json['workTitle'];
    intro = json['intro'];
    goals = json['goals'];
    credentials = json['credentials'];
    requirements = json['requirements'];
    rating = json['rating'];
    if (json['userInfo'] != null) {
      userInfo = User.fromJson(json['userInfo']);
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['workTitle'] = this.workTitle;
    data['intro'] = this.intro;
    data['goals'] = this.goals;
    data['credentials'] = this.credentials;
    data['requirements'] = this.requirements;
    data['rating'] = this.rating;
    data['userInfo'] = this.userInfo?.toJson();
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  int? id;
  String? name;

  Tags({this.id, this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}