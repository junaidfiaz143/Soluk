import 'package:app/module/influencer/workout/model/get_influencer.dart';
import 'package:app/module/influencer/workout/widgets/insight_tile.dart';
import 'package:app/module/influencer/workout/widgets/social_links.dart';
import 'package:app/res/constants.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../influencer/workout/view/blogs.dart';
import '../../../../../influencer/workout/view/favorite_meals.dart';
import '../../../../../influencer/workout/view/nutrients.dart';
import '../../influencer_screen/bloc/influencer_screen_cubit.dart';

class InfluencerInsights extends StatefulWidget {
  GetInfluencerModel? influencerInfo;

  InfluencerInsights({Key? key, this.influencerInfo}) : super(key: key);

  @override
  State<InfluencerInsights> createState() => _InfluencerInsightsState();
}

class _InfluencerInsightsState extends State<InfluencerInsights> {
  final List<String> menus = [
    "Nutrients\nGuides",
    "Favorite\nMeals",
    "My\nBlogs",
    "Social\nMedia Links"
  ];

  @override
  Widget build(BuildContext context) {
    InfluencerScreenCubit _aboutBloc = BlocProvider.of(context);

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
                      NavRouter.push(
                          context,
                          SocialLinks(
                            showEditIcon: false,
                            facebook: widget.influencerInfo?.responseDetails
                                    ?.userInfo?.facebook ??
                                '',
                            instagram: widget.influencerInfo?.responseDetails
                                    ?.userInfo?.instagram ??
                                '',
                            youtube: widget.influencerInfo?.responseDetails
                                    ?.userInfo?.youtube ??
                                '',
                            snapchat: widget.influencerInfo?.responseDetails
                                    ?.userInfo?.snapchat ??
                                '',
                          ));
                    } else if (i == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Blogs(
                              selectedInfluencerId: widget.influencerInfo
                                      ?.responseDetails?.userInfo?.id
                                      .toString() ??
                                  ''),
                        ),
                      );
                    } else if (i == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FavoriteMeals(
                              selectedInfluencerId: widget.influencerInfo
                                      ?.responseDetails?.userInfo?.id
                                      .toString() ??
                                  ''),
                        ),
                      );
                    } else if (i == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NutrientsPlan(
                              selectedInfluencerId: widget.influencerInfo
                                      ?.responseDetails?.userInfo?.id
                                      .toString() ??
                                  ''),
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
