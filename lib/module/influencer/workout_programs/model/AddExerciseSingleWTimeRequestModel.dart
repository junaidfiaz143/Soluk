import 'dart:io';

class AddExerciseSingleWTimeRequestModel {
  late final File? media;
  late final String? assetType;
  late final String workoutTitle;
  late final String description;
  final String? exerciseTime;
  late final String restTime;
  late final String workoutID;
  late final String weekID;
  late final String dayID;

  AddExerciseSingleWTimeRequestModel(
      {this.media,
      this.assetType,
      required this.workoutTitle,
      required this.description,
      this.exerciseTime,
      required this.restTime,
      required this.workoutID,
      required this.weekID,
      required this.dayID});
}
