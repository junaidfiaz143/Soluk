import 'package:app/module/user/models/my_challenges_response.dart';
import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';
import 'package:app/module/user/models/my_influencers/my_influencers_response.dart';

abstract class MyChallengesState {
  final MyChallengesResponse? myChallengeResponse;

  MyChallengesState({this.myChallengeResponse});
}

class MyChallengesLoadingState extends MyChallengesState {
  MyChallengesLoadingState() : super();
}

class MyChallengesEmptyState extends MyChallengesState {
  MyChallengesEmptyState() : super();
}

class MyChallengesDataLoaded extends MyChallengesState {
  MyChallengesDataLoaded(MyChallengesResponse myChallengesResponse)
      : super(myChallengeResponse: myChallengesResponse);
}
