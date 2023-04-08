class GetWorkoutAllWeeksResponse {
  GetWorkoutAllWeeksResponse({
    required this.status,
    required this.responseCode,
    required this.responseDescription,
    required this.responseDetails,
  });
  late final String status;
  late final String responseCode;
  late final String responseDescription;
  late final ResponseDetails responseDetails;

  GetWorkoutAllWeeksResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    responseDescription = json['responseDescription'];
    responseDetails = ResponseDetails.fromJson(json['responseDetails']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['responseCode'] = responseCode;
    _data['responseDescription'] = responseDescription;
    _data['responseDetails'] = responseDetails.toJson();
    return _data;
  }
}

class ResponseDetails {
  ResponseDetails({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });
  late final int currentPage;
  late final List<Data> data;
  late final String firstPageUrl;
  late final int from;
  late final int lastPage;
  late final String lastPageUrl;
  late final List<Links> links;
  late final String nextPageUrl;
  late final String path;
  late final int perPage;
  late final String prevPageUrl;
  late final int to;
  late final int total;

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    firstPageUrl = json['first_page_url'] ?? '';
    from = json['from'] ?? 0;
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'] ?? '';
    links = List.from(json['links']).map((e) => Links.fromJson(e)).toList();
    nextPageUrl = json['next_page_url'] ?? '';
    path = json['path'] ?? '';
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'] ?? '';
    to = json['to'] ?? 0;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['first_page_url'] = firstPageUrl;
    _data['from'] = from;
    _data['last_page'] = lastPage;
    _data['last_page_url'] = lastPageUrl;
    _data['links'] = links.map((e) => e.toJson()).toList();
    _data['next_page_url'] = nextPageUrl;
    _data['path'] = path;
    _data['per_page'] = perPage;
    _data['prev_page_url'] = prevPageUrl;
    _data['to'] = to;
    _data['total'] = total;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.workoutPlanId,
    required this.userId,
    required this.assetType,
    required this.assetUrl,
    required this.title,
    required this.description,
  });
  late final int id;
  late final int workoutPlanId;
  late final int userId;
  late final String assetType;
  late final String assetUrl;
  late final String title;
  late final String description;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workoutPlanId = json['workoutPlanId'];
    userId = json['userId'];
    assetType = json['assetType'];
    assetUrl = json['assetUrl'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['workoutPlanId'] = workoutPlanId;
    _data['userId'] = userId;
    _data['assetType'] = assetType;
    _data['assetUrl'] = assetUrl;
    _data['title'] = title;
    _data['description'] = description;
    return _data;
  }
}

class Links {
  Links({
    required this.url,
    required this.label,
    required this.active,
  });
  late final String url;
  late final String label;
  late final bool active;

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'] ?? '';
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['label'] = label;
    _data['active'] = active;
    return _data;
  }
}
