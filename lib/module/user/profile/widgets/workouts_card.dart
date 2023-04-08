import 'package:app/module/user/profile/sub_screen/my_badges/view/my_badges_screen.dart';
import 'package:app/module/user/profile/sub_screen/my_challenges/views/my_challenges_screen.dart';
import 'package:app/module/user/profile/sub_screen/my_downloads/view/my_downloads_screen.dart';
import 'package:app/module/user/profile/sub_screen/my_influencers/views/my_influencers_screen.dart';
import 'package:app/module/user/profile/sub_screen/my_workouts/views/my_workout_screen.dart';
import 'package:app/module/user/profile/sub_screen/weight_progress/view/weight_progress_screen.dart';
import 'package:flutter/material.dart';
import '../grocery_screen.dart';
import 'user_profile_tile.dart';

class WorkoutsCard extends StatelessWidget {
  const WorkoutsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_1.svg',
            text: 'My Influencers',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MyInfluencersScreen()));
            },
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_2.svg',
            text: 'My Workouts',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MyWorkoutScreen()));
            },
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_3.svg',
            text: 'My Downloads',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MyDownloadsScreen()));
            },
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_4.svg',
            text: 'My Challenges',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MyChallengesScreen()));
            },        ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_5.svg',
            text: 'My Badges',
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MyBadgesScreen()));
            },
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_6.svg',
            text: 'Weight Progress',
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => WeightProgressScreen()));
            },
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_workouts_7.svg',
            text: 'Grocery List',
            onPressed: (){
               Navigator.push(context,
                   MaterialPageRoute(builder: (_) => GroceryScreen()));
               // navigatorKey.currentState?.pushNamed(GroceryScreen.id)
             } ,
          ),
        ],
      ),
    );
  }
}
