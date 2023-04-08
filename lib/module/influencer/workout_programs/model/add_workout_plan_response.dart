class AddWorkoutPlanResponse {
  AddWorkoutPlanResponse({
    required this.status,
    required this.responseCode,
    required this.responseDescription,
    required this.responseDetails,
  });
  late final String status;
  late final String responseCode;
  late final String responseDescription;
  late final ResponseDetails responseDetails;

  AddWorkoutPlanResponse.fromJson(Map<String, dynamic> json) {
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
    required this.userId,
    required this.difficultyLevel,
    required this.title,
    required this.programType,
    required this.completionBadge,
    required this.description,
    required this.assetType,
    required this.assetUrl,
    required this.id,
  });
  late final int userId;
  late final String difficultyLevel;
  late final String title;
  late final String programType;
  late final String completionBadge;
  late final String description;
  late final String assetType;
  late final String assetUrl;
  late final int id;

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    difficultyLevel = json['difficultyLevel'];
    title = json['title'];
    programType = json['programType'];
    completionBadge = json['completionBadge'];
    description = json['description'];
    assetType = json['assetType'];
    assetUrl = json['assetUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['difficultyLevel'] = difficultyLevel;
    _data['title'] = title;
    _data['programType'] = programType;
    _data['completionBadge'] = completionBadge;
    _data['description'] = description;
    _data['assetType'] = assetType;
    _data['assetUrl'] = assetUrl;
    _data['id'] = id;
    return _data;
  }
}
