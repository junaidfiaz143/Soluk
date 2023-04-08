class ChallengesDetailsModal {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  ChallengesDetailsModal(
      {this.status,
      this.responseCode,
      this.responseDescription,
      this.responseDetails});

  ChallengesDetailsModal.fromJson(Map<String, dynamic> json) {
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
  List<ChallengeModel>? data;
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
      data = <ChallengeModel>[];
      json['data'].forEach((v) {
        data!.add(new ChallengeModel.fromJson(v));
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

class ChallengeModel {
  int? userId;
  int? id;
  String? assetUrl;
  String? assetType;
  String? title;
  String? badge;
  String? description;
  String? challengeExpiry;
  String? challengeStatus;
  String? state;
  String? rejectionReason;
  String? winnerBy;
  int? participantsCount;
  int? commentsCount;

  ChallengeModel(
      {this.userId,
      this.id,
      this.assetUrl,
      this.assetType,
      this.title,
      this.badge,
      this.description,
      this.challengeExpiry,
      this.challengeStatus,
      this.state,
      this.rejectionReason,
      this.winnerBy,
      this.participantsCount,
      this.commentsCount});

  ChallengeModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    assetUrl = json['assetUrl'];
    assetType = json['assetType'];
    title = json['title'];
    badge = json['badge'];
    description = json['description'];
    challengeExpiry = json['challengeExpiry'];
    challengeStatus = json['challengeStatus'];
    state = json['state'];
    rejectionReason = json['rejectionReason'];
    winnerBy = json['winnerBy'];
    participantsCount = json['participants_count'];
    commentsCount = json['comments_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['assetUrl'] = this.assetUrl;
    data['assetType'] = this.assetType;
    data['title'] = this.title;
    data['badge'] = this.badge;
    data['description'] = this.description;
    data['challengeExpiry'] = this.challengeExpiry;
    data['challengeStatus'] = this.challengeStatus;
    data['state'] = this.state;
    data['rejectionReason'] = this.rejectionReason;
    data['participants_count'] = this.participantsCount;
    data['comments_count'] = this.commentsCount;
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
