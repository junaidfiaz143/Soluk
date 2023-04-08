class UserWorkoutWeeksModel {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  UserWorkoutWeeksModel(
      {this.status,
      this.responseCode,
      this.responseDescription,
      this.responseDetails});

  UserWorkoutWeeksModel.fromJson(Map<String, dynamic> json) {
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
  List<Weeks>? data;
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
      data = <Weeks>[];
      json['data'].forEach((v) {
        data!.add(new Weeks.fromJson(v));
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

class Weeks {
  int? id;
  int? workoutPlanId;
  int? userId;
  String? assetType;
  String? assetUrl;
  String? title;
  String? description;
  MyWeekStats? myWeekStats;

  Weeks(
      {this.id,
      this.workoutPlanId,
      this.userId,
      this.assetType,
      this.assetUrl,
      this.title,
      this.description,
      this.myWeekStats});

  Weeks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutPlanId = json['workoutPlanId'];
    userId = json['userId'];
    assetType = json['assetType'];
    assetUrl = json['assetUrl'];
    title = json['title'];
    description = json['description'];
    myWeekStats = json['my_week_stats'] != null
        ? new MyWeekStats.fromJson(json['my_week_stats'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workoutPlanId'] = this.workoutPlanId;
    data['userId'] = this.userId;
    data['assetType'] = this.assetType;
    data['assetUrl'] = this.assetUrl;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.myWeekStats != null) {
      data['my_week_stats'] = this.myWeekStats!.toJson();
    }
    return data;
  }
}

class MyWeekStats {
  int? id;
  int? workoutId;
  int? workoutWeekId;
  String? state;
  int? userId;
  String? startedAt;
  String? createdAt;
  String? updatedAt;
  int? modifiedBy;
  String? modifiedDate;

  MyWeekStats(
      {this.id,
      this.workoutId,
      this.workoutWeekId,
      this.state,
      this.userId,
      this.startedAt,
      this.createdAt,
      this.updatedAt,
      this.modifiedBy,
      this.modifiedDate});

  MyWeekStats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutId = json['workoutId'];
    workoutWeekId = json['workoutWeekId'];
    state = json['state'];
    userId = json['userId'];
    startedAt = json['startedAt'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workoutId'] = this.workoutId;
    data['workoutWeekId'] = this.workoutWeekId;
    data['state'] = this.state;
    data['userId'] = this.userId;
    data['startedAt'] = this.startedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedDate'] = this.modifiedDate;
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
