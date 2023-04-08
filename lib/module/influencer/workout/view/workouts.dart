import 'package:app/module/influencer/challenges/view/challenges_screen.dart';
import 'package:app/module/influencer/workout/bloc/workout_dashboard_bloc/workoutdashboardbloc_cubit.dart';
import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/module/influencer/workout/widgets/workout_tile.dart';
import 'package:app/module/influencer/workout_programs/view/workout_programs.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Workouts extends StatelessWidget {
  const Workouts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc=BlocProvider.of<WorkoutdashboardblocCubit>(context);
    return BlocBuilder<WorkoutdashboardblocCubit, WorkoutdashboardblocState>(
          builder: (context, state) {
        return RefreshWidget(
          refreshController:bloc.refController,
          onLoadMore: (){},
          enablePullUp: false,
          onRefresh: ()=>bloc.onRefresh(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WorkoutTile(
                firstValue: (state is WorkoutdashboardLoading)?null:(state is WorkoutdashboardLoaded)?'${state.dashboardData?.responseDetails?.workouts?.published??'0'}':'0',
                secondValue: (state is WorkoutdashboardLoading)?null:(state is WorkoutdashboardLoaded)?'${state.dashboardData?.responseDetails?.workouts?.unPublished??'0'}':'0',
                image: WORKOUT,
                title: "Workout\nPrograms",
                callback: () {
                  navigatorKey.currentState?.pushNamed(WorkoutPrograms.id);
                },
              ),
              SB_Half,
              WorkoutTile(
                   firstValue: (state is WorkoutdashboardLoading)?null:(state is WorkoutdashboardLoaded)?'${state.dashboardData?.responseDetails?.challenges?.approved??'0'}':'0',
                secondValue: (state is WorkoutdashboardLoading)?null:(state is WorkoutdashboardLoaded)?'${state.dashboardData?.responseDetails?.challenges?.unApproved??'0'}':'0',
                image: CHALLENGES,
                isChallenges: true,
                title: "My\nChallenges",
                callback: () {
                  navigatorKey.currentState?.pushNamed(ChallengesScreen.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
