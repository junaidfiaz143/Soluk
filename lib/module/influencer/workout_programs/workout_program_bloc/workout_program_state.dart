part of 'workout_program_bloc.dart';

abstract class WorkoutProgramState {}

class AddWorkoutLoadingState extends WorkoutProgramState {}

class WorkoutPrerequisitesLoadedState extends WorkoutProgramState {
  WorkoutPrerequisitesListResponse workoutPrerequisitesListResponse;
  WorkoutPrerequisitesLoadedState(
      {required this.workoutPrerequisitesListResponse});

  //List<Subscribers> get subscribersList => _subscribersList;
}

class AddWorkoutProgramState extends WorkoutProgramState {
  AddWorkoutPlanResponse addWorkoutPlanResponse;
  AddWorkoutProgramState({required this.addWorkoutPlanResponse});
}

class UpdateWorkoutProgramState extends WorkoutProgramState {
  UpdateWorkoutProgramResponse updateWorkoutProgramResponse;
  UpdateWorkoutProgramState({required this.updateWorkoutProgramResponse});
}

class AddWorkoutWeekState extends WorkoutProgramState {
  AddWorkoutWeekResponse addWorkoutWeekResponse;
  AddWorkoutWeekState({required this.addWorkoutWeekResponse});
}

class AddWorkoutDayState extends WorkoutProgramState {
  AddWorkoutDayResponse addWorkoutDayResponse;
  AddWorkoutDayState({required this.addWorkoutDayResponse});
}

class AddExerciseLongVideoState extends WorkoutProgramState {
  AddExerciseLongVideoResponse addExerciseLongVideoResponse;
  AddExerciseLongVideoState({required this.addExerciseLongVideoResponse});
}

class AddExerciseSingleWorkoutTState extends WorkoutProgramState {
  AddExerciseSingleWorkoutTResponse addExerciseSingleWorkoutTResponse;
  AddExerciseSingleWorkoutTState(
      {required this.addExerciseSingleWorkoutTResponse});
}

class GetWorkoutProgramsState extends WorkoutProgramState {
  GetWorkoutPlansResponse getWorkoutPlansResponse;
  GetWorkoutProgramsState({required this.getWorkoutPlansResponse});
}
class RefreshWorkoutProgramsState extends WorkoutProgramState {
  int? id;
  RefreshWorkoutProgramsState(this.id);
}

class GetWorkoutWeeksState extends WorkoutProgramState {
  GetWorkoutAllWeeksResponse getWorkoutAllWeeksResponse;
  GetWorkoutWeeksState({required this.getWorkoutAllWeeksResponse});
}

class GetWorkoutWeeksAllDaysState extends WorkoutProgramState {
  GetWeekAllDaysWorkoutsResponse getWeekAllDaysWorkoutsResponse;
  GetWorkoutWeeksAllDaysState({required this.getWeekAllDaysWorkoutsResponse});
}

class GetWorkoutExerciseState extends WorkoutProgramState {
  GetAllExerciseResponse getAllExerciseResponse;
  GetWorkoutExerciseState({required this.getAllExerciseResponse});
}

class LoadingState extends WorkoutProgramState {}

class SetStateState extends WorkoutProgramState {}

class ErrorState extends WorkoutProgramState {
  final String error;
  ErrorState({required this.error});
}

class InternetErrorState extends WorkoutProgramState {
  final String error;
  InternetErrorState({required this.error});
}
