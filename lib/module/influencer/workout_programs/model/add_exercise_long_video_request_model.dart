import 'dart:io';

class AddExerciseLongVideoRequestModel {
  late final File media;
  late final String assetType;
  late final String workoutTitle;
  late final String description;
  late final String exerciseTime;
  late final String workoutID;
  late final String weekID;
  late final String dayID;

  AddExerciseLongVideoRequestModel(
      {required this.media,
      required this.assetType,
      required this.workoutTitle,
      required this.description,
      required this.exerciseTime,
      required this.workoutID,
      required this.weekID,
      required this.dayID});
}
