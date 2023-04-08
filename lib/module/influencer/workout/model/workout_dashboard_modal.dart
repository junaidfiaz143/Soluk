class WorkoutDashboardModal {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  WorkoutDashboardModal(
      {this.status,
      this.responseCode,
      this.responseDescription,
      this.responseDetails});

  WorkoutDashboardModal.fromJson(Map<String, dynamic> json) {
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
  Workouts? workouts;
  Challenges? challenges;

  ResponseDetails({this.workouts, this.challenges});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    workouts = json['workouts'] != null
        ? new Workouts.fromJson(json['workouts'])
        : null;
    challenges = json['challenges'] != null
        ? new Challenges.fromJson(json['challenges'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workouts != null) {
      data['workouts'] = this.workouts!.toJson();
    }
    if (this.challenges != null) {
        data['challenges'] = this.challenges!.toJson();
    }
    return data;
  }
}

class Workouts {
  var published;
  var unPublished;

  Workouts({this.published, this.unPublished});

  Workouts.fromJson(Map<String, dynamic> json) {
    published = json['Published'];
    unPublished = json['UnPublished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Published'] = this.published;
    data['UnPublished'] = this.unPublished;
    return data;
  }
}

class Challenges {
  var approved;
  var unApproved;

  Challenges({this.approved, this.unApproved});

  Challenges.fromJson(Map<String, dynamic> json) {
    approved = json['Approved'];
    unApproved = json['UnApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Approved'] = this.approved;
    data['UnApproved'] = this.unApproved;
    return data;
  }
}
