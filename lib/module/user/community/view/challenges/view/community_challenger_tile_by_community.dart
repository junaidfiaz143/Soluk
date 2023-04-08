import 'package:app/module/influencer/challenges/model/participant_modal.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/module/user/models/community_challenges_model.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/c_date_format.dart';
import 'package:app/utils/nav_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../services/localisation.dart';
import 'community_challenger_winner_details_screen.dart';

class CommunityChallengerTileByCommunity extends StatelessWidget {
  final bool hasWonTheReward;
  DataParticipant? data;
  CommunityChallenge? challengeInfo;

  CommunityChallengerTileByCommunity(
      {Key? key, this.hasWonTheReward = false, this.data, this.challengeInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl = data!.participant!.imageUrl;
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: HEIGHT_3,
              height: HEIGHT_3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: imageUrl == null
                    ? SvgPicture.asset(
                        'assets/svgs/placeholder.svg',
                        width: HEIGHT_3,
                        height: HEIGHT_3,
                      )
                    : CachedNetworkImage(
                        width: HEIGHT_3,
                        height: HEIGHT_3,
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              color: PRIMARY_COLOR,
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
              ),
            ),
            SB_1W,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data?.participant?.fullname ?? "",
                  style: labelTextStyle(context)?.copyWith(
                    fontSize: defaultSize.screenWidth * .035,
                  ),
                ),
                Visibility(
                  visible: data?.isCompleted == 1,
                  child: SizedBox(
                    height: defaultSize.screenHeight * .01,
                  ),
                ),
                Visibility(
                  visible: data?.isCompleted == 1,
                  child: Text(
                    "Done on: ${CDateFormat.returnMonthDayYear(data!.completedAt ?? "")}",
                    style: hintTextStyle(context)?.copyWith(
                      fontSize: defaultSize.screenWidth * .024,
                    ),
                  ),
                ),
                SizedBox(
                  height: defaultSize.screenHeight * .01,
                ),
              ],
            ),
            const Spacer(),
            Visibility(
              visible: data?.isCompleted == 1,
              child: Row(
                children: [
                  const Icon(Icons.star_rounded, color: Color(0xff498AEE)),
                  const SizedBox(width: 4),
                  Text(
                    data?.UserRating ?? '0.0',
                    style: labelTextStyle(context)?.copyWith(),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: data?.isCompleted == 1,
              child: SizedBox(
                width: defaultSize.screenWidth * .06,
              ),
            ),
            Visibility(
              visible: data?.isCompleted == 1,
              child: SalukTransparentButton(
                title: AppLocalisation.getTranslated(context, LKSeeDetails),
                buttonWidth: WIDTH_5 * 2,
                borderColor: PRIMARY_COLOR,
                textColor: PRIMARY_COLOR,
                textFontSize: defaultSize.screenWidth * .028,
                onPressed: () {
                  NavRouter.push(
                      context,
                      CommunityParticipantsByCommunityDetailsScreen(
                          hasWonTheReward: data?.isRewarded == 1,
                          data: data,
                          challengeData: challengeInfo));
                },
                buttonHeight: HEIGHT_1 + 2,
                style: labelTextStyle(context)?.copyWith(
                  fontSize: defaultSize.screenWidth * .028,
                  color: PRIMARY_COLOR,
                ),
                borderRadius: BorderRadius.circular(
                  defaultSize.screenWidth * .02,
                ),
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 0.5,
        ),
      ],
    );
  }
}
