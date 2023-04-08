import 'package:app/module/influencer/challenges/challenge_const.dart/challenge_const.dart';
import 'package:app/module/influencer/challenges/model/challenges_details_modals.dart';
import 'package:app/module/influencer/challenges/model/participant_modal.dart';
import 'package:app/module/influencer/challenges/view/participants/participants_detail_screen.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/c_date_format.dart';
import 'package:app/utils/nav_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../services/localisation.dart';

class ChallengerTile extends StatelessWidget {
  DataParticipant? data;
  ChallengeModel? challengeInfo;
  Function? onRewardFunction;

  ChallengerTile(
      {Key? key, this.data, this.challengeInfo, this.onRewardFunction})
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
                SizedBox(
                  height: defaultSize.screenHeight * .01,
                ),
                Visibility(
                  visible: data?.isCompleted == 1,
                  child: Text(
                    "Done On: ${CDateFormat.returnMonthDayYear(data?.completedAt ?? "")}",
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
            (data?.isCompleted == 1)
                ? Row(
                    children: [
                      Visibility(
                        visible: data?.isRewarded == 1,
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              '${ChallengeConst.badges["${challengeInfo?.badge}"]}',
                              height: 26,
                              width: 26,
                            ),
                            const SizedBox(height: 1),
                            Text(
                              '${ChallengeConst.title["${challengeInfo?.badge}"]}',
                              style: hintTextStyle(context)?.copyWith(
                                fontSize: defaultSize.screenWidth * .020,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: data?.isRewarded == 1,
                        child: SizedBox(
                          width: defaultSize.screenWidth * .06,
                        ),
                      ),
                      SalukTransparentButton(
                        title: "See Details",
                        buttonWidth: WIDTH_5 * 2,
                        borderColor: PRIMARY_COLOR,
                        textColor: PRIMARY_COLOR,
                        textFontSize: defaultSize.screenWidth * .028,
                        onPressed: () {
                          NavRouter.push(
                              context,
                              ParticipantsDetailsScreen(
                                  challengeData: challengeInfo,
                                  data: data,
                                  isRewardScreen: data?.isRewarded! == 1));
                        },
                        buttonHeight: HEIGHT_1 + 2,
                        style: labelTextStyle(context)?.copyWith(
                          fontSize: defaultSize.screenWidth * .018,
                          color: PRIMARY_COLOR,
                        ),
                        borderRadius: BorderRadius.circular(
                          defaultSize.screenWidth * .02,
                        ),
                      ),
                      Visibility(
                        visible: data?.isRewarded != 1,
                        child: SizedBox(
                          width: defaultSize.screenWidth * .02,
                        ),
                      ),
                      Visibility(
                        visible: data?.isRewarded != 1,
                        child: SalukGradientButton(
                          title: AppLocalisation.getTranslated(
                              context, LKGiveReward),
                          buttonWidth: WIDTH_5 * 2.2,
                          borderColor: PRIMARY_COLOR,
                          onPressed: () {
                            onRewardFunction!(data?.participant?.id.toString());
                          },
                          buttonHeight: HEIGHT_1 + 2,
                          style: labelTextStyle(context)?.copyWith(
                            fontSize: defaultSize.screenWidth * .028,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(
                            defaultSize.screenWidth * .02,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
        const Divider(
          thickness: 0.5,
        ),
      ],
    );
  }
}
