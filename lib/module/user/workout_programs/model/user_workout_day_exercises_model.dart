import 'package:app/res/globals.dart';

class UserWorkoutDayExercisesModel {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  UserWorkoutDayExercisesModel({this.status, this.responseCode, this.responseDescription, this.responseDetails});

  UserWorkoutDayExercisesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    responseDescription = json['responseDescription'];
    responseDetails = json['responseDetails'] != null ? new ResponseDetails.fromJson(json['responseDetails']) : null;
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
  List<DayExercise>? data;
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
      data = <DayExercise>[];
      json['data'].forEach((v) {
        data!.add(new DayExercise.fromJson(v));
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

class DayExercise {
  int? id;
  int? workoutId;
  int? workoutWeekId;
  int? workoutDayId;
  String? title;
  String? workoutType;
  String? exerciseTime;
  String? assetType;
  String? assetUrl;
  String? instructions;
  String? restTime;
  String? videoDuration;
  int? isActive;
  int? views;
  int? createdBy;
  MyExerciseStats? myExerciseStats;
  List<Sets>? sets;
  List<SubTypes>? subTypes;

  DayExercise(
      {this.id,
      this.workoutId,
      this.workoutWeekId,
      this.workoutDayId,
      this.title,
      this.workoutType,
      this.exerciseTime,
      this.assetType,
      this.assetUrl,
      this.instructions,
      this.restTime,
      this.videoDuration,
      this.isActive,
      this.views,
      this.createdBy,
      this.myExerciseStats,
      this.sets,
      this.subTypes});

  DayExercise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutId = json['workoutId'];
    workoutWeekId = json['workoutWeekId'];
    workoutDayId = json['workoutDayId'];
    title = json['title'];
    workoutType = json['workoutType'];
    exerciseTime = json['exerciseTime'];
    assetType = json['assetType'];
    assetUrl = json['assetUrl'];
    instructions = json['instructions'];
    restTime = json['restTime'];
    videoDuration = json['videoDuration'];
    isActive = json['isActive'];
    views = json['views'];
    createdBy = json['createdBy'];
    myExerciseStats =
        json['my_exercise_stats'] != null ? new MyExerciseStats.fromJson(json['my_exercise_stats']) : null;
    if (json['sets'] != null) {
      sets = <Sets>[];
      json['sets'].forEach((v) {
        sets!.add(new Sets.fromJson(v));
      });
    }
    if (json['sub_types'] != null) {
      subTypes = <SubTypes>[];
      json['sub_types'].forEach((v) {
        subTypes!.add(new SubTypes.fromJson(v));
      });
    }
    // subTypeStats = <SubTypeStats>[];
    // json["sub_types"].forEach((v) {
    //   if (v["my_exercise_sub_type_stats"] != null) {
    //     subTypeStats!
    //         .add(new SubTypeStats.fromJson(v["my_exercise_sub_type_stats"]));
    //   }
    // });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workoutId'] = this.workoutId;
    data['workoutWeekId'] = this.workoutWeekId;
    data['workoutDayId'] = this.workoutDayId;
    data['title'] = this.title;
    data['workoutType'] = this.workoutType;
    data['exerciseTime'] = this.exerciseTime;
    data['assetType'] = this.assetType;
    data['assetUrl'] = this.assetUrl;
    data['instructions'] = this.instructions;
    data['restTime'] = this.restTime;
    data['videoDuration'] = this.videoDuration;
    data['isActive'] = this.isActive;
    data['views'] = this.views;
    data['createdBy'] = this.createdBy;
    if (this.myExerciseStats != null) {
      data['my_exercise_stats'] = this.myExerciseStats!.toJson();
    }
    if (this.sets != null) {
      data['sets'] = this.sets!.map((v) => v.toJson()).toList();
    }
    if (this.subTypes != null) {
      data['sub_types'] = this.subTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyExerciseStats {
  int? id;
  int? workoutId;
  int? workoutWeekId;
  int? workoutWeekDayId;
  int? workoutWeekDayExerciseId;
  String? state;
  int? userId;
  String? startedAt;
  String? createdAt;
  String? updatedAt;
  int? modifiedBy;
  String? modifiedDate;

  MyExerciseStats(
      {this.id,
      this.workoutId,
      this.workoutWeekId,
      this.workoutWeekDayId,
      this.workoutWeekDayExerciseId,
      this.state,
      this.userId,
      this.startedAt,
      this.createdAt,
      this.updatedAt,
      this.modifiedBy,
      this.modifiedDate});

  MyExerciseStats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutId = json['workoutId'];
    workoutWeekId = json['workoutWeekId'];
    workoutWeekDayId = json['workoutWeekDayId'];
    workoutWeekDayExerciseId = json['workoutWeekDayExerciseId'];
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
    data['workoutWeekDayId'] = this.workoutWeekDayId;
    data['workoutWeekDayExerciseId'] = this.workoutWeekDayExerciseId;
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

class Sets {
  int? id;
  int? workoutDayExerciseId;
  String? type;
  String? title;
  String? assetType;
  String? assetUrl;
  int? subTypeId;
  String? instructions;
  String? restTime;
  String? meta;
  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  bool? isChecked = false;
  SetStats? setStats;

  Sets(
      {this.id,
      this.workoutDayExerciseId,
      this.type,
      this.title,
      this.assetType,
      this.assetUrl,
      this.subTypeId,
      this.instructions,
      this.restTime,
      this.meta,
      this.createdBy,
      this.createdDate,
      this.modifiedBy,
      this.modifiedDate});

  Sets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutDayExerciseId = json['workoutDayExerciseId'];
    type = json['type'];
    title = json['title'];
    assetType = json['assetType'];
    assetUrl = json['assetUrl'];
    subTypeId = json['subTypeId'];
    instructions = json['instructions'];
    restTime = json['restTime'];
    meta = json['meta'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    if (json['my_set_stats'] != null) {
      setStats = SetStats.fromJson(json['my_set_stats']);
    }
    // setStats = SetStats.fromJson(json['my_set_stats']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workoutDayExerciseId'] = this.workoutDayExerciseId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['assetType'] = this.assetType;
    data['assetUrl'] = this.assetUrl;
    data['subTypeId'] = this.subTypeId;
    data['instructions'] = this.instructions;
    data['restTime'] = this.restTime;
    data['meta'] = this.meta;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedDate'] = this.modifiedDate;
    return data;
  }
}

class SubTypes {
  int? id;
  int? workoutDayExerciseId;
  String? restTime;
  String? exerciseTime;
  int? createdBy;
  String? subType;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  bool isSubmitted = false;
  SubTypeStats? subTypeStats;

  SubTypes(
      {this.id,
      this.workoutDayExerciseId,
      this.restTime,
      this.exerciseTime,
      this.createdBy,
      this.subType,
      this.createdDate,
      this.modifiedBy,
      this.modifiedDate,
      this.subTypeStats});

  SubTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutDayExerciseId = json['workoutDayExerciseId'];
    restTime = json['restTime'];
    exerciseTime = json['exerciseTime'];
    createdBy = json['createdBy'];
    subType = json['subType'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];

    solukLog(logMsg: json["my_exercise_sub_type_stats"], logDetail: "my_exercise_sub_type_stats");

    if (json["my_exercise_sub_type_stats"] != null) {
      // subTypeStats = <SubTypeStats>[];

      subTypeStats = SubTypeStats.fromJson(json["my_exercise_sub_type_stats"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workoutDayExerciseId'] = this.workoutDayExerciseId;
    data['restTime'] = this.restTime;
    data['exerciseTime'] = this.exerciseTime;
    data['createdBy'] = this.createdBy;
    data['subType'] = this.subType;
    data['createdDate'] = this.createdDate;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedDate'] = this.modifiedDate;

    return data;
  }
}

class SubTypeStats {
  int? id;
  int? workoutId;
  int? workoutWeekId;
  int? workoutWeekDayId;
  int? workoutWeekDayExerciseId;
  int? workoutWeekDayExerciseSubId;
  String? state;
  int? userId;
  String? startedAt;
  String? created_at;
  String? updated_at;
  int? modifiedBy;
  String? modifiedDate;

  SubTypeStats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutId = json['workoutId'];
    workoutWeekId = json['workoutWeekId'];
    workoutWeekDayId = json['workoutWeekDayId'];
    workoutWeekDayExerciseId = json['workoutWeekDayExerciseId'];
    workoutWeekDayExerciseSubId = json['workoutWeekDayExerciseSubId'];
    state = json['state'];
    userId = json['exerciseTime'];
    startedAt = json['startedAt'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
  }
}

class SetStats {
  int? id;
  int? workoutId;
  int? workoutWeekId;
  int? workoutWeekDayId;
  int? workoutWeekDayExerciseId;
  int? workoutWeekDayExerciseSubId;
  String? state;
  int? userId;
  String? startedAt;
  String? created_at;
  String? updated_at;
  int? modifiedBy;
  String? modifiedDate;

  SetStats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutId = json['workoutId'];
    workoutWeekId = json['workoutWeekId'];
    workoutWeekDayId = json['workoutWeekDayId'];
    workoutWeekDayExerciseId = json['workoutWeekDayExerciseId'];
    workoutWeekDayExerciseSubId = json['workoutWeekDayExerciseSetId'];
    state = json['state'];
    userId = json['exerciseTime'];
    startedAt = json['startedAt'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
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
