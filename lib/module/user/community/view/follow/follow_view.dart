import 'package:app/module/user/community/bloc/friends/community_follow_bloc.dart';
import 'package:app/module/user/community/model/friends_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../influencer/widgets/empty_screen.dart';
import '../../../../influencer/workout/widgets/components/refresh_widget.dart';
import '../../widgets/community_header_text.dart';
import '../../widgets/tiles/community_follow_tile.dart';

class FollowView extends StatelessWidget {
  const FollowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommunityFollowBloc _communityFollowBloc = BlocProvider.of(context);
    _communityFollowBloc.getFriendsList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommunityHeaderText('Soluk Friends'),
          TextField(
            cursorColor: Colors.grey,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              _communityFollowBloc.getFriendsList(searchingText: value);
            },
            onChanged: (value) {
              if (value == '') _communityFollowBloc.getFriendsList();
            },
            decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                    fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                filled: true,
                fillColor: Color(0xffE6E6E6),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                border: _outlineInputBorder,
                isDense: true,
                disabledBorder: _outlineInputBorder,
                enabledBorder: _outlineInputBorder,
                focusedBorder: _outlineInputBorder),
          ),
          SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<CommunityFollowBloc, CommunityFollowBlocState>(
                builder: (context, state) {
              if (state is CommunityFollowBlocLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              } else if (state is CommunityFollowBlocEmpty) {
                return EmptyScreen(
                  title: "No Users Found",
                  callback: () {},
                  hideAddButton: true,
                );
              } else if (state is CommunityFollowBlocData) {
                return RefreshWidget(
                  refreshController: _communityFollowBloc.refreshController,
                  onRefresh: () => _communityFollowBloc.onRefresh(),
                  onLoadMore: () => _communityFollowBloc.onLoadMore(),
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 12, bottom: 10),
                    itemCount:
                        state.friendsModel?.responseDetails?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      Data item =
                          state.friendsModel!.responseDetails!.data![index];
                      return CommunityFollowTile(
                        item: item,
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }
            }),
          ),
        ],
      ),
    );
  }
}

OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
);
