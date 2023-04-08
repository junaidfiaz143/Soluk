/// status : "success"
/// responseCode : "00"
/// responseDescription : "user challenges and workout badges!"
/// responseDetails : {"userBadgeDetails":{"current_page":1,"data":[{"id":1,"actionType":"workout","actionId":53,"participant_id":12,"badgeId":1,"badgeTitle":"Soluk","actionTitle":"Plan June 2nd  2022","created_at":"2022-07-06T15:03:03.000000Z","updated_at":"2022-07-06T15:03:03.000000Z"},{"id":2,"actionType":"workout","actionId":54,"participant_id":12,"badgeId":1,"badgeTitle":"Soluk","actionTitle":"Plan June 3rd  2022","created_at":"2022-07-06T15:03:03.000000Z","updated_at":"2022-07-06T15:03:03.000000Z"},{"id":3,"actionType":"challenge","actionId":51,"participant_id":12,"badgeId":1,"badgeTitle":"Soluk","actionTitle":"Testing Challenge Name12","created_at":"2022-07-06T15:03:03.000000Z","updated_at":"2022-07-06T15:03:03.000000Z"},{"id":4,"actionType":"challenge","actionId":23,"participant_id":12,"badgeId":2,"badgeTitle":"Gold","actionTitle":"Title of the challenge goes here....","created_at":"2022-07-06T15:03:03.000000Z","updated_at":"2022-07-06T15:03:03.000000Z"}],"first_page_url":"https://soluk.app/api/user-badges?page=1","from":1,"last_page":1,"last_page_url":"https://soluk.app/api/user-badges?page=1","links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/user-badges?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"next_page_url":null,"path":"https://soluk.app/api/user-badges","per_page":100,"prev_page_url":null,"to":4,"total":4},"userBadgeDetailCount":{"current_page":1,"data":[{"badgeCount":3,"badgeTitle":"Soluk"},{"badgeCount":1,"badgeTitle":"Gold"}],"first_page_url":"https://soluk.app/api/user-badges?page=1","from":1,"last_page":1,"last_page_url":"https://soluk.app/api/user-badges?page=1","links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/user-badges?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"next_page_url":null,"path":"https://soluk.app/api/user-badges","per_page":100,"prev_page_url":null,"to":2,"total":2}}

class MyBadgesResponse {
  MyBadgesResponse({
      this.status, 
      this.responseCode, 
      this.responseDescription, 
      this.responseDetails,});

  MyBadgesResponse.fromJson(dynamic json) {
    status = json['status'];
    responseCode = json['responseCode'];
    responseDescription = json['responseDescription'];
    responseDetails = json['responseDetails'] != null ? ResponseDetails.fromJson(json['responseDetails']) : null;
  }
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;
MyBadgesResponse copyWith({  String? status,
  String? responseCode,
  String? responseDescription,
  ResponseDetails? responseDetails,
}) => MyBadgesResponse(  status: status ?? this.status,
  responseCode: responseCode ?? this.responseCode,
  responseDescription: responseDescription ?? this.responseDescription,
  responseDetails: responseDetails ?? this.responseDetails,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['responseCode'] = responseCode;
    map['responseDescription'] = responseDescription;
    if (responseDetails != null) {
      map['responseDetails'] = responseDetails?.toJson();
    }
    return map;
  }

}

/// userBadgeDetails : {"current_page":1,"data":[{"id":1,"actionType":"workout","actionId":53,"participant_id":12,"badgeId":1,"badgeTitle":"Soluk","actionTitle":"Plan June 2nd  2022","created_at":"2022-07-06T15:03:03.000000Z","updated_at":"2022-07-06T15:03:03.000000Z"},{"id":2,"actionType":"workout","actionId":54,"participant_id":12,"badgeId":1,"badgeTitle":"Soluk","actionTitle":"Plan June 3rd  2022","created_at":"2022-07-06T15:03:03.000000Z","updated_at":"2022-07-06T15:03:03.000000Z"},{"id":3,"actionType":"challenge","actionId":51,"participant_id":12,"badgeId":1,"badgeTitle":"Soluk","actionTitle":"Testing Challenge Name12","created_at":"2022-07-06T15:03:03.000000Z","updated_at":"2022-07-06T15:03:03.000000Z"},{"id":4,"actionType":"challenge","actionId":23,"participant_id":12,"badgeId":2,"badgeTitle":"Gold","actionTitle":"Title of the challenge goes here....","created_at":"2022-07-06T15:03:03.000000Z","updated_at":"2022-07-06T15:03:03.000000Z"}],"first_page_url":"https://soluk.app/api/user-badges?page=1","from":1,"last_page":1,"last_page_url":"https://soluk.app/api/user-badges?page=1","links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/user-badges?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"next_page_url":null,"path":"https://soluk.app/api/user-badges","per_page":100,"prev_page_url":null,"to":4,"total":4}
/// userBadgeDetailCount : {"current_page":1,"data":[{"badgeCount":3,"badgeTitle":"Soluk"},{"badgeCount":1,"badgeTitle":"Gold"}],"first_page_url":"https://soluk.app/api/user-badges?page=1","from":1,"last_page":1,"last_page_url":"https://soluk.app/api/user-badges?page=1","links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/user-badges?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"next_page_url":null,"path":"https://soluk.app/api/user-badges","per_page":100,"prev_page_url":null,"to":2,"total":2}

class ResponseDetails {
  ResponseDetails({
      this.userBadgeDetails, 
      this.userBadgeDetailCount,});

  ResponseDetails.fromJson(dynamic json) {
    userBadgeDetails = json['userBadgeDetails'] != null ? UserBadgeDetails.fromJson(json['userBadgeDetails']) : null;
    userBadgeDetailCount = json['userBadgeDetailCount'] != null ? UserBadgeDetailCount.fromJson(json['userBadgeDetailCount']) : null;
  }
  UserBadgeDetails? userBadgeDetails;
  UserBadgeDetailCount? userBadgeDetailCount;
ResponseDetails copyWith({  UserBadgeDetails? userBadgeDetails,
  UserBadgeDetailCount? userBadgeDetailCount,
}) => ResponseDetails(  userBadgeDetails: userBadgeDetails ?? this.userBadgeDetails,
  userBadgeDetailCount: userBadgeDetailCount ?? this.userBadgeDetailCount,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (userBadgeDetails != null) {
      map['userBadgeDetails'] = userBadgeDetails?.toJson();
    }
    if (userBadgeDetailCount != null) {
      map['userBadgeDetailCount'] = userBadgeDetailCount?.toJson();
    }
    return map;
  }

}

/// current_page : 1
/// data : [{"badgeCount":3,"badgeTitle":"Soluk"},{"badgeCount":1,"badgeTitle":"Gold"}]
/// first_page_url : "https://soluk.app/api/user-badges?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://soluk.app/api/user-badges?page=1"
/// links : [{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/user-badges?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}]
/// next_page_url : null
/// path : "https://soluk.app/api/user-badges"
/// per_page : 100
/// prev_page_url : null
/// to : 2
/// total : 2

class UserBadgeDetailCount {
  UserBadgeDetailCount({
      this.currentPage, 
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
      this.total,});

  UserBadgeDetailCount.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BadgesData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
  int? currentPage;
  List<BadgesData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;
UserBadgeDetailCount copyWith({  int? currentPage,
  List<BadgesData>? data,
  String? firstPageUrl,
  int? from,
  int? lastPage,
  String? lastPageUrl,
  List<Links>? links,
  dynamic nextPageUrl,
  String? path,
  int? perPage,
  dynamic prevPageUrl,
  int? to,
  int? total,
}) => UserBadgeDetailCount(  currentPage: currentPage ?? this.currentPage,
  data: data ?? this.data,
  firstPageUrl: firstPageUrl ?? this.firstPageUrl,
  from: from ?? this.from,
  lastPage: lastPage ?? this.lastPage,
  lastPageUrl: lastPageUrl ?? this.lastPageUrl,
  links: links ?? this.links,
  nextPageUrl: nextPageUrl ?? this.nextPageUrl,
  path: path ?? this.path,
  perPage: perPage ?? this.perPage,
  prevPageUrl: prevPageUrl ?? this.prevPageUrl,
  to: to ?? this.to,
  total: total ?? this.total,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    if (links != null) {
      map['links'] = links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }

}

/// url : null
/// label : "&laquo; Previous"
/// active : false

class Links {
  Links({
      this.url, 
      this.label, 
      this.active,});

  Links.fromJson(dynamic json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
  dynamic url;
  String? label;
  bool? active;
Links copyWith({  dynamic url,
  String? label,
  bool? active,
}) => Links(  url: url ?? this.url,
  label: label ?? this.label,
  active: active ?? this.active,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['label'] = label;
    map['active'] = active;
    return map;
  }

}

/// badgeCount : 3
/// badgeTitle : "Soluk"

class BadgesData {
  BadgesData({
      this.badgeCount, 
      this.badgeTitle,});

  BadgesData.fromJson(dynamic json) {
    badgeCount = json['badgeCount'];
    badgeTitle = json['badgeTitle'];
  }
  int? badgeCount;
  String? badgeTitle;
  BadgesData copyWith({  int? badgeCount,
  String? badgeTitle,
}) => BadgesData(  badgeCount: badgeCount ?? this.badgeCount,
  badgeTitle: badgeTitle ?? this.badgeTitle,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['badgeCount'] = badgeCount;
    map['badgeTitle'] = badgeTitle;
    return map;
  }

}

/// current_page : 1
/// data : [{"id":1,"actionType":"workout","actionId":53,"participant_id":12,"badgeId":1,"badgeTitle":"Soluk","actionTitle":"Plan June 2nd  2022","created_at":"2022-07-06T15:03:03.000000Z","updated_at":"2022-07-06T15:03:03.000000Z"},{"id":2,"actionType":"workout","actionId":54,"participant_id":12,"badgeId":1,"badgeTitle":"Soluk","actionTitle":"Plan June 3rd  2022","created_at":"2022-07-06T15:03:03.000000Z","updated_at":"2022-07-06T15:03:03.000000Z"},{"id":3,"actionType":"challenge","actionId":51,"participant_id":12,"badgeId":1,"badgeTitle":"Soluk","actionTitle":"Testing Challenge Name12","created_at":"2022-07-06T15:03:03.000000Z","updated_at":"2022-07-06T15:03:03.000000Z"},{"id":4,"actionType":"challenge","actionId":23,"participant_id":12,"badgeId":2,"badgeTitle":"Gold","actionTitle":"Title of the challenge goes here....","created_at":"2022-07-06T15:03:03.000000Z","updated_at":"2022-07-06T15:03:03.000000Z"}]
/// first_page_url : "https://soluk.app/api/user-badges?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://soluk.app/api/user-badges?page=1"
/// links : [{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/user-badges?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}]
/// next_page_url : null
/// path : "https://soluk.app/api/user-badges"
/// per_page : 100
/// prev_page_url : null
/// to : 4
/// total : 4

class UserBadgeDetails {
  UserBadgeDetails({
      this.currentPage, 
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
      this.total,});

  UserBadgeDetails.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BadgesDetailData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
  int? currentPage;
  List<BadgesDetailData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;
UserBadgeDetails copyWith({  int? currentPage,
  List<BadgesDetailData>? data,
  String? firstPageUrl,
  int? from,
  int? lastPage,
  String? lastPageUrl,
  List<Links>? links,
  dynamic nextPageUrl,
  String? path,
  int? perPage,
  dynamic prevPageUrl,
  int? to,
  int? total,
}) => UserBadgeDetails(  currentPage: currentPage ?? this.currentPage,
  data: data ?? this.data,
  firstPageUrl: firstPageUrl ?? this.firstPageUrl,
  from: from ?? this.from,
  lastPage: lastPage ?? this.lastPage,
  lastPageUrl: lastPageUrl ?? this.lastPageUrl,
  links: links ?? this.links,
  nextPageUrl: nextPageUrl ?? this.nextPageUrl,
  path: path ?? this.path,
  perPage: perPage ?? this.perPage,
  prevPageUrl: prevPageUrl ?? this.prevPageUrl,
  to: to ?? this.to,
  total: total ?? this.total,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    if (links != null) {
      map['links'] = links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }

}

/// url : null
/// label : "&laquo; Previous"
/// active : false

class BadgesLinks {
  BadgesLinks({
      this.url, 
      this.label, 
      this.active,});

  BadgesLinks.fromJson(dynamic json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
  dynamic url;
  String? label;
  bool? active;
Links copyWith({  dynamic url,
  String? label,
  bool? active,
}) => Links(  url: url ?? this.url,
  label: label ?? this.label,
  active: active ?? this.active,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['label'] = label;
    map['active'] = active;
    return map;
  }

}

/// id : 1
/// actionType : "workout"
/// actionId : 53
/// participant_id : 12
/// badgeId : 1
/// badgeTitle : "Soluk"
/// actionTitle : "Plan June 2nd  2022"
/// created_at : "2022-07-06T15:03:03.000000Z"
/// updated_at : "2022-07-06T15:03:03.000000Z"

class BadgesDetailData {
  BadgesDetailData({
      this.id, 
      this.actionType, 
      this.actionId, 
      this.participantId, 
      this.badgeId, 
      this.badgeTitle, 
      this.actionTitle, 
      this.createdAt, 
      this.updatedAt,});

  BadgesDetailData.fromJson(dynamic json) {
    id = json['id'];
    actionType = json['actionType'];
    actionId = json['actionId'];
    participantId = json['participant_id'];
    badgeId = json['badgeId'];
    badgeTitle = json['badgeTitle'];
    actionTitle = json['actionTitle'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? actionType;
  int? actionId;
  int? participantId;
  int? badgeId;
  String? badgeTitle;
  String? actionTitle;
  String? createdAt;
  String? updatedAt;
  BadgesDetailData copyWith({  int? id,
  String? actionType,
  int? actionId,
  int? participantId,
  int? badgeId,
  String? badgeTitle,
  String? actionTitle,
  String? createdAt,
  String? updatedAt,
}) => BadgesDetailData(  id: id ?? this.id,
  actionType: actionType ?? this.actionType,
  actionId: actionId ?? this.actionId,
  participantId: participantId ?? this.participantId,
  badgeId: badgeId ?? this.badgeId,
  badgeTitle: badgeTitle ?? this.badgeTitle,
  actionTitle: actionTitle ?? this.actionTitle,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['actionType'] = actionType;
    map['actionId'] = actionId;
    map['participant_id'] = participantId;
    map['badgeId'] = badgeId;
    map['badgeTitle'] = badgeTitle;
    map['actionTitle'] = actionTitle;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}