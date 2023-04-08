class ParticipantModal {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  ParticipantModal(
      {this.status,
      this.responseCode,
      this.responseDescription,
      this.responseDetails});

  ParticipantModal.fromJson(Map<String, dynamic> json) {
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
  List<DataParticipant>? data;
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
      data = <DataParticipant>[];
      json['data'].forEach((v) {
        data!.add(new DataParticipant.fromJson(v));
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

class DataParticipant {
  int? ccId;
  int? cpId;
  int? challengeId;
  int? participantId;
  String? assetType;
  String? assetUrl;
  int? isCompleted;
  int? isRewarded;
  int? createBy;
  String? completedAt;
  String? createdAt;
  String? updatedAt;
  String? UserRating;
  User? participant;

  DataParticipant(
      {this.ccId,
      this.cpId,
      this.challengeId,
      this.participantId,
      this.assetType,
      this.assetUrl,
      this.isCompleted,
      this.isRewarded,
      this.createBy,
      this.completedAt,
      this.createdAt,
      this.updatedAt,
      this.UserRating,
      this.participant});

  DataParticipant.fromJson(Map<String, dynamic> json) {
    ccId = json['cc_id'];
    cpId = json['cp_id'];
    challengeId = json['challenge_id'];
    participantId = json['participant_id'];
    assetType = json['assetType'];
    assetUrl = json['assetUrl'];
    isCompleted = json['isCompleted'];
    isRewarded = json['isRewarded'];
    createBy = json['createBy'];
    completedAt = json['completed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    UserRating = json['UserRating'];
    participant = User.fromJson(json['participant']);

/*
    participant = json['participant'] != null ? new User.fromJson(json['participant']) : null;
*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cc_id'] = this.ccId;
    data['cp_id'] = this.cpId;
    data['challenge_id'] = this.challengeId;
    data['participant_id'] = this.participantId;
    data['assetType'] = this.assetType;
    data['assetUrl'] = this.assetUrl;
    data['createBy'] = this.createBy;
    data['completed_at'] = this.completedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['UserRating'] = this.UserRating;
    data['participant'] = this.participant;
    return data;
  }
}

class User {
  int? id;
  String? fullname;
  String? email;
  String? phone;
  int? roleId;
  String? promoCode;
  String? instagram;
  String? youtube;
  String? otp;
  String? facebook;
  String? imageUrl;

  User(
      {this.id,
      this.fullname,
      this.email,
      this.phone,
      this.roleId,
      this.promoCode,
      this.instagram,
      this.youtube,
      this.otp,
      this.imageUrl,
      this.facebook});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    roleId = json['roleId'];
    promoCode = json['promoCode'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    otp = json['otp'];
    imageUrl = json['imageUrl'];
    facebook = json['facebook'];
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
    data['otp'] = this.otp;
    data['imageUrl'] = this.imageUrl;
    data['facebook'] = this.facebook;
    return data;
  }
}

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
