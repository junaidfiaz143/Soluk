class BadgesModal {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  BadgesModal(
      {this.status,
      this.responseCode,
      this.responseDescription,
      this.responseDetails});

  BadgesModal.fromJson(Map<String, dynamic> json) {
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
  DifficultyLevel? difficultyLevel;
  ProgramType? programType;
  List<CompletionBadge>? completionBadge;

  ResponseDetails(
      {this.difficultyLevel, this.programType, this.completionBadge});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    difficultyLevel = json['difficultyLevel'] != null
        ? new DifficultyLevel.fromJson(json['difficultyLevel'])
        : null;
    programType = json['programType'] != null
        ? new ProgramType.fromJson(json['programType'])
        : null;
    if (json['completionBadge'] != null) {
      completionBadge = <CompletionBadge>[];
      json['completionBadge'].forEach((v) {
        completionBadge!.add(new CompletionBadge.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.difficultyLevel != null) {
      data['difficultyLevel'] = this.difficultyLevel!.toJson();
    }
    if (this.programType != null) {
      data['programType'] = this.programType!.toJson();
    }
    if (this.completionBadge != null) {
      data['completionBadge'] =
          this.completionBadge!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DifficultyLevel {
  String? easy;
  String? medium;
  String? intermediate;
  String? hard;
  String? expert;

  DifficultyLevel(
      {this.easy, this.medium, this.intermediate, this.hard, this.expert});

  DifficultyLevel.fromJson(Map<String, dynamic> json) {
    easy = json['easy'];
    medium = json['medium'];
    intermediate = json['intermediate'];
    hard = json['hard'];
    expert = json['expert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['easy'] = this.easy;
    data['medium'] = this.medium;
    data['intermediate'] = this.intermediate;
    data['hard'] = this.hard;
    data['expert'] = this.expert;
    return data;
  }
}

class ProgramType {
  String? free;
  String? paid;

  ProgramType({this.free, this.paid});

  ProgramType.fromJson(Map<String, dynamic> json) {
    free = json['free'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['free'] = this.free;
    data['paid'] = this.paid;
    return data;
  }
}

class CompletionBadge {
  int? badgeId;
  String? title;
  int? isActive;
  int? createdBy;
  String? createdAt;
  Null? updatedAt;

  CompletionBadge(
      {this.badgeId,
      this.title,
      this.isActive,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  CompletionBadge.fromJson(Map<String, dynamic> json) {
    badgeId = json['badgeId'];
    title = json['title'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['badgeId'] = this.badgeId;
    data['title'] = this.title;
    data['isActive'] = this.isActive;
    data['createdBy'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
