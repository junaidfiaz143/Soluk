import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/module/user/community/bloc/friends/friends_bloc.dart';
import 'package:app/module/user/community/model/friends_model.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../influencer/widgets/empty_screen.dart';
import '../../widgets/community_header_text.dart';
import '../../widgets/tiles/community_friends_tile.dart';
import 'friends_details_view.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FriendsBloc _friendsBloc = BlocProvider.of(context);

    _friendsBloc.getFriendsList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommunityHeaderText('All Friends'),
          Expanded(
            child: BlocBuilder<FriendsBloc, FriendsBlocState>(
                builder: (context, state) {
              {
                if (state is FriendsBlocLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  );
                } else if (state is FriendsBlocEmpty) {
                  return EmptyScreen(
                    title: "No Friends Found",
                    callback: () {},
                    hideAddButton: false,
                  );
                } else if (state is FriendsBlocData) {
                  return RefreshWidget(
                    refreshController: _friendsBloc.refreshController,
                    onRefresh: () => _friendsBloc.onRefresh(),
                    onLoadMore: () => _friendsBloc.onLoadMore(),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 8, bottom: 10),
                      itemCount:
                          state.friendsModel?.responseDetails?.data?.length ??
                              0,
                      itemBuilder: (context, index) {
                        Data item = state
                            .friendsModel!.responseDetails!.data![index]; //user

                        return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _friendsBloc.selectedFriend = item;
                              NavRouter.push(context, FriendsDetailsView(id: _friendsBloc.selectedFriend?.id.toString() ?? "",));
                            },
                            child: CommunityFriendsTile(
                              item: item,
                            ));
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              }
            }),
          )
        ],
      ),
    );
  }
}
