import 'dart:io';

class AddWorkoutPlanRequestModel {
  late final File? media;
  late final String? assetType;
  late final String workoutTitle;
  late final String difficultyLevel;
  late final String programType;
  late final String completionBadgeId;
  late final String description;
  late bool isEditing = false;
  late final int? workoutProgramID;
  String rejection_reason="";
  int isActive;

  AddWorkoutPlanRequestModel({required this.media,
    required this.assetType,
    required this.workoutTitle,
    required this.difficultyLevel,
    required this.programType,
    this.rejection_reason="",
    this.isActive=0,
    required this.completionBadgeId,
    required this.description,
    required this.isEditing,
    this.workoutProgramID});


}

