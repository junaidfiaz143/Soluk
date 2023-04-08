import 'dart:io';

class RoundExerciseRequest {
  final File? media;
  final String? assetType;
  final String? workoutTitle;
  final String? description;
  final String? exerciseTime;
  final String? restTime;
  final String? exerciseType;
  final String? exerciseValue;
  final int? roundId;
  final int? exerciseId;
  final bool? dropSet;
  final String? exerciseCustomValue;
  final bool? isTimeBaseExercise;

  RoundExerciseRequest(
      {this.media,
      this.assetType,
      this.workoutTitle,
      this.description,
      this.exerciseTime,
      this.restTime,
      this.exerciseType,
      this.exerciseValue,
      this.dropSet,
      this.roundId,
      this.exerciseId,
      this.exerciseCustomValue,
      this.isTimeBaseExercise
      });
}
