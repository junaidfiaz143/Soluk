/// status : "success"
/// responseCode : "00"
/// responseDescription : "Client Workout List"
/// responseDetails : {"current_page":1,"data":[{"id":1,"userId":116,"workoutId":56,"progress":0,"state":"inprocess","startedAt":"2022-07-02 11:23:30","created_at":"2022-07-02T11:23:30.000000Z","updated_at":"2022-07-02T11:23:30.000000Z","modifiedBy":null,"modifiedDate":null,"workout":{"userId":61,"id":56,"assetType":"Image","assetUrl":"https://soluk.app/storage/images/workoutplan/workout_plan-61-1654366269.jpg","title":"Test Program 04 June","difficultyLevel":"Medium","programType":"Free","completionBadge":"1","description":"Testing program 04 june description","userViews":null,"rating":0,"isActive":1,"rejection_reason":null,"createBy":61,"createdDate":"2022-06-04 18:11:09","modifiedBy":null,"modifiedDate":null,"created_at":"2022-06-04T18:11:09.000000Z","updated_at":"2022-06-04T18:11:09.000000Z"}}],"first_page_url":"https://soluk.app/api/client-workouts?page=1","from":1,"last_page":1,"last_page_url":"https://soluk.app/api/client-workouts?page=1","links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/client-workouts?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"next_page_url":null,"path":"https://soluk.app/api/client-workouts","per_page":100,"prev_page_url":null,"to":1,"total":1}

class MyWorkoutResponse {
  MyWorkoutResponse({
      String? status, 
      String? responseCode, 
      String? responseDescription, 
      ResponseDetails? responseDetails,}){
    _status = status;
    _responseCode = responseCode;
    _responseDescription = responseDescription;
    _responseDetails = responseDetails;
}

  MyWorkoutResponse.fromJson(dynamic json) {
    _status = json['status'];
    _responseCode = json['responseCode'];
    _responseDescription = json['responseDescription'];
    _responseDetails = json['responseDetails'] != null ? ResponseDetails.fromJson(json['responseDetails']) : null;
  }
  String? _status;
  String? _responseCode;
  String? _responseDescription;
  ResponseDetails? _responseDetails;
MyWorkoutResponse copyWith({  String? status,
  String? responseCode,
  String? responseDescription,
  ResponseDetails? responseDetails,
}) => MyWorkoutResponse(  status: status ?? _status,
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
/// data : [{"id":1,"userId":116,"workoutId":56,"progress":0,"state":"inprocess","startedAt":"2022-07-02 11:23:30","created_at":"2022-07-02T11:23:30.000000Z","updated_at":"2022-07-02T11:23:30.000000Z","modifiedBy":null,"modifiedDate":null,"workout":{"userId":61,"id":56,"assetType":"Image","assetUrl":"https://soluk.app/storage/images/workoutplan/workout_plan-61-1654366269.jpg","title":"Test Program 04 June","difficultyLevel":"Medium","programType":"Free","completionBadge":"1","description":"Testing program 04 june description","userViews":null,"rating":0,"isActive":1,"rejection_reason":null,"createBy":61,"createdDate":"2022-06-04 18:11:09","modifiedBy":null,"modifiedDate":null,"created_at":"2022-06-04T18:11:09.000000Z","updated_at":"2022-06-04T18:11:09.000000Z"}}]
/// first_page_url : "https://soluk.app/api/client-workouts?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://soluk.app/api/client-workouts?page=1"
/// links : [{"url":null,"label":"&laquo; Previous","active":false},{"url":"https://soluk.app/api/client-workouts?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}]
/// next_page_url : null
/// path : "https://soluk.app/api/client-workouts"
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


  List<Data> getInProgressList(){
    List<Data> list = [];
    
    for(Data item in this.data!){
      if(item.state?.contains("inprocess") == true){
        list.add(item);
      }
      
    }
    return list;
  }  


  List<Data> getCompletedList(){
    List<Data> list = [];

    for(Data item in this.data!){
      if(item.state?.contains("completed") == true){
        list.add(item);
      }

    }
    return list;
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
  List<Data>? inProgressDataList = null;
  List<Data>? completedDataList = null;
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

/// id : 1
/// userId : 116
/// workoutId : 56
/// progress : 0
/// state : "inprocess"
/// startedAt : "2022-07-02 11:23:30"
/// created_at : "2022-07-02T11:23:30.000000Z"
/// updated_at : "2022-07-02T11:23:30.000000Z"
/// modifiedBy : null
/// modifiedDate : null
/// workout : {"userId":61,"id":56,"assetType":"Image","assetUrl":"https://soluk.app/storage/images/workoutplan/workout_plan-61-1654366269.jpg","title":"Test Program 04 June","difficultyLevel":"Medium","programType":"Free","completionBadge":"1","description":"Testing program 04 june description","userViews":null,"rating":0,"isActive":1,"rejection_reason":null,"createBy":61,"createdDate":"2022-06-04 18:11:09","modifiedBy":null,"modifiedDate":null,"created_at":"2022-06-04T18:11:09.000000Z","updated_at":"2022-06-04T18:11:09.000000Z"}

class Data {
  Data({
      int? id, 
      int? userId, 
      int? workoutId, 
      int? progress, 
      String? state, 
      String? startedAt, 
      String? createdAt, 
      String? updatedAt, 
      dynamic modifiedBy, 
      dynamic modifiedDate, 
      Workout? workout,}){
    _id = id;
    _userId = userId;
    _workoutId = workoutId;
    _progress = progress;
    _state = state;
    _startedAt = startedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _modifiedBy = modifiedBy;
    _modifiedDate = modifiedDate;
    _workout = workout;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _workoutId = json['workoutId'];
    _progress = json['progress'];
    _state = json['state'];
    _startedAt = json['startedAt'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _modifiedBy = json['modifiedBy'];
    _modifiedDate = json['modifiedDate'];
    _workout = json['workout'] != null ? Workout.fromJson(json['workout']) : null;
  }
  int? _id;
  int? _userId;
  int? _workoutId;
  int? _progress;
  String? _state;
  String? _startedAt;
  String? _createdAt;
  String? _updatedAt;
  dynamic _modifiedBy;
  dynamic _modifiedDate;
  Workout? _workout;
Data copyWith({  int? id,
  int? userId,
  int? workoutId,
  int? progress,
  String? state,
  String? startedAt,
  String? createdAt,
  String? updatedAt,
  dynamic modifiedBy,
  dynamic modifiedDate,
  Workout? workout,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  workoutId: workoutId ?? _workoutId,
  progress: progress ?? _progress,
  state: state ?? _state,
  startedAt: startedAt ?? _startedAt,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  modifiedBy: modifiedBy ?? _modifiedBy,
  modifiedDate: modifiedDate ?? _modifiedDate,
  workout: workout ?? _workout,
);
  int? get id => _id;
  int? get userId => _userId;
  int? get workoutId => _workoutId;
  int? get progress => _progress;
  String? get state => _state;
  String? get startedAt => _startedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get modifiedBy => _modifiedBy;
  dynamic get modifiedDate => _modifiedDate;
  Workout? get workout => _workout;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['workoutId'] = _workoutId;
    map['progress'] = _progress;
    map['state'] = _state;
    map['startedAt'] = _startedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['modifiedBy'] = _modifiedBy;
    map['modifiedDate'] = _modifiedDate;
    if (_workout != null) {
      map['workout'] = _workout?.toJson();
    }
    return map;
  }

}

/// userId : 61
/// id : 56
/// assetType : "Image"
/// assetUrl : "https://soluk.app/storage/images/workoutplan/workout_plan-61-1654366269.jpg"
/// title : "Test Program 04 June"
/// difficultyLevel : "Medium"
/// programType : "Free"
/// completionBadge : "1"
/// description : "Testing program 04 june description"
/// userViews : null
/// rating : 0
/// isActive : 1
/// rejection_reason : null
/// createBy : 61
/// createdDate : "2022-06-04 18:11:09"
/// modifiedBy : null
/// modifiedDate : null
/// created_at : "2022-06-04T18:11:09.000000Z"
/// updated_at : "2022-06-04T18:11:09.000000Z"

class Workout {
  Workout({
      int? userId, 
      int? id, 
      String? assetType, 
      String? assetUrl, 
      String? title, 
      String? difficultyLevel, 
      String? programType, 
      String? completionBadge, 
      String? description, 
      dynamic userViews, 
      int? rating, 
      int? isActive, 
      dynamic rejectionReason, 
      int? createBy, 
      String? createdDate, 
      dynamic modifiedBy, 
      dynamic modifiedDate, 
      String? createdAt, 
      String? updatedAt,}){
    _userId = userId;
    _id = id;
    _assetType = assetType;
    _assetUrl = assetUrl;
    _title = title;
    _difficultyLevel = difficultyLevel;
    _programType = programType;
    _completionBadge = completionBadge;
    _description = description;
    _userViews = userViews;
    _rating = rating;
    _isActive = isActive;
    _rejectionReason = rejectionReason;
    _createBy = createBy;
    _createdDate = createdDate;
    _modifiedBy = modifiedBy;
    _modifiedDate = modifiedDate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Workout.fromJson(dynamic json) {
    _userId = json['userId'];
    _id = json['id'];
    _assetType = json['assetType'];
    _assetUrl = json['assetUrl'];
    _title = json['title'];
    _difficultyLevel = json['difficultyLevel'];
    _programType = json['programType'];
    _completionBadge = json['completionBadge'];
    _description = json['description'];
    _userViews = json['userViews'];
    _rating = json['rating'];
    _isActive = json['isActive'];
    _rejectionReason = json['rejection_reason'];
    _createBy = json['createBy'];
    _createdDate = json['createdDate'];
    _modifiedBy = json['modifiedBy'];
    _modifiedDate = json['modifiedDate'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _userId;
  int? _id;
  String? _assetType;
  String? _assetUrl;
  String? _title;
  String? _difficultyLevel;
  String? _programType;
  String? _completionBadge;
  String? _description;
  dynamic _userViews;
  int? _rating;
  int? _isActive;
  dynamic _rejectionReason;
  int? _createBy;
  String? _createdDate;
  dynamic _modifiedBy;
  dynamic _modifiedDate;
  String? _createdAt;
  String? _updatedAt;
Workout copyWith({  int? userId,
  int? id,
  String? assetType,
  String? assetUrl,
  String? title,
  String? difficultyLevel,
  String? programType,
  String? completionBadge,
  String? description,
  dynamic userViews,
  int? rating,
  int? isActive,
  dynamic rejectionReason,
  int? createBy,
  String? createdDate,
  dynamic modifiedBy,
  dynamic modifiedDate,
  String? createdAt,
  String? updatedAt,
}) => Workout(  userId: userId ?? _userId,
  id: id ?? _id,
  assetType: assetType ?? _assetType,
  assetUrl: assetUrl ?? _assetUrl,
  title: title ?? _title,
  difficultyLevel: difficultyLevel ?? _difficultyLevel,
  programType: programType ?? _programType,
  completionBadge: completionBadge ?? _completionBadge,
  description: description ?? _description,
  userViews: userViews ?? _userViews,
  rating: rating ?? _rating,
  isActive: isActive ?? _isActive,
  rejectionReason: rejectionReason ?? _rejectionReason,
  createBy: createBy ?? _createBy,
  createdDate: createdDate ?? _createdDate,
  modifiedBy: modifiedBy ?? _modifiedBy,
  modifiedDate: modifiedDate ?? _modifiedDate,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get userId => _userId;
  int? get id => _id;
  String? get assetType => _assetType;
  String? get assetUrl => _assetUrl;
  String? get title => _title;
  String? get difficultyLevel => _difficultyLevel;
  String? get programType => _programType;
  String? get completionBadge => _completionBadge;
  String? get description => _description;
  dynamic get userViews => _userViews;
  int? get rating => _rating;
  int? get isActive => _isActive;
  dynamic get rejectionReason => _rejectionReason;
  int? get createBy => _createBy;
  String? get createdDate => _createdDate;
  dynamic get modifiedBy => _modifiedBy;
  dynamic get modifiedDate => _modifiedDate;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['id'] = _id;
    map['assetType'] = _assetType;
    map['assetUrl'] = _assetUrl;
    map['title'] = _title;
    map['difficultyLevel'] = _difficultyLevel;
    map['programType'] = _programType;
    map['completionBadge'] = _completionBadge;
    map['description'] = _description;
    map['userViews'] = _userViews;
    map['rating'] = _rating;
    map['isActive'] = _isActive;
    map['rejection_reason'] = _rejectionReason;
    map['createBy'] = _createBy;
    map['createdDate'] = _createdDate;
    map['modifiedBy'] = _modifiedBy;
    map['modifiedDate'] = _modifiedDate;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}