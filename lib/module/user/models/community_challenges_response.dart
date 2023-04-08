import 'package:app/module/influencer/challenges/model/challenges_details_modals.dart';

/// status : "success"
/// responseCode : "00"
/// responseDescription : "Challenge List"
/// responseDetails : {"current_page":1,"data":[{"userId":61,"id":69,"assetUrl":"https://soluk.app/storage/images/challenge/challenge-61-1657973816.jpg","assetType":"Image","title":"Testing Challenge Name X","badge":"1","winnerBy":"Influencer","description":"Description of the badge goes here...","challengeExpiry":"2023-04-30 12:12:30","challengeStatus":"Approved","state":"inprogress","rejectionReason":null}],"first_page_url":"https://soluk.app/api/user/challenges?page=1","from":1,"last_page":1,"last_page_url":"https://soluk.app/api/user/challenges?page=1","links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/user/challenges?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"next_page_url":null,"path":"https://soluk.app/api/user/challenges","per_page":100,"prev_page_url":null,"to":1,"total":1}

class CommunityChallengesResponse {
  CommunityChallengesResponse({
      String? status, 
      String? responseCode, 
      String? responseDescription, 
      ResponseDetails? responseDetails,}){
    _status = status;
    _responseCode = responseCode;
    _responseDescription = responseDescription;
    _responseDetails = responseDetails;
}

  CommunityChallengesResponse.fromJson(dynamic json) {
    _status = json['status'];
    _responseCode = json['responseCode'];
    _responseDescription = json['responseDescription'];
    _responseDetails = json['responseDetails'] != null ? ResponseDetails.fromJson(json['responseDetails']) : null;
  }
  String? _status;
  String? _responseCode;
  String? _responseDescription;
  ResponseDetails? _responseDetails;
CommunityChallengesResponse copyWith({  String? status,
  String? responseCode,
  String? responseDescription,
  ResponseDetails? responseDetails,
}) => CommunityChallengesResponse(  status: status ?? _status,
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
/// data : [{"userId":61,"id":69,"assetUrl":"https://soluk.app/storage/images/challenge/challenge-61-1657973816.jpg","assetType":"Image","title":"Testing Challenge Name X","badge":"1","winnerBy":"Influencer","description":"Description of the badge goes here...","challengeExpiry":"2023-04-30 12:12:30","challengeStatus":"Approved","state":"inprogress","rejectionReason":null}]
/// first_page_url : "https://soluk.app/api/user/challenges?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://soluk.app/api/user/challenges?page=1"
/// links : [{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/user/challenges?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}]
/// next_page_url : null
/// path : "https://soluk.app/api/user/challenges"
/// per_page : 100
/// prev_page_url : null
/// to : 1
/// total : 1

class ResponseDetails {
  ResponseDetails({
      int? currentPage, 
      List<ChallengeModel>? data,
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
        _data?.add(ChallengeModel.fromJson(v));
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
  List<ChallengeModel>? _data;
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
  List<ChallengeModel>? data,
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
  List<ChallengeModel>? get data => _data;
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

/// userId : 61
/// id : 69
/// assetUrl : "https://soluk.app/storage/images/challenge/challenge-61-1657973816.jpg"
/// assetType : "Image"
/// title : "Testing Challenge Name X"
/// badge : "1"
/// winnerBy : "Influencer"
/// description : "Description of the badge goes here..."
/// challengeExpiry : "2023-04-30 12:12:30"
/// challengeStatus : "Approved"
/// state : "inprogress"
/// rejectionReason : null

class Data {
  Data({
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

  Data.fromJson(dynamic json) {
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
Data copyWith({  int? userId,
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
}) => Data(  userId: userId ?? _userId,
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