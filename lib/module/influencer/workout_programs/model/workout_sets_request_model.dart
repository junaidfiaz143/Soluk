class WorkoutSetsRequestModel {
  WorkoutSetsRequestModel(
      {required this.type,
      required this.title,
      required this.setTime,
      this.setTimeMins});
  late final String type;
  late String title;
  late final String setTime;
  String? setTimeMins;

  WorkoutSetsRequestModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    setTime = json['setTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['title'] = title;
    _data['setTime'] = setTime;
    return _data;
  }
}
