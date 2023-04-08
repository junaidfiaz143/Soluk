import 'package:app/module/influencer/challenges/widget/cards_tiles/challenger_tile.dart';
import 'package:app/module/influencer/challenges/widget/challenge_types_chip.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class AllChallengers extends StatelessWidget {
  const AllChallengers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
        title: 'All Challengers',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomChipsGroup(
              chips: [
                "Challengers",
                "Rewards",
              ],
            ),
            SB_1H,
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (ctx, i) {
                  return ChallengerTile();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
