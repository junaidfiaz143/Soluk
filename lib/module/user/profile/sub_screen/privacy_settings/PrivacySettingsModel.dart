class PrivacySettingsModel {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  PrivacySettingsModel(
      {this.status,
        this.responseCode,
        this.responseDescription,
        this.responseDetails});

  PrivacySettingsModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? id;
  int? notificationAllow;
  String? language;
  int? accountActive;
  int? allowDirectMessages;
  int? allowBagdes;
  int? allowSocialMediaAccounts;

  ResponseDetails(
      {this.userId,
        this.id,
        this.notificationAllow,
        this.language,
        this.accountActive,
        this.allowDirectMessages,
        this.allowBagdes,
        this.allowSocialMediaAccounts});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    notificationAllow = json['notificationAllow'];
    language = json['language'];
    accountActive = json['accountActive'];
    allowDirectMessages = json['allowDirectMessages'];
    allowBagdes = json['allowBagdes'];
    allowSocialMediaAccounts = json['allowSocialMediaAccounts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['notificationAllow'] = this.notificationAllow;
    data['language'] = this.language;
    data['accountActive'] = this.accountActive;
    data['allowDirectMessages'] = this.allowDirectMessages;
    data['allowBagdes'] = this.allowBagdes;
    data['allowSocialMediaAccounts'] = this.allowSocialMediaAccounts;
    return data;
  }
}
