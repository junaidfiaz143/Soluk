import '../../../influencer/workout/model/meals_modal.dart';
import 'dashboard_meals_model.dart';

class RestaurantModel {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  RestaurantModel(
      {this.status,
        this.responseCode,
        this.responseDescription,
        this.responseDetails});

  RestaurantModel.fromJson(Map<String, dynamic> json) {
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
  List<Resturant>? data;
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
      data = <Resturant>[];
      json['data'].forEach((v) {
        data!.add(new Resturant.fromJson(v));
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

class Resturant {
  int? id;
  String? title;
  String? email;
  String? cell;
  String? address;
  String? location;
  String? assetType;
  String? assetUrl;
  int? isActive;
  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  List<Meal>? meals;

  Resturant(
      {this.id,
        this.title,
        this.email,
        this.cell,
        this.address,
        this.location,
        this.assetType,
        this.assetUrl,
        this.isActive,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
        this.meals});

  Resturant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    email = json['email'];
    cell = json['cell'];
    address = json['address'];
    location = json['location'];
    assetType = json['assetType'];
    assetUrl = json['assetUrl'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    if (json['meals'] != null) {
      meals = <Meal>[];
      json['meals'].forEach((v) {
        meals!.add(new Meal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['email'] = this.email;
    data['cell'] = this.cell;
    data['address'] = this.address;
    data['location'] = this.location;
    data['assetType'] = this.assetType;
    data['assetUrl'] = this.assetUrl;
    data['isActive'] = this.isActive;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedDate'] = this.modifiedDate;
    if (this.meals != null) {
      data['meals'] = this.meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/*class Meals {
  int? userId;
  int? id;
  int? resturantId;
  String? imageUrl;
  String? title;
  String? mealType;
  String? mealLevel;
  int? calories;
  int? proteins;
  int? carbs;
  int? fats;
  String? method;

  Meals(
      {this.userId,
        this.id,
        this.resturantId,
        this.imageUrl,
        this.title,
        this.mealType,
        this.mealLevel,
        this.calories,
        this.proteins,
        this.carbs,
        this.fats,
        this.method});

  Meals.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    resturantId = json['resturantId'];
    imageUrl = json['imageUrl'];
    title = json['title'];
    mealType = json['mealType'];
    mealLevel = json['mealLevel'];
    calories = json['calories'];
    proteins = json['proteins'];
    carbs = json['carbs'];
    fats = json['fats'];
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['resturantId'] = this.resturantId;
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    data['mealType'] = this.mealType;
    data['mealLevel'] = this.mealLevel;
    data['calories'] = this.calories;
    data['proteins'] = this.proteins;
    data['carbs'] = this.carbs;
    data['fats'] = this.fats;
    data['method'] = this.method;
    return data;
  }
}*/

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
