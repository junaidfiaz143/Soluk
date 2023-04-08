import '../../../influencer/workout_programs/model/get_workout_plan_response.dart';

class TagSearchInfluencerModel {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  TagSearchInfluencerModel(
      {this.status,
        this.responseCode,
        this.responseDescription,
        this.responseDetails});

  TagSearchInfluencerModel.fromJson(Map<String, dynamic> json) {
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
  List<InfluencersInfo>? influencersInfo;
  List<WorkoutPlans>? workoutPlans;

  ResponseDetails({this.influencersInfo, this.workoutPlans});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    if (json['influencersInfo'] != null) {
      influencersInfo = <InfluencersInfo>[];
      json['influencersInfo'].forEach((v) {
        influencersInfo!.add(new InfluencersInfo.fromJson(v));
      });
    }
    if (json['workoutPlans'] != null) {
      workoutPlans = <WorkoutPlans>[];
      json['workoutPlans'].forEach((v) {
        workoutPlans!.add(new WorkoutPlans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.influencersInfo != null) {
      data['influencersInfo'] =
          this.influencersInfo!.map((v) => v.toJson()).toList();
    }
    if (this.workoutPlans != null) {
      data['workoutPlans'] = this.workoutPlans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InfluencersInfo {
  int? id;
  String? fullname;
  String? email;
  String? phone;
  int? roleId;
  String? promoCode;
  String? instagram;
  String? youtube;
  int? isActive;
  int? isVerified;
  int? createBy;
  String? otp;
  String? facebook;
  String? imageUrl;
  String? reason;

  InfluencersInfo(
      {this.id,
        this.fullname,
        this.email,
        this.phone,
        this.roleId,
        this.promoCode,
        this.instagram,
        this.youtube,
        this.isActive,
        this.isVerified,
        this.createBy,
        this.otp,
        this.facebook,
        this.imageUrl,
        this.reason});

  InfluencersInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    roleId = json['roleId'];
    promoCode = json['promoCode'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    isActive = json['isActive'];
    isVerified = json['isVerified'];
    createBy = json['createBy'];
    otp = json['otp'];
    facebook = json['facebook'];
    imageUrl = json['imageUrl'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['roleId'] = this.roleId;
    data['promoCode'] = this.promoCode;
    data['instagram'] = this.instagram;
    data['youtube'] = this.youtube;
    data['isActive'] = this.isActive;
    data['isVerified'] = this.isVerified;
    data['createBy'] = this.createBy;
    data['otp'] = this.otp;
    data['facebook'] = this.facebook;
    data['imageUrl'] = this.imageUrl;
    data['reason'] = this.reason;
    return data;
  }
}

class WorkoutPlans {
  int? userId;
  int? id;
  String? assetType;
  String? assetUrl;
  String? title;
  String? difficultyLevel;
  String? programType;
  String? completionBadge;
  String? description;
  int? userViews;
  int? rating;
  int? isActive;
  String? rejectionReason;
  int? createBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  String? createdAt;
  String? updatedAt;

  WorkoutPlans(
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

  WorkoutPlans.fromJson(Map<String, dynamic> json) {
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
}
