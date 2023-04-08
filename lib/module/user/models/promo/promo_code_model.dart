class PromoCodeModel {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  PromoCodeModel(
      {this.status,
      this.responseCode,
      this.responseDescription,
      this.responseDetails});

  PromoCodeModel.fromJson(Map<String, dynamic> json) {
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
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
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
  String? code;
  String? name;
  String? description;
  Null? uses;
  int? maxUses;
  int? maxUsesUser;
  String? type;
  int? price;
  int? discountAmount;
  int? isFixed;
  String? startsAt;
  String? expiresAt;
  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;

  Data(
      {this.id,
      this.code,
      this.name,
      this.description,
      this.uses,
      this.maxUses,
      this.maxUsesUser,
      this.type,
      this.price,
      this.discountAmount,
      this.isFixed,
      this.startsAt,
      this.expiresAt,
      this.createdBy,
      this.createdDate,
      this.modifiedBy,
      this.modifiedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    uses = json['uses'];
    maxUses = json['max_uses'];
    maxUsesUser = json['max_uses_user'];
    type = json['type'];
    price = json['price'];
    discountAmount = json['discount_amount'];
    isFixed = json['is_fixed'];
    startsAt = json['starts_at'];
    expiresAt = json['expires_at'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['uses'] = this.uses;
    data['max_uses'] = this.maxUses;
    data['max_uses_user'] = this.maxUsesUser;
    data['type'] = this.type;
    data['price'] = this.price;
    data['discount_amount'] = this.discountAmount;
    data['is_fixed'] = this.isFixed;
    data['starts_at'] = this.startsAt;
    data['expires_at'] = this.expiresAt;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedDate'] = this.modifiedDate;
    return data;
  }
}

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
