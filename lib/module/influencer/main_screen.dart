import 'package:app/module/influencer/bloc/bottom_nav_bloc.dart';
import 'package:app/module/influencer/main_screen/view/analytics_screen.dart';
import 'package:app/module/influencer/main_screen/view/dashboard_screen.dart';
import 'package:app/module/influencer/main_screen/view/more_screen.dart';
import 'package:app/module/influencer/main_screen/view/work_plan_screen.dart';
import 'package:app/utils/enums.dart' as enums;
import 'package:app/module/influencer/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../res/constants.dart';
import '../common/commonbloc.dart';

class MainScreen extends StatelessWidget {
  static const String id = "/main_screen";
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CommonBloc>(context).userType=INFLUENCER;

    return Scaffold(
      body: BlocBuilder<BottomNavBloc, enums.Action>(
        builder: (context, state) {
          if (state == enums.Action.DASHBOARD) {
            return const DashboardScreen();
          } else if (state == enums.Action.WORKPLAN) {
            return const WorkPlanScreen();
          } else if (state == enums.Action.ANALYTICS) {
            return const AnalyticsScreen();
          } else if (state == enums.Action.MORE) {
            return const MoreScreen();
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
