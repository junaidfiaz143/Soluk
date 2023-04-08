part of 'community_follow_bloc.dart';

@immutable
abstract class CommunityFollowBlocState {
  final FriendsModel? friendsModel;
  const CommunityFollowBlocState({this.friendsModel});
}

class CommunityFollowBlocInitial extends CommunityFollowBlocState {}

class CommunityFollowBlocLoading extends CommunityFollowBlocState {
  const CommunityFollowBlocLoading() : super();
}

class CommunityFollowBlocEmpty extends CommunityFollowBlocState {
  const CommunityFollowBlocEmpty() : super();
}

class CommunityFollowBlocData extends CommunityFollowBlocState {
  const CommunityFollowBlocData({FriendsModel? friendsModel}) : super(friendsModel: friendsModel);
}

