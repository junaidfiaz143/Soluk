part of 'friends_bloc.dart';

@immutable
abstract class FriendsBlocState {
  final FriendsModel? friendsModel;
  final FriendDetailModel? friendDetailModel;
  const FriendsBlocState({this.friendsModel,this.friendDetailModel});
}

class FriendsBlocInitial extends FriendsBlocState {}

class FriendsBlocLoading extends FriendsBlocState {
  const FriendsBlocLoading() : super();
}

class FriendsBlocEmpty extends FriendsBlocState {
  const FriendsBlocEmpty() : super();
}

class FriendsBlocData extends FriendsBlocState {
  const FriendsBlocData({FriendsModel? friendsModel}) : super(friendsModel: friendsModel);
}

