class BankInfoModel {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  BankInfoModel(
      {this.status,
        this.responseCode,
        this.responseDescription,
        this.responseDetails});

  BankInfoModel.fromJson(Map<String, dynamic> json) {
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
  String? imageUrl;
  String? workTitle;
  String? intro;
  String? goals;
  String? credentials;
  String? requirements;
  int? rating;
  String? assetType;
  String? introUrl;
  String? beneficiaryName;
  String? bankName;
  String? bankAddress;
  String? bankAccountNumber;
  String? bankAccountIBAN;
  String? bIC;
  String? swift;

  ResponseDetails(
      {this.userId,
        this.id,
        this.imageUrl,
        this.workTitle,
        this.intro,
        this.goals,
        this.credentials,
        this.requirements,
        this.rating,
        this.assetType,
        this.introUrl,
        this.beneficiaryName,
        this.bankName,
        this.bankAddress,
        this.bankAccountNumber,
        this.bankAccountIBAN,
        this.bIC,
        this.swift});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    workTitle = json['workTitle'];
    intro = json['intro'];
    goals = json['goals'];
    credentials = json['credentials'];
    requirements = json['requirements'];
    rating = json['rating'];
    assetType = json['assetType'];
    introUrl = json['introUrl'];
    beneficiaryName = json['beneficiary_name'];
    bankName = json['bank_name'];
    bankAddress = json['bank_address'];
    bankAccountNumber = json['bank_account_number'];
    bankAccountIBAN = json['bank_account_IBAN'];
    bIC = json['BIC'];
    swift = json['swift'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['workTitle'] = this.workTitle;
    data['intro'] = this.intro;
    data['goals'] = this.goals;
    data['credentials'] = this.credentials;
    data['requirements'] = this.requirements;
    data['rating'] = this.rating;
    data['assetType'] = this.assetType;
    data['introUrl'] = this.introUrl;
    data['beneficiary_name'] = this.beneficiaryName;
    data['bank_name'] = this.bankName;
    data['bank_address'] = this.bankAddress;
    data['bank_account_number'] = this.bankAccountNumber;
    data['bank_account_IBAN'] = this.bankAccountIBAN;
    data['BIC'] = this.bIC;
    data['swift'] = this.swift;
    return data;
  }
}