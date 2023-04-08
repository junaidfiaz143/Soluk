import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';

import '../../../../models/my_workout_response.dart';
import 'my_workout_provider.dart';

class MyWorkoutRepository {
  Future<MyWorkoutResponse?> getMyWorkoutList() async {
    MyWorkoutProvider myWorkoutProvider = MyWorkoutProvider();
    return myWorkoutProvider.getMyWorkoutList();
  }
}
