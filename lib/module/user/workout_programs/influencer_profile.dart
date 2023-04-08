import 'package:app/module/influencer/challenges/cubit/badges_bloc/badgesbloc_cubit.dart';
import 'package:app/module/influencer/challenges/cubit/challenges_bloc/challengesbloc_cubit.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/workout/bloc/workout_dashboard_bloc/workoutdashboardbloc_cubit.dart';
import 'package:app/module/influencer/workout/view/about_me.dart';
import 'package:app/module/influencer/workout/view/insights.dart';
import 'package:app/module/influencer/workout/view/workouts.dart';
import 'package:app/module/influencer/workout/widgets/workout_tabbar.dart';
import 'package:app/module/user/workout_programs/user_workout_programs.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/app_bar.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../res/constants.dart';
import '../widgets/top_appbar_row.dart';
import 'widgets/user_profile_workout_tile.dart';

class InfluencerProfile extends StatefulWidget {
  const InfluencerProfile({Key? key}) : super(key: key);

  @override
  State<InfluencerProfile> createState() => _InfluencerProfileState();
}

class _InfluencerProfileState extends State<InfluencerProfile> {
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
            preferredSize: Size.fromHeight(100.0),
            // 1
            child: TopAppbarRow(
              title: 'John Doe',
              topHeight: 2.h,
            ),
            // child: DefaultAppBar(
            //   title: AppLocalisation.getTranslated(
            //       context, LKChallengeWorkoutPlan),
            //   showBackButton: false,
            // )
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://picsum.photos/200/300'),
                  radius: 40,
                ),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  height: 60.h,
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
                                GestureDetector(
                                    onTap: () {
                                      NavRouter.push(
                                          context,
                                          UserWorkoutPrograms(
                                            userId: "",
                                          ));
                                    },
                                    child: UserProfileWorkoutTile()),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
