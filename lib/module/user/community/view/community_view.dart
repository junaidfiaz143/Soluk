import 'package:app/module/user/community/view/challenges/view/challenges_view.dart';
import 'package:app/module/user/community/view/follow/follow_view.dart';
import 'package:app/res/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/community_tabbar.dart';
import 'friends/friends_view.dart';
import 'messages/messages_view.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({Key? key}) : super(key: key);

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'Community',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CommunityTabBar(tabController: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ChallengesView(),
                  FriendsView(),
                  MessagesView(),
                  FollowView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
