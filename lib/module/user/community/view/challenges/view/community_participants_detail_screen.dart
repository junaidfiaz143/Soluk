import 'package:app/module/influencer/challenges/model/participant_modal.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/user/models/community_challenges_model.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/c_date_format.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../res/color.dart';
import '../../../../../../services/localisation.dart';
import '../../../../../influencer/challenges/widget/challenger_widgets/reward_widget.dart';
import '../../../../../influencer/widgets/workout_tile_video_thumbnail.dart';
import '../../../../../influencer/workout_programs/view/media_screen.dart';

class CommunityParticipantsDetailsScreen extends StatelessWidget {
  static const String id = "/challenger_detail";
  final bool isRewardScreen;
  DataParticipant? data;
  CommunityChallenge? challengeData;

  CommunityParticipantsDetailsScreen(
      {Key? key, this.isRewardScreen = false, this.data, this.challengeData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF3F3F3),
        body: AppBody(
          title: "",
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: HEIGHT_3,
                  height: HEIGHT_3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60.0),
                    child: data?.participant?.imageUrl == null
                        ? SvgPicture.asset(
                            'assets/svgs/placeholder.svg',
                            width: HEIGHT_3,
                            height: HEIGHT_3,
                          )
                        : CachedNetworkImage(
                            width: HEIGHT_3,
                            height: HEIGHT_3,
                            imageUrl: data?.participant?.imageUrl ?? '',
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  color: PRIMARY_COLOR,
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Center(
                child: Text(
                  data?.participant?.fullname ?? "",
                  style: subTitleTextStyle(context)
                      ?.copyWith(fontSize: defaultSize.screenWidth * .046),
                ),
              ),
              SB_1H,
              Text(
                challengeData?.title ?? "",
                style: subTitleTextStyle(context)
                    ?.copyWith(fontSize: defaultSize.screenWidth * .042),
              ),
              const SizedBox(height: 10),
              Text(
                challengeData?.description ?? '',
                style: labelTextStyle(context)?.copyWith(
                  fontSize: defaultSize.screenWidth * .035,
                ),
              ),
              SB_1H,
              InkWell(
                onTap: () {
                  if (!data!.assetUrl!.contains("mp4")) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MediaScreen(
                                videoUrl: data!.assetUrl!,
                                title: '',
                                mediaTypeisVideo:
                                    data?.assetType == 'Image' ? false : true,
                              )),
                    );
                  }
                },
                child: Container(
                  width: double.maxFinite,
                  height: HEIGHT_5 * 1.7,
                  decoration: BoxDecoration(
                    borderRadius: BORDER_CIRCULAR_RADIUS,
                  ),
                  child: data!.assetUrl!.contains("mp4")
                      ? WorkoutTileVideoThumbnail(
                          url: data!.assetUrl!,
                          playBack: true,
                          decorated: true,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(60.0),
                          child: CachedNetworkImage(
                            imageUrl: data!.assetUrl!,
                            fit: BoxFit.fill,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  color: PRIMARY_COLOR,
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalisation.getTranslated(context, LKSubmittedOn),
                        style: subTitleTextStyle(context)?.copyWith(
                            fontSize: defaultSize.screenWidth * .034),
                      ),
                      Text(
                        "${CDateFormat.returnMonthDayYear(data!.completedAt!)}",
                        style: hintTextStyle(context)?.copyWith(
                            fontSize: defaultSize.screenWidth * .034),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (isRewardScreen)
                    RewardWidget(challengeData?.badge ?? "gold")
                ],
              ),
            ],
          ),
        ));
  }
}
