import 'package:app/module/influencer/challenges/model/challenge.dart';
import 'package:app/module/influencer/widgets/item_details.dart';
import 'package:app/module/influencer/widgets/item_tile.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

import 'challenge_types_chip.dart';
import 'filtered_search.dart';

class ChallengesList extends StatelessWidget {
  final GetAllChallenges allChallenges;
  const ChallengesList({
    Key? key,
    required this.allChallenges,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomChipsGroup(),
        SB_1H,
        const FilteredSearch(),
        SB_1H,
        Expanded(
          child: ListView.builder(
              itemCount: allChallenges.allChallenges!.length,
              shrinkWrap: true,
              itemBuilder: (ctx, i) {
                return Column(
                  children: [
                    ItemTile(
                      callback: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ItemDetails(
                              title: "Challenge 1",
                              route: "challenge",
                              blog:
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra sit lobortis sed placerat vulputate blandit sagittis, hac gravida. Condimentum enim lacinia a, sagittis, sed felis tempor nec vivamus. Neque eu facilisis tincidunt convallis orci ac quam nulla ornare. Arcu a massa donec nulla ut viverra amet, nibh gravida. Sit tellus sapien, tempor sed molestie sed lorem. Proin enim maecenas praesent at malesuada aliquam ornare sit. Scelerisque lacus nunc, pellentesque egestas tellus rhoncus. Rhoncus bibendum eu ante sed at. Convallis tellus elementum iaculis magna et. Malesuada mauris, risus, viverra congue congue nec. Pharetra orci massa curabitur nibh placerat vitae et amet malesuada.",
                            ),
                          ),
                        );
                      },
                      model: allChallenges.allChallenges![i],
                      isChallenge: true,
                    ),
                    SB_1H,
                  ],
                );
              }),
        ),
      ],
    );
  }
}
