class FriendDetailModel {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  FriendDetailModel(
      {this.status,
      this.responseCode,
      this.responseDescription,
      this.responseDetails});

  FriendDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<ProfileInfo>? profileInfo;
  List<BadgesData>? badges;
  UserSetting? userSetting;
  ActivitiesInfo? activitiesInfo;

  ResponseDetails(
      {this.profileInfo, this.userSetting, this.activitiesInfo, this.badges});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    if (json['profileInfo'] != null) {
      profileInfo = <ProfileInfo>[];
      json['profileInfo'].forEach((v) {
        profileInfo!.add(new ProfileInfo.fromJson(v));
      });
    }
    if (json['badges'] != null) {
      badges = <BadgesData>[];
      json['badges'].forEach((v) {
        badges!.add(new BadgesData.fromJson(v));
      });
    }
    userSetting = json['userSetting'] != null
        ? new UserSetting.fromJson(json['userSetting'])
        : null;
    activitiesInfo = json['activitiesInfo'] != null
        ? new ActivitiesInfo.fromJson(json['activitiesInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profileInfo != null) {
      data['profileInfo'] = this.profileInfo!.map((v) => v.toJson()).toList();
    }
    if (this.badges != null) {
      data['badges'] = this.badges!.map((v) => v.toJson()).toList();
    }
    if (this.userSetting != null) {
      data['userSetting'] = this.userSetting!.toJson();
    }
    if (this.activitiesInfo != null) {
      data['activitiesInfo'] = this.activitiesInfo!.toJson();
    }
    return data;
  }
}

class ProfileInfo {
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
  String? snapchat;
  String? imageUrl;
  String? reason;

  ProfileInfo(
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
      this.snapchat,
      this.imageUrl,
      this.reason});

  ProfileInfo.fromJson(Map<String, dynamic> json) {
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
    snapchat = json['snapchat'];
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
    data['snapchat'] = this.snapchat;
    data['imageUrl'] = this.imageUrl;
    data['reason'] = this.reason;
    return data;
  }
}

class UserSetting {
  String? userId;
  int? id;
  int? notificationAllow;
  String? language;
  int? accountActive;
  int? allowDirectMessages;
  int? allowBagdes;
  int? allowSocialMediaAccounts;

  UserSetting(
      {this.userId,
      this.id,
      this.notificationAllow,
      this.language,
      this.accountActive,
      this.allowDirectMessages,
      this.allowBagdes,
      this.allowSocialMediaAccounts});

  UserSetting.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    notificationAllow = json['notificationAllow'];
    language = json['language'];
    accountActive = json['accountActive'];
    allowDirectMessages = json['allowDirectMessages'];
    allowBagdes = json['allowBagdes'];
    allowSocialMediaAccounts = json['allowSocialMediaAccounts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['notificationAllow'] = this.notificationAllow;
    data['language'] = this.language;
    data['accountActive'] = this.accountActive;
    data['allowDirectMessages'] = this.allowDirectMessages;
    data['allowBagdes'] = this.allowBagdes;
    data['allowSocialMediaAccounts'] = this.allowSocialMediaAccounts;
    return data;
  }
}

class ActivitiesInfo {
  int? challenges;
  int? workoutPrograms;
  bool? last_week_activity;

  ActivitiesInfo(
      {this.challenges, this.workoutPrograms, this.last_week_activity});

  ActivitiesInfo.fromJson(Map<String, dynamic> json) {
    challenges = json['challenges'];
    workoutPrograms = json['workout_programs'];
    last_week_activity = json['last_week_activity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['challenges'] = this.challenges;
    data['workout_programs'] = this.workoutPrograms;
    data['last_week_activity'] = this.last_week_activity;
    return data;
  }
}

class BadgesData {
  BadgesData({
    this.badgeCount,
    this.badgeTitle,
  });

  BadgesData.fromJson(dynamic json) {
    badgeCount = json['badgeCount'];
    badgeTitle = json['badgeTitle'];
  }

  int? badgeCount;
  String? badgeTitle;

  BadgesData copyWith({
    int? badgeCount,
    String? badgeTitle,
  }) =>
      BadgesData(
        badgeCount: badgeCount ?? this.badgeCount,
        badgeTitle: badgeTitle ?? this.badgeTitle,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['badgeCount'] = badgeCount;
    map['badgeTitle'] = badgeTitle;
    return map;
  }
}
