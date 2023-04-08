import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

import '../../../../utils/nav_router.dart';
import '../../../influencer/workout/widgets/workout_tile.dart';
import '../user_workout_programs.dart';

class UserProfileWorkoutTile extends StatelessWidget {
  const UserProfileWorkoutTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WorkoutTile(
          firstValue: '0',
          secondValue: '0',
          image: WORKOUT,
          title: "Workout\nPrograms",
          callback: () {
            NavRouter.push(
                context,
                UserWorkoutPrograms(
                  userId: '',
                ));
            // navigatorKey.currentState?.pushNamed(WorkoutPrograms.id);
          },
        ),
        SB_Half,
        WorkoutTile(
          firstValue: '0',
          secondValue: '0',
          image: CHALLENGES,
          isChallenges: true,
          title: "My\nChallenges",
          callback: () {
            // navigatorKey.currentState?.pushNamed(ChallengesScreen.id);
          },
        ),
      ],
    );
  }
}
