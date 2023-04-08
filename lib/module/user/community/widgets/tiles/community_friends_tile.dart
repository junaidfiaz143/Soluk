import 'package:app/module/user/community/model/friends_model.dart' as model;
import 'package:app/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommunityFriendsTile extends StatelessWidget {
  final model.Data item;

  const CommunityFriendsTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          item.imageUrl == null
              ? SvgPicture.asset(
                  'assets/svgs/placeholder.svg',
                  width: 48,
                  height: 48,
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(item.imageUrl ?? DEMO_URL),
                  radius: 24,
                ),
          SizedBox(width: 10),
          Text(
            item.fullname ?? "",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded, size: 16),
        ],
      ),
    );
  }
}
