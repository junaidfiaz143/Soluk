import 'package:app/module/influencer/workout/model/blog_modal.dart';

class UserDashboardModel {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  UserDashboardModel(
      {this.status,
      this.responseCode,
      this.responseDescription,
    this.responseDetails});

  UserDashboardModel.fromJson(Map<String, dynamic> json) {
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
  List<FeaturedInfluencers>? featuredInfluencers;
  List<TopRatedInfluencers>? topRatedInfluencers;
  List<TopRatedworkoutPlans>? topRatedworkoutPlans;
  List<Data>? topViewedBlogs;
  List<TopTags>? topTags;

  ResponseDetails(
      {this.featuredInfluencers,
      this.topRatedInfluencers,
      this.topRatedworkoutPlans,
      this.topViewedBlogs,
      this.topTags});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    if (json['featuredInfluencers'] != null) {
      featuredInfluencers = <FeaturedInfluencers>[];
      json['featuredInfluencers'].forEach((v) {
        featuredInfluencers!.add(new FeaturedInfluencers.fromJson(v));
      });
    }
    if (json['topRatedInfluencers'] != null) {
      topRatedInfluencers = <TopRatedInfluencers>[];
      json['topRatedInfluencers'].forEach((v) {
        topRatedInfluencers!.add(new TopRatedInfluencers.fromJson(v));
      });
    }
    if (json['topRatedworkoutPlans'] != null) {
      topRatedworkoutPlans = <TopRatedworkoutPlans>[];
      json['topRatedworkoutPlans'].forEach((v) {
        topRatedworkoutPlans!.add(new TopRatedworkoutPlans.fromJson(v));
      });
    }
    if (json['topViewedBlogs'] != null) {
      topViewedBlogs = <Data>[];
      json['topViewedBlogs'].forEach((v) {
        topViewedBlogs!.add(new Data.fromJson(v));
      });
    }
    if (json['topTags'] != null) {
      topTags = <TopTags>[];
      json['topTags'].forEach((v) {
        topTags!.add(new TopTags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.featuredInfluencers != null) {
      data['featuredInfluencers'] =
          this.featuredInfluencers!.map((v) => v.toJson()).toList();
    }
    if (this.topRatedInfluencers != null) {
      data['topRatedInfluencers'] =
          this.topRatedInfluencers!.map((v) => v.toJson()).toList();
    }
    if (this.topRatedworkoutPlans != null) {
      data['topRatedworkoutPlans'] =
          this.topRatedworkoutPlans!.map((v) => v.toJson()).toList();
    }
    if (this.topViewedBlogs != null) {
      data['topViewedBlogs'] =
          this.topViewedBlogs!.map((v) => v.toJson()).toList();
    }
    if (this.topTags != null) {
      data['topTags'] = this.topTags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedInfluencers {
  int? id;
  String? featureableType;
  int? featureableId;
  String? assetType;
  String? assetUrl;
  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  Influencer? influencer;

  FeaturedInfluencers({this.id,
    this.featureableType,
    this.featureableId,
    this.assetType,
    this.assetUrl,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
    this.influencer});

  FeaturedInfluencers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    featureableType = json['featureable_type'];
    featureableId = json['featureable_id'];
    assetType = json['assetType'];
    assetUrl = json['assetUrl'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    influencer = json['influencer'] != null
        ? new Influencer.fromJson(json['influencer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['featureable_type'] = this.featureableType;
    data['featureable_id'] = this.featureableId;
    data['assetType'] = this.assetType;
    data['assetUrl'] = this.assetUrl;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedDate'] = this.modifiedDate;
    if (this.influencer != null) {
      data['influencer'] = this.influencer!.toJson();
    }
    return data;
  }
}

class TopRatedInfluencers {
  int? userId;
  int? id;
  String? imageUrl;
  String? workTitle;
  String? intro;
  String? goals;
  String? credentials;
  String? requirements;
  int? rating;
  String? assetType;
  String? introUrl;
  Influencer? influencer;

  TopRatedInfluencers({this.userId,
    this.id,
    this.imageUrl,
    this.workTitle,
    this.intro,
    this.goals,
    this.credentials,
    this.requirements,
    this.rating,
    this.assetType,
    this.introUrl,
    this.influencer});

  TopRatedInfluencers.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    workTitle = json['workTitle'];
    intro = json['intro'];
    goals = json['goals'];
    credentials = json['credentials'];
    requirements = json['requirements'];
    rating = json['rating'];
    assetType = json['assetType'];
    introUrl = json['introUrl'];
    influencer = json['influencer'] != null
        ? new Influencer.fromJson(json['influencer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['workTitle'] = this.workTitle;
    data['intro'] = this.intro;
    data['goals'] = this.goals;
    data['credentials'] = this.credentials;
    data['requirements'] = this.requirements;
    data['rating'] = this.rating;
    data['assetType'] = this.assetType;
    data['introUrl'] = this.introUrl;
    if (this.influencer != null) {
      data['influencer'] = this.influencer!.toJson();
    }
    return data;
  }
}

class Influencer {
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
  Null reason;

  Influencer({this.id,
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

  Influencer.fromJson(Map<String, dynamic> json) {
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

class TopRatedworkoutPlans {
  int? userId;
  int? id;
  String? assetType;
  String? assetUrl;
  String? title;
  String? difficultyLevel;
  String? programType;
  String? completionBadge;
  String? description;
  Null userViews;
  int? rating;
  int? isActive;
  Null rejectionReason;
  int? createBy;
  String? createdDate;
  Null modifiedBy;
  Null modifiedDate;
  String? createdAt;
  String? updatedAt;

  TopRatedworkoutPlans({this.userId,
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

  TopRatedworkoutPlans.fromJson(Map<String, dynamic> json) {
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


class TopTags {
  int? id;
  String? name;
  String? description;
  int? isActive;
  int? createBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  String? createdAt;
  String? updatedAt;

  TopTags({this.id,
    this.name,
    this.description,
    this.isActive,
    this.createBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
    this.createdAt,
    this.updatedAt});

  TopTags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isActive = json['isActive'];
    createBy = json['createBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    data['createBy'] = this.createBy;
    data['createdDate'] = this.createdDate;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedDate'] = this.modifiedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
