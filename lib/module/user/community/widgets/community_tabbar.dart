import 'package:flutter/material.dart';

class CommunityTabBar extends StatelessWidget {
  const CommunityTabBar({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      unselectedLabelColor: Colors.black.withOpacity(0.8),
      labelColor: Colors.black,
      labelStyle: TextStyle(fontWeight: FontWeight.w700),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
      indicatorPadding: EdgeInsets.zero,
      indicatorColor: Color(0xff498AEE),
      labelPadding: EdgeInsets.symmetric(horizontal: 12),
      indicatorWeight: 2.5,
      tabs: [
        Tab(
          text: 'Challenges',
        ),
        Tab(
          text: 'Friends',
        ),
        Tab(
          text: 'Messages',
        ),
        Tab(
          text: '+ Follow',
        )
      ],
      controller: _tabController,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }
}
