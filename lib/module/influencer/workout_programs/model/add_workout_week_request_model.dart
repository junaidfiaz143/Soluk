import 'dart:io';

class AddWorkoutWeekRequestModel {
  final File? media;
  final String? assetType;
  late final String workoutTitle;
  late final String description;
  late final int workoutID;
  late final int? weekID;

  AddWorkoutWeekRequestModel(
      {this.media,
      this.assetType,
      required this.workoutTitle,
      required this.description,
      required this.workoutID,
      this.weekID});
}
