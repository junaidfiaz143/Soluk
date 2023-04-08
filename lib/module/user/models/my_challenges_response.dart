/// status : "success"
/// responseCode : "00"
/// responseDescription : "Participant Challenge List"
/// responseDetails : {"current_page":1,"data":[{"cp_id":4,"challenge_id":51,"participant_id":61,"assetType":null,"assetUrl":null,"isCompleted":0,"isRewarded":0,"completed_at":"2022-06-17 19:42:02","created_at":"2022-05-23T14:41:54.000000Z","updated_at":"2022-06-20T15:45:31.000000Z","challenge_info":{"userId":61,"id":51,"assetUrl":"https://soluk.app/storage/images/challenge/challenge-61-1653856526.mp4","assetType":"Video","title":"Testing Challenge Name12","badge":"1","winnerBy":"Influencer","description":"Description of the badge goes here...","challengeExpiry":"2022-04-30 12:12:30","challengeStatus":"Unapproved","state":"expired","rejectionReason":null}},{"cp_id":6,"challenge_id":35,"participant_id":61,"assetType":null,"assetUrl":null,"isCompleted":0,"isRewarded":0,"completed_at":null,"created_at":"2022-06-20T10:45:59.000000Z","updated_at":"2022-06-20T10:45:59.000000Z","challenge_info":{"userId":32,"id":35,"assetUrl":"https://soluk.app/storage/images/challenge/challenge-61-1651085948.png","assetType":"Image","title":"Testing Challenge Name","badge":"1","winnerBy":"Influencer","description":"Description of the badge goes here...","challengeExpiry":"2022-04-30 12:12:30","challengeStatus":"Unapproved","state":"expired","rejectionReason":null}},{"cp_id":7,"challenge_id":65,"participant_id":61,"assetType":null,"assetUrl":null,"isCompleted":0,"isRewarded":0,"completed_at":null,"created_at":"2022-06-21T19:08:25.000000Z","updated_at":"2022-06-21T19:08:25.000000Z","UserRating":"2.5","challenge_info":{"userId":61,"id":65,"assetUrl":"https://soluk.app/storage/images/challenge/challenge-61-1655838475.jpg","assetType":"Image","title":"Testing Challenge 22-June","badge":"1","winnerBy":"Community","description":"Description of the badge goes here...","challengeExpiry":"2022-04-30 12:12:30","challengeStatus":"Unapproved","state":"expired","rejectionReason":null}}],"first_page_url":"https://soluk.app/api/user-challenges?page=1","from":1,"last_page":1,"last_page_url":"https://soluk.app/api/user-challenges?page=1","links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/user-challenges?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"next_page_url":null,"path":"https://soluk.app/api/user-challenges","per_page":100,"prev_page_url":null,"to":3,"total":3}

class MyChallengesResponse {
  MyChallengesResponse({
      String? status, 
      String? responseCode, 
      String? responseDescription, 
      ResponseDetails? responseDetails,}){
    _status = status;
    _responseCode = responseCode;
    _responseDescription = responseDescription;
    _responseDetails = responseDetails;
}

  MyChallengesResponse.fromJson(dynamic json) {
    _status = json['status'];
    _responseCode = json['responseCode'];
    _responseDescription = json['responseDescription'];
    _responseDetails = json['responseDetails'] != null ? ResponseDetails.fromJson(json['responseDetails']) : null;
  }
  String? _status;
  String? _responseCode;
  String? _responseDescription;
  ResponseDetails? _responseDetails;
MyChallengesResponse copyWith({  String? status,
  String? responseCode,
  String? responseDescription,
  ResponseDetails? responseDetails,
}) => MyChallengesResponse(  status: status ?? _status,
  responseCode: responseCode ?? _responseCode,
  responseDescription: responseDescription ?? _responseDescription,
  responseDetails: responseDetails ?? _responseDetails,
);
  String? get status => _status;
  String? get responseCode => _responseCode;
  String? get responseDescription => _responseDescription;
  ResponseDetails? get responseDetails => _responseDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['responseCode'] = _responseCode;
    map['responseDescription'] = _responseDescription;
    if (_responseDetails != null) {
      map['responseDetails'] = _responseDetails?.toJson();
    }
    return map;
  }

}

/// current_page : 1
/// data : [{"cp_id":4,"challenge_id":51,"participant_id":61,"assetType":null,"assetUrl":null,"isCompleted":0,"isRewarded":0,"completed_at":"2022-06-17 19:42:02","created_at":"2022-05-23T14:41:54.000000Z","updated_at":"2022-06-20T15:45:31.000000Z","challenge_info":{"userId":61,"id":51,"assetUrl":"https://soluk.app/storage/images/challenge/challenge-61-1653856526.mp4","assetType":"Video","title":"Testing Challenge Name12","badge":"1","winnerBy":"Influencer","description":"Description of the badge goes here...","challengeExpiry":"2022-04-30 12:12:30","challengeStatus":"Unapproved","state":"expired","rejectionReason":null}},{"cp_id":6,"challenge_id":35,"participant_id":61,"assetType":null,"assetUrl":null,"isCompleted":0,"isRewarded":0,"completed_at":null,"created_at":"2022-06-20T10:45:59.000000Z","updated_at":"2022-06-20T10:45:59.000000Z","challenge_info":{"userId":32,"id":35,"assetUrl":"https://soluk.app/storage/images/challenge/challenge-61-1651085948.png","assetType":"Image","title":"Testing Challenge Name","badge":"1","winnerBy":"Influencer","description":"Description of the badge goes here...","challengeExpiry":"2022-04-30 12:12:30","challengeStatus":"Unapproved","state":"expired","rejectionReason":null}},{"cp_id":7,"challenge_id":65,"participant_id":61,"assetType":null,"assetUrl":null,"isCompleted":0,"isRewarded":0,"completed_at":null,"created_at":"2022-06-21T19:08:25.000000Z","updated_at":"2022-06-21T19:08:25.000000Z","UserRating":"2.5","challenge_info":{"userId":61,"id":65,"assetUrl":"https://soluk.app/storage/images/challenge/challenge-61-1655838475.jpg","assetType":"Image","title":"Testing Challenge 22-June","badge":"1","winnerBy":"Community","description":"Description of the badge goes here...","challengeExpiry":"2022-04-30 12:12:30","challengeStatus":"Unapproved","state":"expired","rejectionReason":null}}]
/// first_page_url : "https://soluk.app/api/user-challenges?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://soluk.app/api/user-challenges?page=1"
/// links : [{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/user-challenges?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}]
/// next_page_url : null
/// path : "https://soluk.app/api/user-challenges"
/// per_page : 100
/// prev_page_url : null
/// to : 3
/// total : 3

class ResponseDetails {
  ResponseDetails({
      int? currentPage, 
      List<Data>? data, 
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
      int? total,}){
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  ResponseDetails.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  int? _currentPage;
  List<Data>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  dynamic _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic _prevPageUrl;
  int? _to;
  int? _total;
ResponseDetails copyWith({  int? currentPage,
  List<Data>? data,
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
}) => ResponseDetails(  currentPage: currentPage ?? _currentPage,
  data: data ?? _data,
  firstPageUrl: firstPageUrl ?? _firstPageUrl,
  from: from ?? _from,
  lastPage: lastPage ?? _lastPage,
  lastPageUrl: lastPageUrl ?? _lastPageUrl,
  links: links ?? _links,
  nextPageUrl: nextPageUrl ?? _nextPageUrl,
  path: path ?? _path,
  perPage: perPage ?? _perPage,
  prevPageUrl: prevPageUrl ?? _prevPageUrl,
  to: to ?? _to,
  total: total ?? _total,
);
  int? get currentPage => _currentPage;
  List<Data>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  int? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

/// url : null
/// label : "&laquo; Previous"
/// active : false

class Links {
  Links({
      dynamic url, 
      String? label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;
Links copyWith({  dynamic url,
  String? label,
  bool? active,
}) => Links(  url: url ?? _url,
  label: label ?? _label,
  active: active ?? _active,
);
  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}

/// cp_id : 4
/// challenge_id : 51
/// participant_id : 61
/// assetType : null
/// assetUrl : null
/// isCompleted : 0
/// isRewarded : 0
/// completed_at : "2022-06-17 19:42:02"
/// created_at : "2022-05-23T14:41:54.000000Z"
/// updated_at : "2022-06-20T15:45:31.000000Z"
/// challenge_info : {"userId":61,"id":51,"assetUrl":"https://soluk.app/storage/images/challenge/challenge-61-1653856526.mp4","assetType":"Video","title":"Testing Challenge Name12","badge":"1","winnerBy":"Influencer","description":"Description of the badge goes here...","challengeExpiry":"2022-04-30 12:12:30","challengeStatus":"Unapproved","state":"expired","rejectionReason":null}

class Data {
  Data({
      int? cpId, 
      int? challengeId, 
      int? participantId, 
      dynamic assetType, 
      dynamic assetUrl, 
      int? isCompleted, 
      int? isRewarded, 
      String? completedAt, 
      String? createdAt, 
      String? updatedAt, 
      ChallengeInfo? challengeInfo,}){
    _cpId = cpId;
    _challengeId = challengeId;
    _participantId = participantId;
    _assetType = assetType;
    _assetUrl = assetUrl;
    _isCompleted = isCompleted;
    _isRewarded = isRewarded;
    _completedAt = completedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _challengeInfo = challengeInfo;
}

  Data.fromJson(dynamic json) {
    _cpId = json['cp_id'];
    _challengeId = json['challenge_id'];
    _participantId = json['participant_id'];
    _assetType = json['assetType'];
    _assetUrl = json['assetUrl'];
    _isCompleted = json['isCompleted'];
    _isRewarded = json['isRewarded'];
    _completedAt = json['completed_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _challengeInfo = json['challenge_info'] != null ? ChallengeInfo.fromJson(json['challenge_info']) : null;
  }
  int? _cpId;
  int? _challengeId;
  int? _participantId;
  dynamic _assetType;
  dynamic _assetUrl;
  int? _isCompleted;
  int? _isRewarded;
  String? _completedAt;
  String? _createdAt;
  String? _updatedAt;
  ChallengeInfo? _challengeInfo;
Data copyWith({  int? cpId,
  int? challengeId,
  int? participantId,
  dynamic assetType,
  dynamic assetUrl,
  int? isCompleted,
  int? isRewarded,
  String? completedAt,
  String? createdAt,
  String? updatedAt,
  ChallengeInfo? challengeInfo,
}) => Data(  cpId: cpId ?? _cpId,
  challengeId: challengeId ?? _challengeId,
  participantId: participantId ?? _participantId,
  assetType: assetType ?? _assetType,
  assetUrl: assetUrl ?? _assetUrl,
  isCompleted: isCompleted ?? _isCompleted,
  isRewarded: isRewarded ?? _isRewarded,
  completedAt: completedAt ?? _completedAt,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  challengeInfo: challengeInfo ?? _challengeInfo,
);
  int? get cpId => _cpId;
  int? get challengeId => _challengeId;
  int? get participantId => _participantId;
  dynamic get assetType => _assetType;
  dynamic get assetUrl => _assetUrl;
  int? get isCompleted => _isCompleted;
  int? get isRewarded => _isRewarded;
  String? get completedAt => _completedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  ChallengeInfo? get challengeInfo => _challengeInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cp_id'] = _cpId;
    map['challenge_id'] = _challengeId;
    map['participant_id'] = _participantId;
    map['assetType'] = _assetType;
    map['assetUrl'] = _assetUrl;
    map['isCompleted'] = _isCompleted;
    map['isRewarded'] = _isRewarded;
    map['completed_at'] = _completedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_challengeInfo != null) {
      map['challenge_info'] = _challengeInfo?.toJson();
    }
    return map;
  }

}

/// userId : 61
/// id : 51
/// assetUrl : "https://soluk.app/storage/images/challenge/challenge-61-1653856526.mp4"
/// assetType : "Video"
/// title : "Testing Challenge Name12"
/// badge : "1"
/// winnerBy : "Influencer"
/// description : "Description of the badge goes here..."
/// challengeExpiry : "2022-04-30 12:12:30"
/// challengeStatus : "Unapproved"
/// state : "expired"
/// rejectionReason : null

class ChallengeInfo {
  ChallengeInfo({
      int? userId, 
      int? id, 
      String? assetUrl, 
      String? assetType, 
      String? title, 
      String? badge, 
      String? winnerBy, 
      String? description, 
      String? challengeExpiry, 
      String? challengeStatus, 
      String? state, 
      dynamic rejectionReason,}){
    _userId = userId;
    _id = id;
    _assetUrl = assetUrl;
    _assetType = assetType;
    _title = title;
    _badge = badge;
    _winnerBy = winnerBy;
    _description = description;
    _challengeExpiry = challengeExpiry;
    _challengeStatus = challengeStatus;
    _state = state;
    _rejectionReason = rejectionReason;
}

  ChallengeInfo.fromJson(dynamic json) {
    _userId = json['userId'];
    _id = json['id'];
    _assetUrl = json['assetUrl'];
    _assetType = json['assetType'];
    _title = json['title'];
    _badge = json['badge'];
    _winnerBy = json['winnerBy'];
    _description = json['description'];
    _challengeExpiry = json['challengeExpiry'];
    _challengeStatus = json['challengeStatus'];
    _state = json['state'];
    _rejectionReason = json['rejectionReason'];
  }
  int? _userId;
  int? _id;
  String? _assetUrl;
  String? _assetType;
  String? _title;
  String? _badge;
  String? _winnerBy;
  String? _description;
  String? _challengeExpiry;
  String? _challengeStatus;
  String? _state;
  dynamic _rejectionReason;
ChallengeInfo copyWith({  int? userId,
  int? id,
  String? assetUrl,
  String? assetType,
  String? title,
  String? badge,
  String? winnerBy,
  String? description,
  String? challengeExpiry,
  String? challengeStatus,
  String? state,
  dynamic rejectionReason,
}) => ChallengeInfo(  userId: userId ?? _userId,
  id: id ?? _id,
  assetUrl: assetUrl ?? _assetUrl,
  assetType: assetType ?? _assetType,
  title: title ?? _title,
  badge: badge ?? _badge,
  winnerBy: winnerBy ?? _winnerBy,
  description: description ?? _description,
  challengeExpiry: challengeExpiry ?? _challengeExpiry,
  challengeStatus: challengeStatus ?? _challengeStatus,
  state: state ?? _state,
  rejectionReason: rejectionReason ?? _rejectionReason,
);
  int? get userId => _userId;
  int? get id => _id;
  String? get assetUrl => _assetUrl;
  String? get assetType => _assetType;
  String? get title => _title;
  String? get badge => _badge;
  String? get winnerBy => _winnerBy;
  String? get description => _description;
  String? get challengeExpiry => _challengeExpiry;
  String? get challengeStatus => _challengeStatus;
  String? get state => _state;
  dynamic get rejectionReason => _rejectionReason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['id'] = _id;
    map['assetUrl'] = _assetUrl;
    map['assetType'] = _assetType;
    map['title'] = _title;
    map['badge'] = _badge;
    map['winnerBy'] = _winnerBy;
    map['description'] = _description;
    map['challengeExpiry'] = _challengeExpiry;
    map['challengeStatus'] = _challengeStatus;
    map['state'] = _state;
    map['rejectionReason'] = _rejectionReason;
    return map;
  }

}