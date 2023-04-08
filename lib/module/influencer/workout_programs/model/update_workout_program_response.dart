class UpdateWorkoutProgramResponse {
  UpdateWorkoutProgramResponse({
    required this.status,
    required this.responseCode,
    required this.responseDescription,
    required this.responseDetails,
  });

  late final String status;
  late final String responseCode;
  late final String responseDescription;
  late final ResponseDetails responseDetails;

  UpdateWorkoutProgramResponse.fromJson(Map<String, dynamic> json) {
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
    required this.id,
    required this.assetType,
    required this.assetUrl,
    required this.title,
    required this.difficultyLevel,
    required this.programType,
    required this.completionBadge,
    required this.description,
    required this.isActive,
  });

  late final int userId;
  late final int id;
  late final String assetType;
  late final String assetUrl;
  late final String title;
  late final String difficultyLevel;
  late final String programType;
  late final int completionBadge;
  late final String description;
  late final int isActive;

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    assetType = json['assetType'];
    assetUrl = json['assetUrl'];
    title = json['title'];
    difficultyLevel = json['difficultyLevel'];
    programType = json['programType'];
    if (json['completionBadge'] is String) {
      completionBadge = int.parse(json['completionBadge']);
    } else {
      completionBadge = json['completionBadge'];
    }
    description = json['description'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['id'] = id;
    _data['assetType'] = assetType;
    _data['assetUrl'] = assetUrl;
    _data['title'] = title;
    _data['difficultyLevel'] = difficultyLevel;
    _data['programType'] = programType;
    _data['completionBadge'] = completionBadge;
    _data['description'] = description;
    _data['isActive'] = isActive;
    return _data;
  }
}
