class WorkoutPrerequisitesListResponse {
  WorkoutPrerequisitesListResponse({
    required this.status,
    required this.responseCode,
    required this.responseDescription,
    required this.responseDetails,
  });
  late final String status;
  late final String responseCode;
  late final String responseDescription;
  late final ResponseDetails responseDetails;

  WorkoutPrerequisitesListResponse.fromJson(Map<String, dynamic> json) {
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
    required this.difficultyLevel,
    required this.programType,
    required this.completionBadge,
  });
  late final DifficultyLevel difficultyLevel;
  late final ProgramType programType;
  late final List<CompletionBadge> completionBadge;

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    difficultyLevel = DifficultyLevel.fromJson(json['difficultyLevel']);
    programType = ProgramType.fromJson(json['programType']);
    completionBadge = List.from(json['completionBadge'])
        .map((e) => CompletionBadge.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['difficultyLevel'] = difficultyLevel.toJson();
    _data['programType'] = programType.toJson();
    _data['completionBadge'] = completionBadge.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DifficultyLevel {
  DifficultyLevel({
    required this.easy,
    required this.medium,
    required this.intermediate,
    required this.hard,
    required this.expert,
  });
  late final String easy;
  late final String medium;
  late final String intermediate;
  late final String hard;
  late final String expert;

  DifficultyLevel.fromJson(Map<String, dynamic> json) {
    easy = json['easy'];
    medium = json['medium'];
    intermediate = json['intermediate'];
    hard = json['hard'];
    expert = json['expert'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['easy'] = easy;
    _data['medium'] = medium;
    _data['intermediate'] = intermediate;
    _data['hard'] = hard;
    _data['expert'] = expert;
    return _data;
  }
}

class ProgramType {
  ProgramType({
    required this.free,
    required this.paid,
  });
  late final String free;
  late final String paid;

  ProgramType.fromJson(Map<String, dynamic> json) {
    free = json['free'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['free'] = free;
    _data['paid'] = paid;
    return _data;
  }
}

class CompletionBadge {
  CompletionBadge({
    required this.badgeId,
    required this.title,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    this.updatedAt,
  });
  late final int badgeId;
  late final String title;
  late final int isActive;
  late final int createdBy;
  late final String createdAt;
  late final String? updatedAt;

  CompletionBadge.fromJson(Map<String, dynamic> json) {
    badgeId = json['badgeId'];
    title = json['title'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['badgeId'] = badgeId;
    _data['title'] = title;
    _data['isActive'] = isActive;
    _data['createdBy'] = createdBy;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
