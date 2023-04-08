import 'dart:io';
import 'package:app/module/influencer/widgets/bottom_nav_icon.dart';
import 'package:app/res/constants.dart';
import 'package:flutter/material.dart';

import '../../../repo/data_source/local_store.dart';

class UserBottomNavBar extends StatefulWidget {
  const UserBottomNavBar(
      {Key? key, required this.selectedIndex, required this.onTap})
      : super(key: key);
  final int selectedIndex;
  final Function(int index) onTap;

  @override
  State<UserBottomNavBar> createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  String userName = 'User';

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  void fetchUserName() async {
    userName = await LocalStore.getData(PREFS_USERNAME);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Platform.isIOS ? 16 : 0),
      height: Platform.isIOS ? 75 : 62,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.15),
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: BottomNavIcon(
              callback: () {
                widget.onTap(0);
              },
              asset: 'assets/svgs/ic_user_home.svg',
              matched: widget.selectedIndex == 0,
              title: 'Home',
            ),
          ),
          Expanded(
            child: BottomNavIcon(
              callback: () {
                widget.onTap(1);
              },
              asset: 'assets/svgs/ic_user_meals.svg',
              matched: widget.selectedIndex == 1,
              title: 'Meals',
            ),
          ),
          Expanded(
            child: BottomNavIcon(
              callback: () {
                widget.onTap(2);
              },
              asset: 'assets/svgs/ic_user_community.svg',
              matched: widget.selectedIndex == 2,
              title: 'Community',
            ),
          ),
          Expanded(
            child: BottomNavIcon(
              callback: () {
                widget.onTap(3);
              },
              asset: 'assets/svgs/ic_user_profile.svg',
              matched: widget.selectedIndex == 3,
              title: userName,
            ),
          ),
        ],
      ),
    );
  }
}
