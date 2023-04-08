class WorkoutPrerequisitesRequestModel {
  WorkoutPrerequisitesRequestModel({
    required this.load,
  });
  late final List<String> load;

  WorkoutPrerequisitesRequestModel.fromJson(Map<String, dynamic> json) {
    load = List.castFrom<dynamic, String>(json['load']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['load'] = load;
    return _data;
  }
}
