import 'package:app/module/common/commonbloc.dart';
import 'package:app/module/influencer/challenges/view/challenges_screen.dart';
import 'package:app/module/influencer/workout_programs/view/workout_programs.dart';
import 'package:app/module/user/home/widgets/influencer_workout_tile.dart';
import 'package:app/module/user/workout_programs/user_workout_programs.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../utils/nav_router.dart';

class InfluencerWorkouts extends StatelessWidget {
  final String userId;
  InfluencerWorkouts({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfluencerWorkoutTile(
          image: WORKOUT,
          title: "Workout\nPrograms",
          callback: () {
            BlocProvider.of<CommonBloc>(context).userType == INFLUENCER
                ? navigatorKey.currentState?.pushNamed(WorkoutPrograms.id)
                : NavRouter.push(context, UserWorkoutPrograms(userId: userId));
          },
        ),
        SB_Half,
        InfluencerWorkoutTile(
          image: CHALLENGES,
          title: "My\nChallenges",
          callback: () {
            navigatorKey.currentState?.pushNamed(ChallengesScreen.id);
          },
        ),
      ],
    );
  }
}
