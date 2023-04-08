import 'package:app/module/influencer/workout/model/tags.dart';

class UserWorkoutsModel {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  UserWorkoutsModel(
      {this.status,
        this.responseCode,
        this.responseDescription,
        this.responseDetails});

  UserWorkoutsModel.fromJson(Map<String, dynamic> json) {
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
  List<UserWorkout>? data;
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
      data = <UserWorkout>[];
      json['data'].forEach((v) {
        data!.add(new UserWorkout.fromJson(v));
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

class UserWorkout {
  int? userId;
  int? id;
  String? assetType;
  String? assetUrl;
  String? title;
  String? difficultyLevel;
  String? programType;
  String? completionBadge;
  String? description;
  int? views;
  int? rating;
  int? isActive;
  String? rejectionReason;
  int? createBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  String? createdAt;
  String? updatedAt;
  int? weeksCount;
  int? exercisesCount;
  MyWorkoutStats? myWorkoutStats;
  List<TagData>? workoutPlanTags;

  UserWorkout(
      {this.userId,
        this.id,
        this.assetType,
        this.assetUrl,
        this.title,
        this.difficultyLevel,
        this.programType,
        this.completionBadge,
        this.description,
        this.views,
        this.rating,
        this.isActive,
        this.rejectionReason,
        this.createBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
        this.createdAt,
        this.updatedAt,
        this.weeksCount,
        this.exercisesCount,
        this.myWorkoutStats,
        this.workoutPlanTags});

  UserWorkout.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    assetType = json['assetType'];
    assetUrl = json['assetUrl'];
    title = json['title'];
    difficultyLevel = json['difficultyLevel'];
    programType = json['programType'];
    completionBadge = json['completionBadge'];
    description = json['description'];
    views = json['views'];
    rating = json['rating'];
    isActive = json['isActive'];
    rejectionReason = json['rejection_reason'];
    createBy = json['createBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    weeksCount = json['weeks_count'];
    exercisesCount = json['exercises_count'];
    myWorkoutStats = json['my_workout_stats'] != null
        ? new MyWorkoutStats.fromJson(json['my_workout_stats'])
        : null;
    if (json['workout_plan_tags'] != null) {
      workoutPlanTags = <TagData>[];
      json['workout_plan_tags'].forEach((v) {
        workoutPlanTags!.add(new TagData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['assetType'] = this.assetType;
    data['assetUrl'] = this.assetUrl;
    data['title'] = this.title;
    data['difficultyLevel'] = this.difficultyLevel;
    data['programType'] = this.programType;
    data['completionBadge'] = this.completionBadge;
    data['description'] = this.description;
    data['views'] = this.views;
    data['rating'] = this.rating;
    data['isActive'] = this.isActive;
    data['rejection_reason'] = this.rejectionReason;
    data['createBy'] = this.createBy;
    data['createdDate'] = this.createdDate;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedDate'] = this.modifiedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['weeks_count'] = this.weeksCount;
    data['exercises_count'] = this.exercisesCount;
    if (this.myWorkoutStats != null) {
      data['my_workout_stats'] = this.myWorkoutStats!.toJson();
    }
    if (this.workoutPlanTags != null) {
      data['workout_plan_tags'] =
          this.workoutPlanTags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyWorkoutStats {
  int? id;
  int? userId;
  int? workoutId;
  int? progress;
  String? state;
  String? startedAt;
  String? createdAt;
  String? updatedAt;
  int? modifiedBy;
  String? modifiedDate;

  MyWorkoutStats(
      {this.id,
        this.userId,
        this.workoutId,
        this.progress,
        this.state,
        this.startedAt,
        this.createdAt,
        this.updatedAt,
        this.modifiedBy,
        this.modifiedDate});

  MyWorkoutStats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    workoutId = json['workoutId'];
    progress = json['progress'];
    state = json['state'];
    startedAt = json['startedAt'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['workoutId'] = this.workoutId;
    data['progress'] = this.progress;
    data['state'] = this.state;
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
