
import 'package:app/module/influencer/challenges/model/challenge.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  final bool isLink;
  final bool isChallenge;
  final VoidCallback callback;
  final ChallengeModel? model;
  const ItemTile({
    Key? key,
    this.isLink = false,
    this.isChallenge = false,
    required this.callback,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        height: HEIGHT_5 + HEIGHT_2,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BORDER_CIRCULAR_RADIUS * 2,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            Container(
              height: HEIGHT_5 + HEIGHT_3,
              width: WIDTH_5 * 3.2,
              decoration: BoxDecoration(
                borderRadius: BORDER_CIRCULAR_RADIUS * 2,
                image: DecorationImage(
                  image: NetworkImage(
                    WORKOUT_COVER2,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
            ),
            SB_1W,
            if (!isChallenge)
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: WIDTH_1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur",
                        style: labelTextStyle(context)?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (isLink) const Spacer(),
                      if (isLink)
                        Text(
                          "Link",
                          style: labelTextStyle(context)?.copyWith(
                            fontSize: defaultSize.screenWidth * .035,
                          ),
                        ),
                      if (isLink)
                        Row(
                          children: [
                            Icon(
                              Icons.link,
                              size: WIDTH_2,
                              color: PRIMARY_COLOR,
                            ),
                            SB_1W,
                            Text(
                              "www.abc.com",
                              style: labelTextStyle(context)?.copyWith(
                                fontSize: defaultSize.screenWidth * .035,
                                color: PRIMARY_COLOR,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              )
            else if (isChallenge)
              if (model == null)
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: WIDTH_1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Challenge 1",
                          style: labelTextStyle(context)?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(
                              Icons.padding,
                            ),
                            Text(
                              "Gold",
                              style: labelTextStyle(context)?.copyWith(
                                fontSize: defaultSize.screenWidth * .035,
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Text(
                                  "23",
                                  style: labelTextStyle(context)?.copyWith(
                                    fontSize: defaultSize.screenWidth * .03,
                                  ),
                                ),
                                SizedBox(
                                  height: defaultSize.screenHeight * .005,
                                ),
                                Text(
                                  "Challenge Done",
                                  style: hintTextStyle(context)?.copyWith(
                                    fontSize: defaultSize.screenWidth * .035,
                                  ),
                                ),
                                SB_1H,
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              else if (model != null)
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: WIDTH_1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          model!.title!,
                          style: labelTextStyle(context)?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(
                              Icons.padding,
                            ),
                            Text(
                              model!.badge!,
                              style: labelTextStyle(context)?.copyWith(
                                fontSize: defaultSize.screenWidth * .035,
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Text(
                                  model!.maxUsers!.toString(),
                                  style: labelTextStyle(context)?.copyWith(
                                    fontSize: defaultSize.screenWidth * .03,
                                  ),
                                ),
                                SizedBox(
                                  height: defaultSize.screenHeight * .005,
                                ),
                                Text(
                                  "Challenge Done",
                                  style: hintTextStyle(context)?.copyWith(
                                    fontSize: defaultSize.screenWidth * .035,
                                  ),
                                ),
                                SB_1H,
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            SB_1W,
            Icon(
              Icons.arrow_forward_ios,
              size: WIDTH_3,
            ),
            SB_1W,
          ],
        ),
      ),
    );
  }
}
