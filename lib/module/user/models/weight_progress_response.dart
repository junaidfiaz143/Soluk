/// status : "success"
/// responseCode : "00"
/// responseDescription : "User weight progress listing!"
/// responseDetails : {"current_page":1,"data":[{"id":4,"weight":20,"user_id":61,"imageUrl":"https://soluk.app/storage/images/user_weight/user_weight-61-1657282368.jpg","createdDate":"2022-07-06 16:53:36","created_at":"2022-07-08T12:12:48.000000Z","updated_at":"2022-07-08T12:12:48.000000Z"},{"id":5,"weight":20,"user_id":61,"imageUrl":null,"createdDate":"2022-07-06 16:53:36","created_at":"2022-07-08T13:15:50.000000Z","updated_at":"2022-07-08T13:15:50.000000Z"},{"id":6,"weight":30,"user_id":61,"imageUrl":null,"createdDate":"2022-07-09 16:53:36","created_at":"2022-07-08T13:16:25.000000Z","updated_at":"2022-07-08T13:16:25.000000Z"},{"id":7,"weight":50,"user_id":61,"imageUrl":null,"createdDate":"2022-07-09 16:53:36","created_at":"2022-07-08T13:16:33.000000Z","updated_at":"2022-07-08T13:16:33.000000Z"},{"id":8,"weight":50,"user_id":61,"imageUrl":null,"createdDate":"2022-07-10 16:53:36","created_at":"2022-07-08T13:16:40.000000Z","updated_at":"2022-07-08T13:16:40.000000Z"}],"first_page_url":"https://soluk.app/api/user-weight?page=1","from":1,"last_page":1,"last_page_url":"https://soluk.app/api/user-weight?page=1","links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/user-weight?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"next_page_url":null,"path":"https://soluk.app/api/user-weight","per_page":100,"prev_page_url":null,"to":5,"total":5}

class WeightProgressResponse {
  WeightProgressResponse({
      String? status, 
      String? responseCode, 
      String? responseDescription, 
      ResponseDetails? responseDetails,}){
    _status = status;
    _responseCode = responseCode;
    _responseDescription = responseDescription;
    _responseDetails = responseDetails;
}

  WeightProgressResponse.fromJson(dynamic json) {
    _status = json['status'];
    _responseCode = json['responseCode'];
    _responseDescription = json['responseDescription'];
    _responseDetails = json['responseDetails'] != null ? ResponseDetails.fromJson(json['responseDetails']) : null;
  }
  String? _status;
  String? _responseCode;
  String? _responseDescription;
  ResponseDetails? _responseDetails;
WeightProgressResponse copyWith({  String? status,
  String? responseCode,
  String? responseDescription,
  ResponseDetails? responseDetails,
}) => WeightProgressResponse(  status: status ?? _status,
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
/// data : [{"id":4,"weight":20,"user_id":61,"imageUrl":"https://soluk.app/storage/images/user_weight/user_weight-61-1657282368.jpg","createdDate":"2022-07-06 16:53:36","created_at":"2022-07-08T12:12:48.000000Z","updated_at":"2022-07-08T12:12:48.000000Z"},{"id":5,"weight":20,"user_id":61,"imageUrl":null,"createdDate":"2022-07-06 16:53:36","created_at":"2022-07-08T13:15:50.000000Z","updated_at":"2022-07-08T13:15:50.000000Z"},{"id":6,"weight":30,"user_id":61,"imageUrl":null,"createdDate":"2022-07-09 16:53:36","created_at":"2022-07-08T13:16:25.000000Z","updated_at":"2022-07-08T13:16:25.000000Z"},{"id":7,"weight":50,"user_id":61,"imageUrl":null,"createdDate":"2022-07-09 16:53:36","created_at":"2022-07-08T13:16:33.000000Z","updated_at":"2022-07-08T13:16:33.000000Z"},{"id":8,"weight":50,"user_id":61,"imageUrl":null,"createdDate":"2022-07-10 16:53:36","created_at":"2022-07-08T13:16:40.000000Z","updated_at":"2022-07-08T13:16:40.000000Z"}]
/// first_page_url : "https://soluk.app/api/user-weight?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://soluk.app/api/user-weight?page=1"
/// links : [{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/user-weight?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}]
/// next_page_url : null
/// path : "https://soluk.app/api/user-weight"
/// per_page : 100
/// prev_page_url : null
/// to : 5
/// total : 5

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

/// id : 4
/// weight : 20
/// user_id : 61
/// imageUrl : "https://soluk.app/storage/images/user_weight/user_weight-61-1657282368.jpg"
/// createdDate : "2022-07-06 16:53:36"
/// created_at : "2022-07-08T12:12:48.000000Z"
/// updated_at : "2022-07-08T12:12:48.000000Z"

class Data {
  Data({
      int? id, 
      int? weight, 
      int? userId, 
      String? imageUrl, 
      DateTime? createdDate,
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _weight = weight;
    _userId = userId;
    _imageUrl = imageUrl;
    _createdDate = createdDate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _weight = json['weight'];
    _userId = json['user_id'];
    _imageUrl = json['imageUrl'];
    _createdDate = DateTime.parse(json['createdDate']);
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _weight;
  int? _userId;
  String? _imageUrl;
  DateTime? _createdDate;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  int? id,
  int? weight,
  int? userId,
  String? imageUrl,
  DateTime? createdDate,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  weight: weight ?? _weight,
  userId: userId ?? _userId,
  imageUrl: imageUrl ?? _imageUrl,
  createdDate: createdDate ?? _createdDate,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get id => _id;
  int? get weight => _weight;
  int? get userId => _userId;
  String? get imageUrl => _imageUrl;
  DateTime? get createdDate => _createdDate;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['weight'] = _weight;
    map['user_id'] = _userId;
    map['imageUrl'] = _imageUrl;
    map['createdDate'] = _createdDate;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}