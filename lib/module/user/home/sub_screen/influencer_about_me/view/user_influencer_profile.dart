import 'package:app/module/influencer/widgets/workout_tile_video_thumbnail.dart';
import 'package:app/module/influencer/workout/model/get_influencer.dart';
import 'package:app/module/influencer/workout/view/video_play_screen.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../influencer_suggestion/view/influencer_suggestion_screen.dart';

class UserInfluencerProfile extends StatefulWidget {
  final ValueChanged<String> valueChanged;
  final GetInfluencerModel? influencerInfo;

  const UserInfluencerProfile(
      {Key? key, required this.influencerInfo, required this.valueChanged})
      : super(key: key);

  @override
  State<UserInfluencerProfile> createState() => _UserInfluencerProfileState();
}

class _UserInfluencerProfileState extends State<UserInfluencerProfile> {
  List<String> titles = [
    "A Brief Intro",
    "Goals",
    "Credentials",
    "Requirements",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ((widget.influencerInfo?.responseDetails?.introUrl) != null)
                ? InkWell(
                    onTap: () {
                      if ((widget.influencerInfo?.responseDetails?.introUrl) !=
                          null) {
                        print(widget.influencerInfo?.responseDetails?.introUrl);

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return VideoPlayScreen(
                                asDialog: true,
                                videoPath: widget
                                    .influencerInfo!.responseDetails!.introUrl!,
                              );
                            });
                      }
                    },
                    child: Container(
                      height: HEIGHT_5 * 1,
                      width: HEIGHT_5 * 1.2,
                      child: WorkoutTileVideoThumbnail(
                          decorated: true,
                          playBack: widget
                                  .influencerInfo?.responseDetails?.introUrl
                                  ?.contains("mp4") ==
                              true,
                          url: widget
                                  .influencerInfo?.responseDetails?.introUrl ??
                              ''),
                    ),
                  )
                : Container(
                    height: HEIGHT_5 * 1,
                    width: HEIGHT_5 * 1.2,
                  ),
            SB_1W,
            Expanded(
              child: Text(
                widget.influencerInfo?.responseDetails?.workTitle ?? '',
                // widget.hiveInfo.workoutTitle!,
                style: subTitleTextStyle(context)!.copyWith(
                  fontSize: defaultSize.screenWidth * .05,
                ),
              ),
            ),
          ],
        ),
        SB_1H,
        Column(
          children: [
            (widget.influencerInfo?.responseDetails?.intro != null &&
                    widget.influencerInfo!.responseDetails!.intro!.isNotEmpty)
                ? getInfluencerDetailsItem(
                    titles[0], widget.influencerInfo!.responseDetails!.intro!)
                : Container(),
            (widget.influencerInfo?.responseDetails?.goals != null &&
                    widget.influencerInfo!.responseDetails!.goals!.isNotEmpty)
                ? getInfluencerDetailsItem(
                    titles[1], widget.influencerInfo!.responseDetails!.goals!)
                : Container(),
            (widget.influencerInfo?.responseDetails?.credentials != null &&
                    widget.influencerInfo!.responseDetails!.credentials!
                        .isNotEmpty)
                ? getInfluencerDetailsItem(titles[2],
                    widget.influencerInfo!.responseDetails!.credentials ?? "")
                : Container(),
            (widget.influencerInfo?.responseDetails?.requirements != null &&
                    widget.influencerInfo!.responseDetails!.requirements!
                        .isNotEmpty)
                ? getInfluencerDetailsItem(titles[3],
                    widget.influencerInfo!.responseDetails!.requirements!)
                : Container(),
          ],
        ),
        SB_1H,
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                SvgPicture.asset(
                  MESSAGE_SMILEY_ICON,
                  color: PRIMARY_COLOR,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: InkWell(
                      onTap: () {
                        NavRouter.push(
                            context,
                            InfluencerSuggestionScreen(
                                influencerInfo: widget.influencerInfo));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "What would you like to see?",
                            style: labelTextStyle(context)!.copyWith(
                                fontSize: 12.5.sp, fontWeight: FontWeight.w600),
                          ),
                          Text("Send me your suggestions!",
                              style: labelTextStyle(context)!.copyWith(
                                  fontSize: 10.5.sp, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: PRIMARY_COLOR,
                ),
              ],
            ),
          ),
        ),
        SB_1H,
      ],
    );
  }

  getInfluencerDetailsItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SB_1H,
        Text(
          title,
          style: headingTextStyle(context)!.copyWith(fontSize: 18.sp),
        ),
        SizedBox(
          height: defaultSize.screenHeight * .01,
        ),
        Text(
          description,
          style: labelTextStyle(context)!.copyWith(
            fontSize: 10.5.sp,
          ),
        ),
        const Divider(
          thickness: 0.5,
        ),
      ],
    );
  }
}
