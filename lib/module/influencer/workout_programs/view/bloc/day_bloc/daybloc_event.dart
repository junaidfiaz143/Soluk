part of 'daybloc_bloc.dart';

@immutable
abstract class DayblocEvent {
  const DayblocEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WorkoutPrerequisitesLoadingEvent extends DayblocEvent {}

class WorkoutPrerequisitesLoadedEvent extends DayblocEvent {}

class ErrorEvent extends DayblocEvent {}

class SetStateEvent extends DayblocEvent {}

class AddWeekBlocEvent extends DayblocEvent {
  AddWorkoutPlanRequestModel addWorkoutPlanRequestModel;

  AddWeekBlocEvent({required this.addWorkoutPlanRequestModel});
}

class AddWorkoutWeekEvent extends DayblocEvent {
  AddWorkoutWeekRequestModel addWorkoutWeekRequestModel;

  AddWorkoutWeekEvent({required this.addWorkoutWeekRequestModel});
}

class AddWorkoutDayEvent extends DayblocEvent {
  AddWorkoutWeekRequestModel addWorkoutWeekRequestModel;

  AddWorkoutDayEvent({required this.addWorkoutWeekRequestModel});
}

class UpdateWorkoutDayEvent extends DayblocEvent {
  AddWorkoutWeekRequestModel addWorkoutWeekRequestModel;

  UpdateWorkoutDayEvent({required this.addWorkoutWeekRequestModel});
}

class AddExerciseLongVideoEvent extends DayblocEvent {
  AddExerciseLongVideoRequestModel addExerciseLongVideoRequestModel;

  AddExerciseLongVideoEvent({required this.addExerciseLongVideoRequestModel});
}

class AddExerciseSingleWTimeEvent extends DayblocEvent {
  AddExerciseSingleWTimeRequestModel addExerciseSingleWTimeRequestModel;
  var workoutSetsList;

  AddExerciseSingleWTimeEvent(
      {required this.addExerciseSingleWTimeRequestModel,
      required this.workoutSetsList});
}

class AddExerciseSingleWFailureEvent extends DayblocEvent {
  AddExerciseSingleWTimeRequestModel addExerciseSingleWTimeRequestModel;
  var workoutSetsList;

  AddExerciseSingleWFailureEvent(
      {required this.addExerciseSingleWTimeRequestModel,
      required this.workoutSetsList});
}

class AddExerciseSingleWRepsEvent extends DayblocEvent {
  AddExerciseSingleWTimeRequestModel addExerciseSingleWTimeRequestModel;
  var workoutSetsList;

  AddExerciseSingleWRepsEvent(
      {required this.addExerciseSingleWTimeRequestModel,
      required this.workoutSetsList});
}

class AddExerciseSingleWCustomEvent extends DayblocEvent {
  AddExerciseSingleWTimeRequestModel addExerciseSingleWTimeRequestModel;
  var workoutSetsList;

  AddExerciseSingleWCustomEvent(
      {required this.addExerciseSingleWTimeRequestModel,
      required this.workoutSetsList});
}

class GetWorkoutProgramsEvent extends DayblocEvent {
  GetWorkoutProgramsEvent();
}

class GetWorkoutWeeksEvent extends DayblocEvent {
  final String id;

  GetWorkoutWeeksEvent({required this.id});
}

class GetWorkoutDaysEvent extends DayblocEvent {
  final String workoutId;
  final String id;

  GetWorkoutDaysEvent({required this.workoutId, required this.id});
}

class GetWorkoutExerciseEvent extends DayblocEvent {
  final String id;

  GetWorkoutExerciseEvent({required this.id});
}

class GetWorkoutProgramsNextBackPageEvent extends DayblocEvent {
  final String pageUrl;

  GetWorkoutProgramsNextBackPageEvent({required this.pageUrl});
}

class GetWorkoutWeeksNextBackPageEvent extends DayblocEvent {
  final String pageUrl;

  GetWorkoutWeeksNextBackPageEvent({required this.pageUrl});
}

class DeleteWorkoutDayEvent extends DayblocEvent {
  final int workoutId;
  final int weekId;
  final int dayId;

  DeleteWorkoutDayEvent(
      {required this.workoutId, required this.weekId, required this.dayId});
}
