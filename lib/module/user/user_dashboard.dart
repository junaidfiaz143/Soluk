import 'package:app/module/user/community/view/community_view.dart';
import 'package:app/module/user/home/ui/home_view.dart';
import 'package:app/module/user/meals/view/meals_view.dart';
import 'package:app/module/user/profile/profile_view.dart';
import 'package:app/repo/data_source/local_store.dart';
import 'package:app/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../res/globals.dart';
import '../common/commonbloc.dart';
import '../influencer/login/repo/login_repository.dart';
import 'widgets/user_bottom_navbar.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _selectedIndex = 0;

  Widget getCurrentScreen(int index) {
    Widget widget = Container();
    switch (index) {
      case 0:
        widget = HomeView();
        break;
      case 1:
        widget = const MealsView();
        break;
      case 2:
        widget = const CommunityView();
        break;
      case 3:
        widget = ProfileView();
        break;
    }
    return widget;
  }

  initCurrentGlobalUser() async {
    globalUserId = await LocalStore.getData(PREFS_USERID);
    globalUserName = await LocalStore.getData(PREFS_USERNAME);
    globalProfilePic = await LocalStore.getData(PREFS_PROFILE);
    globalUserType = await LocalStore.getData(PREFS_USERTYPE);
    LoginRepository.getUserSubsciption(dummy: false, context: context);
  }

  @override
  void initState() {
    super.initState();
    initCurrentGlobalUser();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CommonBloc>(context).userType = NORMAL_USER;

    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          return true;
        } else {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
      },
      child: Scaffold(
        body: getCurrentScreen(_selectedIndex),
        bottomNavigationBar: UserBottomNavBar(
          selectedIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
