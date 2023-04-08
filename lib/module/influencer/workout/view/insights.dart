import 'package:app/module/influencer/workout/view/favorite_meals.dart';
import 'package:app/module/influencer/workout/widgets/insight_tile.dart';
import 'package:app/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../res/globals.dart';
import 'blogs.dart';
import 'links.dart';
import 'nutrients.dart';

class Insights extends StatefulWidget {
  const Insights({Key? key}) : super(key: key);

  @override
  State<Insights> createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  final List<String> menus = [
    "Nutrients\nGuides",
    "Favorite\nMeals",
    "My\nBlogs",
    "Social\nMedia Links"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: menus.length,
          itemBuilder: (ctx, i) {
            return Column(
              children: [
                InsightTile(
                  image: i == 0
                      ? NUTRIENT_GUIDES
                      : i == 1
                          ? FAVORITE_MEALS
                          : i == 2
                              ? MY_BLOGS
                              : SOCIAL_MEDIA_LINKS,
                  title: menus[i],
                  callback: () {
                    if (i == 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Links(),
                        ),
                      );
                    } else if (i == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Blogs(
                            selectedInfluencerId: globalUserId,
                          ),
                        ),
                      );
                    } else if (i == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FavoriteMeals(),
                        ),
                      );
                    } else if (i == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NutrientsPlan(),
                        ),
                      );
                    }
                  },
                  bottomMargin: 0,
                ),
                SizedBox(
                  height: 1.5.h,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
