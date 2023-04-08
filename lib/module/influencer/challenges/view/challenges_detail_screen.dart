import 'dart:io';

import 'package:app/module/influencer/challenges/cubit/challenges_detail_bloc/challengesdetailbloc_cubit.dart';
import 'package:app/module/influencer/challenges/model/challenges_details_modals.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/nav_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/thumbnail.dart';
import '../../../../repo/data_source/local_store.dart';
import '../../../../res/color.dart';
import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';
import '../../workout/view/video_play_screen.dart';
import '../widget/participants_and_rewards_widget.dart';
import 'comments_screen.dart';

class ChallengeDetailScreen extends StatefulWidget {
  static const String id = "/challengeDetail";
  final int challengeId;
  final bool isApproved;

  const ChallengeDetailScreen(
      {Key? key, required this.challengeId, required this.isApproved})
      : super(key: key);

  @override
  State<ChallengeDetailScreen> createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> {
  String userId = "";

  @override
  void initState() {
    BlocProvider.of<ChallengesdetailblocCubit>(context)
        .getChallengeData(widget.challengeId);
    getUserId();
    super.initState();
  }

  getUserId() async {
    userId = await LocalStore.getData(PREFS_USERID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
        title: AppLocalisation.getTranslated(context, LKChallenges),
        body: BlocBuilder<ChallengesdetailblocCubit, ChallengesdetailblocState>(
          builder: (context, state) {
            if (state is ChallengesDetailsLoading) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.grey));
            } else if (state is ChallengesDetailsLoaded) {
              ChallengeModel item =
                  state.blogDetailData!.responseDetails!.data![0];
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    (item.assetType == "Image")
                        ? Container(
                            width: double.maxFinite,
                            height: HEIGHT_5 * 1.5,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(item.assetUrl!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: CachedNetworkImage(
                              imageUrl: item.assetUrl!,
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
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoPlayScreen(
                                          videoPath: item.assetUrl!)));
                            },
                            child: FutureBuilder<String?>(
                                future: getThumbnail(item.assetUrl ?? ''),
                                builder: (context, snapshot) {
                                  print(snapshot.data ?? '');
                                  return Container(
                                    width: double.maxFinite,
                                    height: HEIGHT_5 * 1.5,
                                    decoration: (snapshot.data ?? null) == null
                                        ? BoxDecoration(
                                            borderRadius:
                                                BORDER_CIRCULAR_RADIUS)
                                        : BoxDecoration(
                                            borderRadius:
                                                BORDER_CIRCULAR_RADIUS,
                                            image: DecorationImage(
                                              image: FileImage(
                                                  File(snapshot.data!)),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                    child: Center(
                                      child: Icon(
                                        Icons.play_circle_fill,
                                        color: Colors.white,
                                        size: 4.h,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                    const SizedBox(height: 14),
                    Text(
                      item.title!,
                      style: subTitleTextStyle(context)
                          ?.copyWith(fontSize: defaultSize.screenWidth * .050),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalisation.getTranslated(context, LKDescription),
                      style: hintTextStyle(context)?.copyWith(
                          fontSize: defaultSize.screenWidth * .044,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${item.description}',
                      style: labelTextStyle(context)?.copyWith(
                        fontSize: defaultSize.screenWidth * .040,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ParticipantsAndRewardWidget(
                      detail: item,
                      isApproved: widget.isApproved,
                    ),
                    Text(
                      AppLocalisation.getTranslated(
                          context, LKChallengerValidity),
                      style: subTitleTextStyle(context)
                          ?.copyWith(fontSize: defaultSize.screenWidth * .040),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item.challengeExpiry}',
                      // '12 Feb, 10:30 Pm',
                      style: labelTextStyle(context)?.copyWith(
                        fontSize: defaultSize.screenWidth * .039,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    widget.isApproved
                        ? Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  /*     NavRouter.push(
                            context,
                             CommentsScreen(challengeId: '${item.id}'),
                          );*/
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            AppLocalisation.getTranslated(
                                                context, LKComments),
                                            style: subTitleTextStyle(context)
                                                ?.copyWith(
                                                    fontSize: defaultSize
                                                            .screenWidth *
                                                        .050),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 1,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                '(${item.commentsCount})',
                                style: labelTextStyle(context)?.copyWith(
                                  fontSize: defaultSize.screenWidth * .040,
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  // Fluttertoast.showToast(
                                  //     msg:
                                  //         "${item.title} is currently under review by Admin",
                                  //     toastLength: Toast.LENGTH_SHORT,
                                  //     gravity: ToastGravity.BOTTOM,
                                  //     timeInSecForIosWeb: 1,
                                  //     backgroundColor: Colors.red,
                                  //     textColor: Colors.yellow);

                                  /*  Fluttertoast.showToast(
                                msg: "${item.title} is currently under review by Admin",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.yellow
                            );*/

                                  NavRouter.push(
                                    context,
                                    CommentsScreen(
                                      challengeId: '${item.id}',
                                      userId: userId,
                                    ),
                                  );
                                },
                                child: Text(
                                  "View comments",
                                  style: labelTextStyle(context)?.copyWith(
                                      fontSize: defaultSize.screenWidth * .036,
                                      color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    )),
                              )
                            ],
                          )
                        : Container(),
                    const Divider(height: 1),
                    const SizedBox(height: 16),
                    if (item.state?.toLowerCase() == "rejected")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalisation.getTranslated(
                                context, LKRejectionReason),
                            style: subTitleTextStyle(context)?.copyWith(
                                fontSize: defaultSize.screenWidth * .040,
                                color: Colors.red),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${item.rejectionReason}',
                            // '12 Feb, 10:30 Pm',
                            style: labelTextStyle(context)?.copyWith(
                                fontSize: defaultSize.screenWidth * .039,
                                color: Colors.red),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
