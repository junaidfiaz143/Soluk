import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ExerciseState {
  final GetAllExerciseResponse? exerciseResponse;
  const ExerciseState({this.exerciseResponse});
}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoading extends ExerciseState {
  const ExerciseLoading() : super();
}

class ExerciseLoaded extends ExerciseState {
  const ExerciseLoaded({GetAllExerciseResponse? data}) : super(exerciseResponse: data);
}

class ExerciseError extends ExerciseState {}
