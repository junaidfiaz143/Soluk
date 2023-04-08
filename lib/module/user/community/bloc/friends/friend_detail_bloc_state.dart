part of 'friend_detail_bloc.dart';

@immutable
abstract class FriendDetailBlocState {
  final FriendDetailModel? friendDetailModel;
  const FriendDetailBlocState({this.friendDetailModel});
}

class FriendsBlocInitial extends FriendDetailBlocState {}

class FriendDetailBlocLoading extends FriendDetailBlocState {
  const FriendDetailBlocLoading() : super();
}

class FriendDetailsData extends FriendDetailBlocState {
  const FriendDetailsData({FriendDetailModel? friendDetailModel}) : super(friendDetailModel: friendDetailModel);
}
