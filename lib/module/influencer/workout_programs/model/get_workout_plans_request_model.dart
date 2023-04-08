class GetWorkoutPlansRequestModel {
  GetWorkoutPlansRequestModel({
    required this.limit,
    required this.pageNumber,
  });
  late final int limit;
  late final int pageNumber;

  GetWorkoutPlansRequestModel.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    pageNumber = json['pageNumber'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['limit'] = limit;
    _data['pageNumber'] = pageNumber;
    return _data;
  }
}
