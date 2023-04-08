import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/model/rounds_response.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CircuitWorkOutState {
  const CircuitWorkOutState();
}

class ExerciseInitial extends CircuitWorkOutState {}

class ExerciseLoading extends CircuitWorkOutState {
  const ExerciseLoading() : super();
}

class ExerciseLoaded extends CircuitWorkOutState {
  final Data? data;
  const ExerciseLoaded({this.data});
}

class RoundsLoaded extends CircuitWorkOutState {
  final List<RoundsData>? roundsList;
  const RoundsLoaded({this.roundsList});
}

class ExerciseError extends CircuitWorkOutState {
  final String? message;
  const ExerciseError({this.message});
}

class RoundExerciseLoaded extends CircuitWorkOutState {
  final GetAllExerciseResponse? data;
  const RoundExerciseLoaded({this.data});
}

class RestTimeAddedState extends CircuitWorkOutState {
  const RestTimeAddedState();
}

class ExerciseCountState extends CircuitWorkOutState {
  const ExerciseCountState(int exerciseCount);
}
