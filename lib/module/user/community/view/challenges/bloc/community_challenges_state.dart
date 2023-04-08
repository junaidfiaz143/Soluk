part of 'community_challenges_cubit.dart';

@immutable
abstract class CommunityChallengesState {
  final CommunityChallegeModel? myChallengesResponse;

  const CommunityChallengesState({this.myChallengesResponse});
}
class CommunityChallengesInitial extends CommunityChallengesState {}


class CommunityChallengesLoadingState extends CommunityChallengesState {
  const CommunityChallengesLoadingState() : super();
}

class CommunityChallengesEmptyState extends CommunityChallengesState {
  const CommunityChallengesEmptyState() : super();
}

class CommunityChallengesDataLoaded extends CommunityChallengesState {
  const CommunityChallengesDataLoaded(CommunityChallegeModel CommunityChallengesResponse)
      : super(myChallengesResponse: CommunityChallengesResponse);
}
