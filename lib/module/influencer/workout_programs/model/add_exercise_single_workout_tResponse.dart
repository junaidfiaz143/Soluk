class AddExerciseSingleWorkoutTResponse {
  AddExerciseSingleWorkoutTResponse({
    required this.status,
    required this.responseCode,
    required this.responseDescription,
    required this.responseDetails,
  });
  late final String status;
  late final String responseCode;
  late final String responseDescription;
  late final ResponseDetails responseDetails;

  AddExerciseSingleWorkoutTResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    responseDescription = json['responseDescription'];
    responseDetails = ResponseDetails.fromJson(json['responseDetails']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['responseCode'] = responseCode;
    _data['responseDescription'] = responseDescription;
    _data['responseDetails'] = responseDetails.toJson();
    return _data;
  }
}

class ResponseDetails {
  ResponseDetails({
    required this.workoutId,
    required this.workoutWeekId,
    required this.workoutDayId,
    required this.title,
    required this.workoutType,
    required this.exerciseTime,
    required this.instructions,
    required this.restTime,
    required this.assetType,
    required this.assetUrl,
    required this.isActive,
    required this.createdBy,
    required this.id,
  });
  late final int workoutId;
  late final int workoutWeekId;
  late final int workoutDayId;
  late final String title;
  late final String workoutType;
  late final String exerciseTime;
  late final String instructions;
  late final String restTime;
  late final String assetType;
  late final String assetUrl;
  late final int isActive;
  late final int createdBy;
  late final int id;

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    workoutId = json['workoutId'];
    workoutWeekId = json['workoutWeekId'];
    workoutDayId = json['workoutDayId'];
    title = json['title'];
    workoutType = json['workoutType'];
    exerciseTime = json['exerciseTime'];
    instructions = json['instructions'];
    restTime = json['restTime'];
    assetType = json['assetType'];
    assetUrl = json['assetUrl'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['workoutId'] = workoutId;
    _data['workoutWeekId'] = workoutWeekId;
    _data['workoutDayId'] = workoutDayId;
    _data['title'] = title;
    _data['workoutType'] = workoutType;
    _data['exerciseTime'] = exerciseTime;
    _data['instructions'] = instructions;
    _data['restTime'] = restTime;
    _data['assetType'] = assetType;
    _data['assetUrl'] = assetUrl;
    _data['isActive'] = isActive;
    _data['createdBy'] = createdBy;
    _data['id'] = id;
    return _data;
  }
}
