class AddExerciseRepsRequestModel {
  AddExerciseRepsRequestModel({
    required this.type,
    required this.title,
    required this.noOfReps,
    required this.dropSet,
  });
  late final String type;
  late final String title;
  late final String noOfReps;
  late final bool dropSet;

  AddExerciseRepsRequestModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    noOfReps = json['noOfReps'];
    dropSet = json['dropSet'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['title'] = title;
    _data['noOfReps'] = noOfReps;
    _data['dropSet'] = dropSet;
    return _data;
  }
}
