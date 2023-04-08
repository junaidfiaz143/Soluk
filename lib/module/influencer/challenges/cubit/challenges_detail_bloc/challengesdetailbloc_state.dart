part of 'challengesdetailbloc_cubit.dart';

@immutable
abstract class ChallengesdetailblocState {
  final ChallengesDetailsModal? blogDetailData;
  const ChallengesdetailblocState({this.blogDetailData});
}

class ChallengesdetailblocInitial extends ChallengesdetailblocState {}
class ChallengesDetailEmpty extends ChallengesdetailblocState {
  const ChallengesDetailEmpty():super();
}
class ChallengesDetailsLoading extends ChallengesdetailblocState {
  const ChallengesDetailsLoading():super();
}
class ChallengesDetailsLoaded extends ChallengesdetailblocState {
  const ChallengesDetailsLoaded({ChallengesDetailsModal? challengesModal}):super(blogDetailData: challengesModal);
}