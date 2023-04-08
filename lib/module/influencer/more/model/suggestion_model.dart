class SuggestionsModal {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  SuggestionsModal(
      {this.status,
      this.responseCode,
      this.responseDescription,
      this.responseDetails});

  SuggestionsModal.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  ResponseDetails(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  int? isActive;
  int? fromUser;
  int? toUser;
  String? createdDate;
  String? feedback;
  User? userFeedbackModel;

  Data(
      {this.id,
      this.isActive,
      this.fromUser,
      this.toUser,
      this.createdDate,
      this.userFeedbackModel,
      this.feedback});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['isActive'];
    fromUser = json['fromUser'];
    toUser = json['toUser'];
    createdDate = json['createdDate'];
    userFeedbackModel = json['feed_back_from'] != null
        ? new User.fromJson(json['feed_back_from'])
        : null;
    feedback = json['feedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fromUser'] = this.fromUser;
    data['toUser'] = this.toUser;
    data['createdDate'] = this.createdDate;
    data['feedback'] = this.feedback;
    return data;
  }
}

class UserFeedback {}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

class User {
  int? id;
  String? fullname;
  String? imageUrl;
  String? email;
  String? phone;
  int? roleId;
  String? promoCode;
  String? instagram;
  String? youtube;
  String? otp;
  String? facebook;

  User(
      {this.id,
        this.fullname,
        this.imageUrl,
        this.email,
        this.phone,
        this.roleId,
        this.promoCode,
        this.instagram,
        this.youtube,
        this.otp,
        this.facebook});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    imageUrl = json['imageUrl'];
    email = json['email'];
    phone = json['phone'];
    roleId = json['roleId'];
    promoCode = json['promoCode'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    otp = json['otp'];
    facebook = json['facebook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['imageUrl'] = this.imageUrl;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['roleId'] = this.roleId;
    data['promoCode'] = this.promoCode;
    data['instagram'] = this.instagram;
    data['youtube'] = this.youtube;
    data['otp'] = this.otp;
    data['facebook'] = this.facebook;
    return data;
  }
}

