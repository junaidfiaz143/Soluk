import 'package:app/module/user/community/bloc/friends/community_follow_bloc.dart';
import 'package:app/module/user/community/model/friends_model.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../res/globals.dart';

class CommunityFollowTile extends StatelessWidget {
  final model.Data item;

  const CommunityFollowTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommunityFollowBloc _communityFollowBloc = BlocProvider.of(context);
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          (item.imageUrl == null || item.imageUrl == '')
              ? SvgPicture.asset(
                  'assets/svgs/placeholder.svg',
                  width: HEIGHT_3,
                  height: HEIGHT_3,
                )
              : CircleAvatar(
                  backgroundColor: const Color(0xFFe7e7e7),
                  backgroundImage: NetworkImage(item.imageUrl!),
                  radius: 24,
                ),
          SizedBox(width: 10),
          Text(
            item.fullname ?? "",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Container(
            height: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff498AEE),
                padding: EdgeInsets.symmetric(horizontal: 18),
                shape: StadiumBorder(),
              ),
              onPressed: () {
                _communityFollowBloc.followUser(id: item.id.toString());
              },
              child: Text(
                '+ Follow',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}
