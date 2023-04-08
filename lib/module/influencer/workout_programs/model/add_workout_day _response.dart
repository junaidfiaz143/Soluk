class AddWorkoutDayResponse {
  AddWorkoutDayResponse({
    required this.status,
    required this.responseCode,
    required this.responseDescription,
    required this.responseDetails,
  });
  late final String status;
  late final String responseCode;
  late final String responseDescription;
  late final ResponseDetails responseDetails;

  AddWorkoutDayResponse.fromJson(Map<String, dynamic> json) {
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
    required this.title,
    required this.description,
    required this.workoutId,
    required this.workoutWeekId,
    required this.assetType,
    required this.assetUrl,
    required this.id,
  });
  late final String title;
  late final String description;
  late final String workoutId;
  late final String workoutWeekId;
  late final String assetType;
  late final String assetUrl;
  late final int id;

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    workoutId = json['workoutId'];
    workoutWeekId = json['workoutWeekId'];
    assetType = json['assetType'];
    assetUrl = json['assetUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['description'] = description;
    _data['workoutId'] = workoutId;
    _data['workoutWeekId'] = workoutWeekId;
    _data['assetType'] = assetType;
    _data['assetUrl'] = assetUrl;
    _data['id'] = id;
    return _data;
  }
}
