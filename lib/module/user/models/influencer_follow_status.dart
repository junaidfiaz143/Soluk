/// status : "success"
/// responseCode : "00"
/// responseDescription : "Influencer List"
/// responseDetails : {"current_page":1,"data":[{"id":63,"fullname":"Shams ali","email":"Shamsali.dev@gmail.com","phone":"966536677888","roleId":1,"promoCode":"empty","instagram":null,"youtube":null,"isActive":1,"isVerified":0,"createBy":1,"otp":"956301","facebook":null,"imageUrl":null,"reason":null}],"first_page_url":"https://soluk.app/api/influencers?page=1","from":1,"last_page":1,"last_page_url":"https://soluk.app/api/influencers?page=1","links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/influencers?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"next_page_url":null,"path":"https://soluk.app/api/influencers","per_page":100,"prev_page_url":null,"to":1,"total":1}

class InfluencerFollowStatus {
  InfluencerFollowStatus({
      String? status, 
      String? responseCode, 
      String? responseDescription, 
      ResponseDetails? responseDetails,}){
    _status = status;
    _responseCode = responseCode;
    _responseDescription = responseDescription;
    _responseDetails = responseDetails;
}

  InfluencerFollowStatus.fromJson(dynamic json) {
    _status = json['status'];
    _responseCode = json['responseCode'];
    _responseDescription = json['responseDescription'];
    _responseDetails = json['responseDetails'] != null ? ResponseDetails.fromJson(json['responseDetails']) : null;
  }
  String? _status;
  String? _responseCode;
  String? _responseDescription;
  ResponseDetails? _responseDetails;
InfluencerFollowStatus copyWith({  String? status,
  String? responseCode,
  String? responseDescription,
  ResponseDetails? responseDetails,
}) => InfluencerFollowStatus(  status: status ?? _status,
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
/// data : [{"id":63,"fullname":"Shams ali","email":"Shamsali.dev@gmail.com","phone":"966536677888","roleId":1,"promoCode":"empty","instagram":null,"youtube":null,"isActive":1,"isVerified":0,"createBy":1,"otp":"956301","facebook":null,"imageUrl":null,"reason":null}]
/// first_page_url : "https://soluk.app/api/influencers?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://soluk.app/api/influencers?page=1"
/// links : [{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/influencers?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}]
/// next_page_url : null
/// path : "https://soluk.app/api/influencers"
/// per_page : 100
/// prev_page_url : null
/// to : 1
/// total : 1

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

/// id : 63
/// fullname : "Shams ali"
/// email : "Shamsali.dev@gmail.com"
/// phone : "966536677888"
/// roleId : 1
/// promoCode : "empty"
/// instagram : null
/// youtube : null
/// isActive : 1
/// isVerified : 0
/// createBy : 1
/// otp : "956301"
/// facebook : null
/// imageUrl : null
/// reason : null

class Data {
  Data({
      int? id, 
      String? fullname, 
      String? email, 
      String? phone, 
      int? roleId, 
      String? promoCode,
      dynamic instagram,
      dynamic youtube,
      int? isActive, 
      int? isVerified, 
      int? createBy, 
      String? otp, 
      int? followed_influencer_count,
      dynamic facebook,
      dynamic imageUrl, 
      dynamic reason,}){
    _id = id;
    _fullname = fullname;
    _email = email;
    _phone = phone;
    _roleId = roleId;
    _promoCode = promoCode;
    _instagram = instagram;
    _youtube = youtube;
    _isActive = isActive;
    _isVerified = isVerified;
    _createBy = createBy;
    _otp = otp;
    _followed_influencer_count = followed_influencer_count;
    _facebook = facebook;
    _imageUrl = imageUrl;
    _reason = reason;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _fullname = json['fullname'];
    _email = json['email'];
    _phone = json['phone'];
    _roleId = json['roleId'];
    _promoCode = json['promoCode'];
    _instagram = json['instagram'];
    _youtube = json['youtube'];
    _isActive = json['isActive'];
    _isVerified = json['isVerified'];
    _createBy = json['createBy'];
    _otp = json['otp'];
    _followed_influencer_count = json['followed_influencer_count'];
    _facebook = json['facebook'];
    _imageUrl = json['imageUrl'];
    _reason = json['reason'];
  }
  int? _id;
  String? _fullname;
  String? _email;
  String? _phone;
  int? _roleId;
  String? _promoCode;
  dynamic _instagram;
  dynamic _youtube;
  int? _isActive;
  int? _isVerified;
  int? _createBy;
  String? _otp;
  int? _followed_influencer_count;
  dynamic _facebook;
  dynamic _imageUrl;
  dynamic _reason;
Data copyWith({  int? id,
  String? fullname,
  String? email,
  String? phone,
  int? roleId,
  String? promoCode,
  dynamic instagram,
  dynamic youtube,
  int? isActive,
  int? isVerified,
  int? createBy,
  String? otp,
  dynamic facebook,
  dynamic imageUrl,
  dynamic reason,
}) => Data(  id: id ?? _id,
  fullname: fullname ?? _fullname,
  email: email ?? _email,
  phone: phone ?? _phone,
  roleId: roleId ?? _roleId,
  promoCode: promoCode ?? _promoCode,
  instagram: instagram ?? _instagram,
  youtube: youtube ?? _youtube,
  isActive: isActive ?? _isActive,
  isVerified: isVerified ?? _isVerified,
  createBy: createBy ?? _createBy,
  otp: otp ?? _otp,
  facebook: facebook ?? _facebook,
  imageUrl: imageUrl ?? _imageUrl,
  reason: reason ?? _reason,
);
  int? get id => _id;
  int? get followd_influencer_count => _followed_influencer_count;
  String? get fullname => _fullname;
  String? get email => _email;
  String? get phone => _phone;
  int? get roleId => _roleId;
  String? get promoCode => _promoCode;
  dynamic get instagram => _instagram;
  dynamic get youtube => _youtube;
  int? get isActive => _isActive;
  int? get isVerified => _isVerified;
  int? get createBy => _createBy;
  String? get otp => _otp;
  dynamic get facebook => _facebook;
  dynamic get imageUrl => _imageUrl;
  dynamic get reason => _reason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['fullname'] = _fullname;
    map['email'] = _email;
    map['phone'] = _phone;
    map['roleId'] = _roleId;
    map['promoCode'] = _promoCode;
    map['instagram'] = _instagram;
    map['youtube'] = _youtube;
    map['isActive'] = _isActive;
    map['isVerified'] = _isVerified;
    map['createBy'] = _createBy;
    map['otp'] = _otp;
    map['facebook'] = _facebook;
    map['imageUrl'] = _imageUrl;
    map['reason'] = _reason;
    return map;
  }

}