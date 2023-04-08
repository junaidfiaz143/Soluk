class AddExerciseFailureRequestModel {
  AddExerciseFailureRequestModel({
    required this.type,
    required this.title,
  });
  late final String type;
  late String title;

  AddExerciseFailureRequestModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['title'] = title;
    return _data;
  }
}
