import 'package:app/module/influencer/challenges/cubit/badges_bloc/badgesbloc_cubit.dart';
import 'package:app/module/influencer/challenges/cubit/challenges_bloc/challengesbloc_cubit.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/workout/bloc/workout_dashboard_bloc/workoutdashboardbloc_cubit.dart';
import 'package:app/module/influencer/workout/view/about_me.dart';
import 'package:app/module/influencer/workout/view/insights.dart';
import 'package:app/module/influencer/workout/view/workouts.dart';
import 'package:app/module/influencer/workout/widgets/workout_tabbar.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/constants.dart';

class WorkPlanScreen extends StatefulWidget {
  const WorkPlanScreen({Key? key}) : super(key: key);

  @override
  State<WorkPlanScreen> createState() => _WorkPlanScreenState();
}

class _WorkPlanScreenState extends State<WorkPlanScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChallengesblocCubit>(context).getChallengeData();
    BlocProvider.of<WorkoutdashboardblocCubit>(context).getWorkoutDashboard();
    BlocProvider.of<BadgesblocCubit>(context).getBadgesData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          // title: AppLocalisation.getTranslated(context, LKChallengeWorkoutPlan),
          // showBackButton: false,
          // bgColor: backgroundColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              // 1
              child: DefaultAppBar(
                title: AppLocalisation.getTranslated(context, LKChallengeWorkoutPlan),
                showBackButton: false,
              )),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: DefaultTabController(
              length: 3,
              child: Container(
                color: backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WorkoutTabbar(),
                    SB_1H,
                    Expanded(
                      child: TabBarView(
                        children: [
                          // const SingleChildScrollView(
                          //   child:
                             Workouts(),
                          // ),
                          const SingleChildScrollView(
                            child: Insights(),
                          ),
                          SingleChildScrollView(
                            child: AboutMe(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
