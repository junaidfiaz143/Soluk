import 'package:app/module/user/community/bloc/friends/friend_detail_bloc.dart';
import 'package:app/module/user/community/model/friend_detail_model.dart';
import 'package:app/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../res/color.dart';
import '../../../../utils/nav_router.dart';
import '../view/messages/chat_view.dart';
import 'friends_detais_button.dart';

class FriendsDetailsProfileCard extends StatelessWidget {
  final FriendDetailModel friendDetailModel;

  const FriendsDetailsProfileCard({Key? key, required this.friendDetailModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FriendDetailBloc _friendDetailBloc = BlocProvider.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          friendDetailModel.responseDetails?.profileInfo?[0]
                                      .imageUrl ==
                                  null
                              ? SvgPicture.asset(
                                  'assets/svgs/placeholder.svg',
                                  width: 60,
                                  height: 60,
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      friendDetailModel.responseDetails
                                              ?.profileInfo?[0].imageUrl ??
                                          DEMO_URL),
                                  radius: 30,
                                ),
                          SizedBox(height: 10),
                          Text(
                            friendDetailModel.responseDetails?.profileInfo?[0]
                                    .fullname ??
                                "",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    /*Positioned(
                      right: 0,
                      bottom: 3,
                      child: Column(
                        children: [
                          Icon(Icons.info_outline),
                          Text(
                            'Report',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),*/
                  ],
                  alignment: Alignment.bottomRight,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (friendDetailModel
                                  .responseDetails?.profileInfo?[0].instagram !=
                              null &&
                          friendDetailModel.responseDetails!.profileInfo![0]
                              .instagram!.isNotEmpty)
                        SocialAccountWidget(
                          iconPath: 'assets/images/img_insta.png',
                          userName: friendDetailModel
                                  .responseDetails?.profileInfo?[0].instagram ??
                              "",
                        ),
                      if (friendDetailModel
                                  .responseDetails?.profileInfo?[0].snapchat !=
                              null &&
                          friendDetailModel.responseDetails!.profileInfo![0]
                              .snapchat!.isNotEmpty)
                        SocialAccountWidget(
                          iconPath: 'assets/images/snapchat.png',
                          userName: friendDetailModel
                                  .responseDetails?.profileInfo?[0].snapchat ??
                              "",
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (friendDetailModel.responseDetails?.userSetting
                            ?.allowDirectMessages ==
                        1)
                      FriendsDetailsButton(
                        title: 'Message',
                        onPressed: () {
                          // Random()
                          NavRouter.push(
                              context,
                              ChatView(
                                peerUserId:
                                    '${friendDetailModel.responseDetails!.profileInfo?[0].id}',
                                username:
                                    "${friendDetailModel.responseDetails!.profileInfo?[0].fullname}",
                              ));
                        },
                      ),
                    StreamBuilder<bool>(
                        stream: _friendDetailBloc.followUnFollowStream,
                        initialData: true,
                        builder: (context, snapshot) {
                          return FriendsDetailsButton(
                            title: snapshot.data! ? 'Unfollow' : "Follow",
                            //true means followed false means not followed
                            onPressed: () {
                              snapshot.data!
                                  ? _friendDetailBloc.unFollowUser(
                                      id: friendDetailModel.responseDetails
                                              ?.profileInfo?[0].id
                                              .toString() ??
                                          "")
                                  : _friendDetailBloc.followUser(
                                      id: friendDetailModel.responseDetails
                                              ?.profileInfo?[0].id
                                              .toString() ??
                                          "");
                            },
                            textColor: PRIMARY_COLOR,
                            isOutlinedButton: true,
                          );
                        }),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SocialAccountWidget extends StatelessWidget {
  const SocialAccountWidget({
    required this.iconPath,
    required this.userName,
    Key? key,
  }) : super(key: key);
  final String userName;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          iconPath,
          height: 34,
          width: 34,
        ),
        SizedBox(width: 10),
        Text(
          userName,
          style: TextStyle(fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
