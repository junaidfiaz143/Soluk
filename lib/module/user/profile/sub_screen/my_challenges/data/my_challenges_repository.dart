import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';
import 'package:app/module/user/profile/sub_screen/my_challenges/data/my_challenges_provider.dart';

import '../../../../models/my_challenges_response.dart';

class MyChallengesRepository {
  MyChallengesProvider myChallengesProvider = MyChallengesProvider();

  Future<MyChallengesResponse?> getMyChallengesList() async {
    return myChallengesProvider.getMyWorkoutList();
  }
}
