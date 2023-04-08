import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SingleWorkOutState {
  final GetAllExerciseResponse? exerciseResponse;
  const SingleWorkOutState({this.exerciseResponse});
}

class ExerciseInitial extends SingleWorkOutState {}

class ExerciseLoading extends SingleWorkOutState {
  const ExerciseLoading() : super();
}

class ExerciseLoaded extends SingleWorkOutState {
  const ExerciseLoaded({GetAllExerciseResponse? data}) : super(exerciseResponse: data);
}

class ExerciseError extends SingleWorkOutState {}
