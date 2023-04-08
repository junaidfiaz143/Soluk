import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';
import 'package:app/module/user/models/my_workout_response.dart';

abstract class MyWorkoutState {
  final MyWorkoutResponse? myWorkoutResponse;

  MyWorkoutState({this.myWorkoutResponse});
}

class MyWorkoutLoadingState extends MyWorkoutState {
  MyWorkoutLoadingState() : super();
}

class MyWorkoutEmptyState extends MyWorkoutState {
  MyWorkoutEmptyState() : super();
}

class MyWorkoutDataLoaded extends MyWorkoutState {
  MyWorkoutDataLoaded(MyWorkoutResponse myWorkoutResponse)
      : super(myWorkoutResponse: myWorkoutResponse);
}
