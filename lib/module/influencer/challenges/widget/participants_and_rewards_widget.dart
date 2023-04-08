import 'package:app/module/influencer/challenges/challenge_const.dart/challenge_const.dart';
import 'package:app/module/influencer/challenges/model/challenges_details_modals.dart';
import 'package:app/module/influencer/challenges/view/participants/participants_by_influencer_screen.dart';
import 'package:app/utils/nav_router.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../res/constants.dart';
import '../../../../res/globals.dart';
import '../../../../services/localisation.dart';
import '../view/participants/participants_by_community_screen.dart';

class ParticipantsAndRewardWidget extends StatelessWidget {
  final ChallengeModel detail;
  final bool isApproved;

  const ParticipantsAndRewardWidget(
      {Key? key, required this.detail, required this.isApproved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isApproved
                ? Text(
                    'Participants (${detail.participantsCount} Submitted)',
                    // AppLocalisation.getTranslated(context, LKParticipants8Submitted),
                    style: subTitleTextStyle(context)
                        ?.copyWith(fontSize: defaultSize.screenWidth * .040),
                  )
                : Container(),
            isApproved
                ? GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      var isWinnerByCommunity = detail.winnerBy
                          ?.toLowerCase()
                          .contains(CHALLENGE_COMMUNITY);
                      if (isWinnerByCommunity ?? false) {
                        NavRouter.push(
                            context, ParticipantsByCommunityScreen(detail));
                      } else {
                        NavRouter.push(
                            context,
                            ParticipantsByInfluencerScreen(detail,
                                isWinnerByCommunity:
                                    isWinnerByCommunity ?? false));
                      }

                      // if(detail.participantsCount != 0){
                      //   NavRouter.push(context, const ParticipantsByInfluencerScreen());
                      // } else {
                      //   Fluttertoast.showToast(
                      //       msg: "${detail.title} is currently under review by Admin",
                      //       toastLength: Toast.LENGTH_SHORT,
                      //       gravity: ToastGravity.BOTTOM,
                      //       timeInSecForIosWeb: 1,
                      //       backgroundColor: Colors.red,
                      //       textColor: Colors.yellow
                      //   );
                      //
                      // }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 16),
                      child: Text(
                        AppLocalisation.getTranslated(
                            context, LKViewParticipants),
                        style: labelTextStyle(context)?.copyWith(
                            fontSize: defaultSize.screenWidth * .040,
                            color: const Color(0xff498AEE)),
                      ),
                    ),
                  )
                : Container(),
            Text(
              AppLocalisation.getTranslated(context, LKChallengerWinnerBy),
              style: subTitleTextStyle(context)
                  ?.copyWith(fontSize: defaultSize.screenWidth * .040),
            ),
            GestureDetector(
              onTap: () {
                // NavRouter.push(context, ParticipantsByCommunityScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 16),
                child: Text(
                  '${detail.winnerBy}',
                  // 'Community',
                  style: hintTextStyle(context)?.copyWith(
                    fontSize: defaultSize.screenWidth * .040,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          children: [
            SvgPicture.asset('${ChallengeConst.badges["${detail.badge}"]}',
                height: 30, width: 30),
            const SizedBox(height: 3),
            Text(
              '${ChallengeConst.title["${detail.badge}"]}',
              // AppLocalisation.getTranslated(context, LKGold),
              style: labelTextStyle(context)?.copyWith(
                fontSize: defaultSize.screenWidth * .038,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              AppLocalisation.getTranslated(context, LKCompleteBadge),
              style: hintTextStyle(context)?.copyWith(
                  fontSize: defaultSize.screenWidth * .038,
                  fontWeight: FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }
}
