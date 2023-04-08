class AddExerciseCustomRequestModel {
  AddExerciseCustomRequestModel({
    required this.type,
    required this.title,
    required this.exerciseType,
    required this.count,
  });
  late final String type;
  late final String title;
  late final String exerciseType;
  late final int count;

  AddExerciseCustomRequestModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    exerciseType = json['exerciseType'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['title'] = title;
    _data['exerciseType'] = exerciseType;
    _data['count'] = count;
    return _data;
  }
}
