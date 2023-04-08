import 'package:app/module/influencer/challenges/model/participant_modal.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/user/community/view/challenges/bloc/community_challenges_cubit.dart';
import 'package:app/module/user/models/community_challenges_model.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../res/color.dart';
import '../../../../../../services/localisation.dart';
import '../../../../../../utils/c_date_format.dart';
import '../../../../../influencer/challenges/widget/challenger_widgets/reward_widget.dart';
import '../../../../../influencer/widgets/workout_tile_video_thumbnail.dart';
import '../../../../../influencer/workout_programs/view/media_screen.dart';
import '../../../../widgets/text_view.dart';

class CommunityParticipantsByCommunityDetailsScreen extends StatelessWidget {
  static const String id = "/challenger_detail";
  final bool hasWonTheReward;
  DataParticipant? data;
  CommunityChallenge? challengeData;

  CommunityParticipantsByCommunityDetailsScreen(
      {Key? key, this.hasWonTheReward = false, this.data, this.challengeData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommunityChallengesCubit communityChallengesCubit =
        BlocProvider.of(context);

    communityChallengesCubit.verifyUserRatedByCurrentUSer(
        challengeData!.id!, data!.participantId!);
    var ratingCount = 1.0;
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
                            imageUrl: data?.participant?.imageUrl ?? "",
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
                challengeData?.description ?? "",
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
                        '${CDateFormat.returnMonthDayYear(data!.completedAt!)}',
                        style: hintTextStyle(context)?.copyWith(
                            fontSize: defaultSize.screenWidth * .034),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: double.parse(data?.UserRating ?? '0.0'),
                            itemBuilder: (context, index) => Icon(
                              Icons.star_rounded,
                              color: Color(0xff498AEE),
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(width: 6),
                          Text(
                            data?.UserRating ?? '0.0',
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(
                        AppLocalisation.getTranslated(context, LKRating),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (hasWonTheReward) RewardWidget(challengeData?.badge ?? ""),
              if (data?.participantId.toString() !=
                  communityChallengesCubit.userId)
                StreamBuilder<bool>(
                    stream: communityChallengesCubit.verifyUSerRatingStream,
                    initialData: true,
                    builder: (context, snapshot) {
                      return !(snapshot.data!)
                          ? Material(
                              elevation: 10,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextView(
                                      "Rate this challenger",
                                      fontSize: 16,
                                    ),
                                    SizedBox(height: 6),
                                    /*TextView(
                            "0.0",
                            fontSize: 16,
                          ),
                          SizedBox(height: 6),*/
                                    RatingBar.builder(
                                      initialRating: 1,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.blue,
                                      ),
                                      onRatingUpdate: (rating) {
                                        ratingCount = rating;
                                      },
                                    ),
                                    SizedBox(height: 6),
                                    Container(
                                      height: 30,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: TextButton(
                                        onPressed: () async {
                                          bool? isSuccess =
                                              await communityChallengesCubit
                                                  .rateParticipent(
                                                      challengeData!.id!,
                                                      data!.participantId!,
                                                      data!.cpId!,
                                                      ratingCount);

                                          if (isSuccess == true) {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50),
                                          side: BorderSide(
                                              color: PRIMARY_COLOR, width: 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Text(
                                          "Done",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container();
                    })
            ],
          ),
        ));
  }
}
