part of 'workout_program_bloc.dart';

abstract class WorkoutProgramEvent extends Equatable {
  const WorkoutProgramEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WorkoutPrerequisitesLoadingEvent extends WorkoutProgramEvent {}

class WorkoutPrerequisitesLoadedEvent extends WorkoutProgramEvent {}

class ErrorEvent extends WorkoutProgramEvent {}

class SetStateEvent extends WorkoutProgramEvent {}

class AddWorkoutProgramEvent extends WorkoutProgramEvent {
  AddWorkoutPlanRequestModel addWorkoutPlanRequestModel;
  AddWorkoutProgramEvent({required this.addWorkoutPlanRequestModel});
}

class AddWorkoutWeekEvent extends WorkoutProgramEvent {
  AddWorkoutWeekRequestModel addWorkoutWeekRequestModel;
  AddWorkoutWeekEvent({required this.addWorkoutWeekRequestModel});
}

class AddWorkoutDayEvent extends WorkoutProgramEvent {
  AddWorkoutWeekRequestModel addWorkoutWeekRequestModel;
  AddWorkoutDayEvent({required this.addWorkoutWeekRequestModel});
}

class AddExerciseLongVideoEvent extends WorkoutProgramEvent {
  AddExerciseLongVideoRequestModel addExerciseLongVideoRequestModel;
  AddExerciseLongVideoEvent({required this.addExerciseLongVideoRequestModel});
}

class AddExerciseSingleWTimeEvent extends WorkoutProgramEvent {
  AddExerciseSingleWTimeRequestModel addExerciseSingleWTimeRequestModel;
  var workoutSetsList;
  AddExerciseSingleWTimeEvent(
      {required this.addExerciseSingleWTimeRequestModel,
      required this.workoutSetsList});
}

class AddExerciseSingleWFailureEvent extends WorkoutProgramEvent {
  AddExerciseSingleWTimeRequestModel addExerciseSingleWTimeRequestModel;
  var workoutSetsList;
  AddExerciseSingleWFailureEvent(
      {required this.addExerciseSingleWTimeRequestModel,
      required this.workoutSetsList});
}

class AddExerciseSingleWRepsEvent extends WorkoutProgramEvent {
  AddExerciseSingleWTimeRequestModel addExerciseSingleWTimeRequestModel;
  var workoutSetsList;
  AddExerciseSingleWRepsEvent(
      {required this.addExerciseSingleWTimeRequestModel,
      required this.workoutSetsList});
}

class AddExerciseSingleWCustomEvent extends WorkoutProgramEvent {
  AddExerciseSingleWTimeRequestModel addExerciseSingleWTimeRequestModel;
  var workoutSetsList;
  AddExerciseSingleWCustomEvent(
      {required this.addExerciseSingleWTimeRequestModel,
      required this.workoutSetsList});
}

class GetWorkoutProgramsEvent extends WorkoutProgramEvent {
  int? pageNumber;
  GetWorkoutProgramsEvent({this.pageNumber});
}

class DeleteWorkoutProgramsEvent extends WorkoutProgramEvent {
  int? workoutProgramId;
  DeleteWorkoutProgramsEvent({this.workoutProgramId});
}

class GetWorkoutWeeksEvent extends WorkoutProgramEvent {
  final String id;
  GetWorkoutWeeksEvent({required this.id});
}

class GetWorkoutDaysEvent extends WorkoutProgramEvent {
  final String workoutId;
  final String id;
  GetWorkoutDaysEvent({required this.workoutId, required this.id});
}

class GetWorkoutExerciseEvent extends WorkoutProgramEvent {
  final String id;
  GetWorkoutExerciseEvent({required this.id});
}

class GetWorkoutProgramsNextBackPageEvent extends WorkoutProgramEvent {
  final String pageUrl;
  GetWorkoutProgramsNextBackPageEvent({required this.pageUrl});
}

class GetWorkoutWeeksNextBackPageEvent extends WorkoutProgramEvent {
  final String pageUrl;
  GetWorkoutWeeksNextBackPageEvent({required this.pageUrl});
}
