class PromoCodeModal {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  PromoCodeModal(
      {this.status,
      this.responseCode,
      this.responseDescription,
      this.responseDetails});

  PromoCodeModal.fromJson(Map<String, dynamic> json) {
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
  String? promoCode;

  ResponseDetails({this.promoCode});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    promoCode = json['promoCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promoCode'] = this.promoCode;
    return data;
  }
}
