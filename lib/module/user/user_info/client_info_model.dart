class ClientInfoResponseModel {
  ClientInfoResponseModel({
    this.currentPage,
    required this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Info> data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory ClientInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      ClientInfoResponseModel(
        currentPage: json["current_page"],
        data: List<Info>.from(json["data"].map((x) => Info.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Info {
  Info({
    required this.id,
    required this.userId,
    required this.username,
    required this.dob,
    required this.gender,
    required this.fat,
    required this.height,
    required this.weight,
    required this.goals,
    required this.activeness,
    required this.diet,
    required this.mealPerDay,
    required this.caloriesRange,
    required this.createBy,
    this.modifiedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String? username;
  String? dob;
  String? gender;
  String? fat;
  int height;
  int weight;
  String? goals;
  String? activeness;
  String? diet;
  String? mealPerDay;
  String? caloriesRange;
  int createBy;
  dynamic modifiedBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"],
        userId: json["userId"],
        username: json["username"],
        dob: json["dob"],
        gender: json["gender"],
        fat: json["fat"],
        height: json["height"],
        weight: json["weight"],
        goals: json["goals"],
        activeness: json["activeness"],
        diet: json["diet"],
        mealPerDay: json["mealPerDay"],
        caloriesRange:
            json["caloriesRange"] == null ? "0" : json["caloriesRange"],
        createBy: json["createBy"],
        modifiedBy: json["modifiedBy"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "username": username,
        "dob": dob,
        "gender": gender,
        "fat": fat,
        "height": height,
        "weight": weight,
        "goals": goals,
        "activeness": activeness,
        "diet": diet,
        "mealPerDay": mealPerDay,
        "caloriesRange": caloriesRange,
        "createBy": createBy,
        "modifiedBy": modifiedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
