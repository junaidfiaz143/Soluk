import 'package:app/module/user/community/view/challenges/data/community_challenges_provider.dart';
import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';
import 'package:app/module/user/profile/sub_screen/my_challenges/data/my_challenges_provider.dart';

class CommunityChallengesRepository {
  CommunityChallengesProvider communityChallengesProvider = CommunityChallengesProvider();

  Future<dynamic> getCommunityChallengesList() async {
    return communityChallengesProvider.getCommunityChallengesList();
  }
}
