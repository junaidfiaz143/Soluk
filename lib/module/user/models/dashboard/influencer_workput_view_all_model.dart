import 'package:app/module/user/models/dashboard/tag_search_influencer_model.dart';

class InfluencerWorkoutViewAllModel {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  InfluencerWorkoutViewAllModel(
      {this.status,
        this.responseCode,
        this.responseDescription,
        this.responseDetails});

  InfluencerWorkoutViewAllModel.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<WorkoutPlans>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  ResponseDetails(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <WorkoutPlans>[];
      json['data'].forEach((v) {
        data!.add(new WorkoutPlans.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

/*class Data {
  int? userId;
  int? id;
  String? assetType;
  String? assetUrl;
  String? title;
  String? difficultyLevel;
  String? programType;
  String? completionBadge;
  String? description;
  Null? userViews;
  int? rating;
  int? isActive;
  Null? rejectionReason;
  int? createBy;
  String? createdDate;
  Null? modifiedBy;
  Null? modifiedDate;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.userId,
        this.id,
        this.assetType,
        this.assetUrl,
        this.title,
        this.difficultyLevel,
        this.programType,
        this.completionBadge,
        this.description,
        this.userViews,
        this.rating,
        this.isActive,
        this.rejectionReason,
        this.createBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    assetType = json['assetType'];
    assetUrl = json['assetUrl'];
    title = json['title'];
    difficultyLevel = json['difficultyLevel'];
    programType = json['programType'];
    completionBadge = json['completionBadge'];
    description = json['description'];
    userViews = json['userViews'];
    rating = json['rating'];
    isActive = json['isActive'];
    rejectionReason = json['rejection_reason'];
    createBy = json['createBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['assetType'] = this.assetType;
    data['assetUrl'] = this.assetUrl;
    data['title'] = this.title;
    data['difficultyLevel'] = this.difficultyLevel;
    data['programType'] = this.programType;
    data['completionBadge'] = this.completionBadge;
    data['description'] = this.description;
    data['userViews'] = this.userViews;
    data['rating'] = this.rating;
    data['isActive'] = this.isActive;
    data['rejection_reason'] = this.rejectionReason;
    data['createBy'] = this.createBy;
    data['createdDate'] = this.createdDate;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedDate'] = this.modifiedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}*/

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
