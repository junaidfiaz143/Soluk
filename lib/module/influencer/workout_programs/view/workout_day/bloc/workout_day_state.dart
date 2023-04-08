import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart';
import 'package:flutter/material.dart';

@immutable
abstract class WorkOutDayState {
  final GetAllExerciseResponse? exerciseResponse;
  const WorkOutDayState({this.exerciseResponse});
}

class WorkOutDayInitial extends WorkOutDayState {}

class WorkOutDayLoading extends WorkOutDayState {
  const WorkOutDayLoading() : super();
}

class WorkOutDayEmpty extends WorkOutDayState {
  const WorkOutDayEmpty() : super();
}

class WorkOutDayLoaded extends WorkOutDayState {
  const WorkOutDayLoaded({GetAllExerciseResponse? data}) : super(exerciseResponse: data);
}

class WorkOutDayError extends WorkOutDayState {}
