part of 'challengesbloc_cubit.dart';

@immutable
abstract class ChallengesblocState {
  final ChallengesModal? challengeData;
  final bool? approveEmpty;
  final bool? disApproveEmpty;
  final bool? isOnlyApprovedChallenges;

  const ChallengesblocState(
      {this.challengeData,
      this.approveEmpty = false,
      this.disApproveEmpty,
      this.isOnlyApprovedChallenges});
}

class ChallengesblocInitial extends ChallengesblocState {}

class ChallengesEmpty extends ChallengesblocState {
  const ChallengesEmpty() : super();
}

class ChallengesLoading extends ChallengesblocState {
  const ChallengesLoading() : super();
}

class ChallengesLoaded extends ChallengesblocState {
  const ChallengesLoaded(
      {ChallengesModal? challengesModal,
      bool? approveEmpty,
      bool? isOnlyApprovedChallenges,
      bool? disApproveEmpty})
      : super(
            challengeData: challengesModal,
            approveEmpty: approveEmpty,
            isOnlyApprovedChallenges: isOnlyApprovedChallenges,
            disApproveEmpty: disApproveEmpty);
}
