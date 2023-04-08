
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';

import '../../../../../../res/constants.dart';
import '../../../../../influencer/workout/widgets/insight_tile.dart';
import '../../../../widgets/top_appbar_row.dart';
import 'soluk_resturant_meals.dart';

class SolukMealsDetails extends StatefulWidget {
  const SolukMealsDetails({Key? key}) : super(key: key);

  @override
  State<SolukMealsDetails> createState() => _SolukMealsDetailsState();
}

class _SolukMealsDetailsState extends State<SolukMealsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          TopAppbarRow(
            title: 'Restaurant Name',
          ),
          SizedBox(height: 14),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              children: [
                InsightTile(
                  height: 108,
                  title: 'Breakfast',
                  image: 'assets/images/ic_breakfast.jpg',
                  callback: () {
                    // NavRouter.push(context, SolukRestaurantMeals());
                  },
                ),
                InsightTile(
                  height: 108,
                  title: 'Lunch',
                  image: 'assets/images/ic_lunch.jpg',
                  callback: () {
                    // NavRouter.push(context, SolukRestaurantMeals());
                  },
                ),
                InsightTile(
                  height: 108,
                  title: 'Snack',
                  image: 'assets/images/ic_snack.jpg',
                  callback: () {
                    // NavRouter.push(context, SolukRestaurantMeals());
                  },
                ),
                InsightTile(
                  height: 108,
                  title: 'Dinner',
                  image: 'assets/images/ic_dinner.jpg',
                  callback: () {
                    // NavRouter.push(context, SolukRestaurantMeals());
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
