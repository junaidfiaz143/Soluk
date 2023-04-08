class SocialLinksModal {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  SocialLinksModal(
      {this.status,
      this.responseCode,
      this.responseDescription,
      this.responseDetails});

  SocialLinksModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    responseDescription = json['responseDescription'];
    responseDetails = json['responseDetails'] != null
        ? ResponseDetails.fromJson(json['responseDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['responseCode'] = responseCode;
    data['responseDescription'] = responseDescription;
    if (responseDetails != null) {
      data['responseDetails'] = responseDetails!.toJson();
    }
    return data;
  }
}

class ResponseDetails {
  String? facebook;
  String? instagram;
  String? youtube;
  String? snapchat;

  ResponseDetails({this.facebook, this.instagram, this.youtube, this.snapchat});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    snapchat = json['snapchat'];
  }

  bool isEmptyOrNull() {
    return ((facebook == null || facebook == "") &&
        (instagram == null || instagram == "") &&
        (youtube == null || youtube == "") &&
        (snapchat == null || snapchat == ""));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['youtube'] = youtube;
    data['snapchat'] = snapchat;
    return data;
  }
}
