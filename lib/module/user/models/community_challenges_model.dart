import 'package:app/module/influencer/challenges/model/comments_modal.dart';

class CommunityChallegeModel {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  CommunityChallegeModel(
      {this.status,
        this.responseCode,
        this.responseDescription,
        this.responseDetails});

  CommunityChallegeModel.fromJson(Map<String, dynamic> json) {
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
  List<CommunityChallenge>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
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
      data = <CommunityChallenge>[];
      json['data'].forEach((v) {
        data!.add(new CommunityChallenge.fromJson(v));
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

class CommunityChallenge {
  int? userId;
  int? id;
  String? assetUrl;
  String? assetType;
  String? title;
  String? badge;
  String? winnerBy;
  String? description;
  String? challengeExpiry;
  String? challengeStatus;
  String? state;
  String? rejectionReason;
  int? participantsCount;
  int? commentsCount;
  List<Participants>? participants;
  List<CommunityChallenge>? comments;

  CommunityChallenge(
      {this.userId,
        this.id,
        this.assetUrl,
        this.assetType,
        this.title,
        this.badge,
        this.winnerBy,
        this.description,
        this.challengeExpiry,
        this.challengeStatus,
        this.state,
        this.rejectionReason,
        this.commentsCount,
        this.participantsCount,
        this.participants,
        this.comments});

  CommunityChallenge.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    assetUrl = json['assetUrl'];
    assetType = json['assetType'];
    title = json['title'];
    badge = json['badge'];
    winnerBy = json['winnerBy'];
    description = json['description'];
    challengeExpiry = json['challengeExpiry'];
    challengeStatus = json['challengeStatus'];
    participantsCount = json['participants_count'];
    commentsCount = json['comments_count'];
    state = json['state'];
    rejectionReason = json['rejectionReason'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <CommunityChallenge>[];
      json['comments'].forEach((v) {
        comments!.add(new CommunityChallenge.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['assetUrl'] = this.assetUrl;
    data['assetType'] = this.assetType;
    data['title'] = this.title;
    data['badge'] = this.badge;
    data['winnerBy'] = this.winnerBy;
    data['description'] = this.description;
    data['challengeExpiry'] = this.challengeExpiry;
    data['challengeStatus'] = this.challengeStatus;
    data['participantsCount'] = this.participantsCount;
    data['participantsCount'] = this.participantsCount;
    data['state'] = this.state;
    data['rejectionReason'] = this.rejectionReason;
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Participants {
  int? cpId;
  int? challengeId;
  int? participantId;
  String? assetType;
  String? assetUrl;
  int? isCompleted;
  int? isRewarded;
  String? completedAt;
  String? createdAt;
  String? updatedAt;

  Participants(
      {this.cpId,
        this.challengeId,
        this.participantId,
        this.assetType,
        this.assetUrl,
        this.isCompleted,
        this.isRewarded,
        this.completedAt,
        this.createdAt,
        this.updatedAt});

  Participants.fromJson(Map<String, dynamic> json) {
    cpId = json['cp_id'];
    challengeId = json['challenge_id'];
    participantId = json['participant_id'];
    assetType = json['assetType'];
    assetUrl = json['assetUrl'];
    isCompleted = json['isCompleted'];
    isRewarded = json['isRewarded'];
    completedAt = json['completed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cp_id'] = this.cpId;
    data['challenge_id'] = this.challengeId;
    data['participant_id'] = this.participantId;
    data['assetType'] = this.assetType;
    data['assetUrl'] = this.assetUrl;
    data['isCompleted'] = this.isCompleted;
    data['isRewarded'] = this.isRewarded;
    data['completed_at'] = this.completedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
