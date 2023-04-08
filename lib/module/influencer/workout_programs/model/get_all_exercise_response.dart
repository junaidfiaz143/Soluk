import 'package:app/res/globals.dart';

class GetAllExerciseResponse {
  GetAllExerciseResponse({
    this.status,
    this.responseCode,
    this.responseDescription,
    this.responseDetails,
  });
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  GetAllExerciseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    responseDescription = json['responseDescription'];
    responseDetails = json['responseDetails'] != null
        ? ResponseDetails.fromJson(json['responseDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = Map<String, dynamic>();
    _data['status'] = status;
    _data['responseCode'] = responseCode;
    _data['responseDescription'] = responseDescription;
    if (responseDetails != null) {
      _data['responseDetails'] = responseDetails!.toJson();
    }
    return _data;
  }
}

class ResponseDetails {
  int? currentPage;
  List<Data>? data;
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
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  Data(
      {required this.id,
      required this.workoutId,
      required this.workoutWeekId,
      required this.workoutDayId,
      required this.title,
      required this.workoutType,
      required this.exerciseTime,
      required this.assetType,
      required this.assetUrl,
      required this.instructions,
      required this.restTime,
      required this.videoDuration,
      required this.isActive,
      required this.createdBy,
      this.sets});
  late final int id;
  late final int workoutId;
  late final int workoutWeekId;
  late final int workoutDayId;
  late final String title;
  late final String description;
  late final int parent;
  late final String workoutType;
  late final String exerciseTime;
  late final String assetType;
  late final String assetUrl;
  late final String instructions;
  late final String restTime;
  late final String videoDuration;
  late final int isActive;
  late final int createdBy;
  List<Sets>? sets;
  List<SubType>? subtypes;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutId = json['workoutId'];
    workoutWeekId = json['workoutWeekId'];
    workoutDayId = json['workoutDayId'];
    title = json['title'] ?? '';
    parent = json['parent'];
    description = json['description'] ?? '';
    workoutType = json['workoutType'] ?? '';
    exerciseTime = json['exerciseTime'] ?? '';
    assetType = json['assetType'] ?? '';
    assetUrl = json['assetUrl'] ?? '';
    instructions = json['instructions'] ?? '';
    restTime = json['restTime'] ?? '';
    videoDuration = json['videoDuration'] ?? '';
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    solukLog(logMsg: json);

    if (json['sets'] != null) {
      sets = <Sets>[];
      json['sets'].forEach((v) {
        solukLog(logMsg: v, logDetail: "inside getAllExerciseResponse Data");
        sets!.add(Sets.fromJson(v));
      });
    } else {
      solukLog(
          logMsg: "sets are null",
          logDetail: "inside getAllExerciseResponse Data");
    }
    if (json['sub_types'] != null) {
      subtypes = <SubType>[];
      json['sub_types'].forEach((v) {
        subtypes!.add(SubType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['workoutId'] = workoutId;
    data['workoutWeekId'] = workoutWeekId;
    data['workoutDayId'] = workoutDayId;
    data['title'] = title;
    data['parent'] = parent;
    data['description'] = description;
    data['workoutType'] = workoutType;
    data['exerciseTime'] = exerciseTime;
    data['assetType'] = assetType;
    data['assetUrl'] = assetUrl;
    data['instructions'] = instructions;
    data['restTime'] = restTime;
    data['videoDuration'] = videoDuration;
    data['isActive'] = isActive;
    data['createdBy'] = createdBy;
    if (sets != null) {
      data['sets'] = sets!.map((v) => v.toJson()).toList();
    }
    if (subtypes != null) {
      data['sub_types'] = subtypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sets {
  Sets(
      {required this.id,
      required this.workoutDayExerciseId,
      required this.title,
      required this.workoutType,
      required this.exerciseTime,
      required this.assetType,
      required this.assetUrl,
      required this.instructions,
      required this.restTime,
      required this.videoDuration,
      required this.createdBy,
      required this.subTypeId,
      this.type,
      required this.meta});
  late final int id;
  late final int workoutDayExerciseId;
  late final String title;
  late final String workoutType;
  late final String exerciseTime;
  late final String assetType;
  late final String assetUrl;
  late final String instructions;
  late final String restTime;
  late final String videoDuration;
  late final int createdBy;
  late final int subTypeId;
  String? type;
  late final String? meta;

  Sets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutDayExerciseId = json['workoutDayExerciseId'];
    title = json['title'] ?? '';
    workoutType = json['workoutType'] ?? '';
    exerciseTime = json['exerciseTime'] ?? '';
    assetType = json['assetType'] ?? '';
    assetUrl = json['assetUrl'] ?? '';
    instructions = json['instructions'] ?? '';
    restTime = json['restTime'] ?? '';
    videoDuration = json['videoDuration'] ?? '';
    createdBy = json['createdBy'];
    subTypeId = json['subTypeId'] ?? 0;
    type = json['type'];
    meta = (json['meta']) ?? "";
    // solukLog(
    //     logMsg: json["meta"], logDetail: "inside get_all_exercise_response");
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['workoutDayExerciseId'] = workoutDayExerciseId;
    data['title'] = title;
    data['workoutType'] = workoutType;
    data['exerciseTime'] = exerciseTime;
    data['assetType'] = assetType;
    data['assetUrl'] = assetUrl;
    data['instructions'] = instructions;
    data['restTime'] = restTime;
    data['videoDuration'] = videoDuration;
    data['createdBy'] = createdBy;
    data['subTypeId'] = subTypeId;
    data['type'] = type;
    data['meta'] = meta;
    return data;
  }
}

class SubType {
  int? id;
  int? workoutDayExerciseId;
  String? restTime;
  String? exerciseTime;
  int? createdBy;
  String? subType;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;

  SubType(
      {this.id,
      this.workoutDayExerciseId,
      this.restTime,
      this.exerciseTime,
      this.createdBy,
      this.subType,
      this.createdDate,
      this.modifiedBy,
      this.modifiedDate});

  SubType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutDayExerciseId = json['workoutDayExerciseId'];
    restTime = json['restTime'];
    exerciseTime = json['exerciseTime'];
    createdBy = json['createdBy'];
    subType = json['subType'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['workoutDayExerciseId'] = workoutDayExerciseId;
    data['restTime'] = restTime;
    data['exerciseTime'] = exerciseTime;
    data['createdBy'] = createdBy;
    data['subType'] = subType;
    data['createdDate'] = createdDate;
    data['modifiedBy'] = modifiedBy;
    data['modifiedDate'] = modifiedDate;
    return data;
  }
}

class Links {
  Links({
    required this.url,
    required this.label,
    required this.active,
  });
  late final String url;
  late final String label;
  late final bool active;

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'] ?? '';
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
