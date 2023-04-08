part of 'week_bloc_bloc.dart';

@immutable
abstract class WeekBlocEvent extends Equatable {
  const WeekBlocEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WorkoutPrerequisitesLoadingEvent extends WeekBlocEvent {}

class WorkoutPrerequisitesLoadedEvent extends WeekBlocEvent {}

class ErrorEvent extends WeekBlocEvent {}

class SetStateEvent extends WeekBlocEvent {}

class AddWeekBlocEvent extends WeekBlocEvent {
  AddWorkoutPlanRequestModel addWorkoutPlanRequestModel;
  AddWeekBlocEvent({required this.addWorkoutPlanRequestModel});
}

class AddWorkoutWeekEvent extends WeekBlocEvent {
  AddWorkoutWeekRequestModel addWorkoutWeekRequestModel;
  AddWorkoutWeekEvent({required this.addWorkoutWeekRequestModel});
}

class AddWorkoutDayEvent extends WeekBlocEvent {
  AddWorkoutWeekRequestModel addWorkoutWeekRequestModel;
  AddWorkoutDayEvent({required this.addWorkoutWeekRequestModel});
}

class AddExerciseLongVideoEvent extends WeekBlocEvent {
  AddExerciseLongVideoRequestModel addExerciseLongVideoRequestModel;
  AddExerciseLongVideoEvent({required this.addExerciseLongVideoRequestModel});
}

class AddExerciseSingleWTimeEvent extends WeekBlocEvent {
  AddExerciseSingleWTimeRequestModel addExerciseSingleWTimeRequestModel;
  var workoutSetsList;
  AddExerciseSingleWTimeEvent(
      {required this.addExerciseSingleWTimeRequestModel,
      required this.workoutSetsList});
}

class AddExerciseSingleWFailureEvent extends WeekBlocEvent {
  AddExerciseSingleWTimeRequestModel addExerciseSingleWTimeRequestModel;
  var workoutSetsList;
  AddExerciseSingleWFailureEvent(
      {required this.addExerciseSingleWTimeRequestModel,
      required this.workoutSetsList});
}

class AddExerciseSingleWRepsEvent extends WeekBlocEvent {
  AddExerciseSingleWTimeRequestModel addExerciseSingleWTimeRequestModel;
  var workoutSetsList;
  AddExerciseSingleWRepsEvent(
      {required this.addExerciseSingleWTimeRequestModel,
      required this.workoutSetsList});
}

class AddExerciseSingleWCustomEvent extends WeekBlocEvent {
  AddExerciseSingleWTimeRequestModel addExerciseSingleWTimeRequestModel;
  var workoutSetsList;
  AddExerciseSingleWCustomEvent(
      {required this.addExerciseSingleWTimeRequestModel,
      required this.workoutSetsList});
}

class GetWorkoutProgramsEvent extends WeekBlocEvent {
  GetWorkoutProgramsEvent();
}

class GetWorkoutWeeksEvent extends WeekBlocEvent {
  final String id;
  GetWorkoutWeeksEvent({required this.id});
}

class GetWorkoutDaysEvent extends WeekBlocEvent {
  final String workoutId;
  final String id;
  GetWorkoutDaysEvent({required this.workoutId, required this.id});
}

class GetWorkoutExerciseEvent extends WeekBlocEvent {
  final String id;
  GetWorkoutExerciseEvent({required this.id});
}

class GetWorkoutProgramsNextBackPageEvent extends WeekBlocEvent {
  final String pageUrl;
  GetWorkoutProgramsNextBackPageEvent({required this.pageUrl});
}

class GetWorkoutWeeksNextBackPageEvent extends WeekBlocEvent {
  final String pageUrl;
  GetWorkoutWeeksNextBackPageEvent({required this.pageUrl});
}
