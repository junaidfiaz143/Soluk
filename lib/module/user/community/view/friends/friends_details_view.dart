import 'package:app/module/user/community/bloc/friends/friend_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../res/constants.dart';
import '../../../widgets/user_appbar.dart';
import '../../widgets/friends_details_activity_card.dart';
import '../../widgets/friends_details_profile_card.dart';

class FriendsDetailsView extends StatelessWidget {
  final String id;

  const FriendsDetailsView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FriendDetailBloc _friendsBloc = BlocProvider.of(context);
    _friendsBloc.getFriendDetail(id);
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: UserAppbar(
          title: 'Friends',
          hasBackButton: true,
        ),
        body: BlocBuilder<FriendDetailBloc, FriendDetailBlocState>(
            builder: (context, state) {
          if (state is FriendDetailBlocLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          } else if (state is FriendDetailsData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  FriendsDetailsProfileCard(
                      friendDetailModel: state.friendDetailModel!),
                  SizedBox(height: 14),
                  FriendsDetailsActivityCard(
                      friendDetailModel: state.friendDetailModel!),
                ],
              ),
            );
          } else {
            return Container();
          }
        }));
  }
}
