import 'dart:io';

import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/user/community/view/challenges/view/community_submit_challenge.dart';
import 'package:app/module/user/models/community_challenges_model.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/nav_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/thumbnail.dart';
import '../../../../../../res/color.dart';
import '../../../../../../res/constants.dart';
import '../../../../../../services/localisation.dart';
import '../../../../../influencer/challenges/view/comments_screen.dart';
import '../../../../../influencer/widgets/bottom_button.dart';
import '../../../../../influencer/workout/view/video_play_screen.dart';
import '../bloc/community_challenges_cubit.dart';
import 'community_participants_and_rewards_widget.dart';

class CommunityChallengeDetailScreen extends StatefulWidget {
  static const String id = "/challengeDetail";
  final CommunityChallenge challengeModel;

  const CommunityChallengeDetailScreen({Key? key, required this.challengeModel})
      : super(key: key);

  @override
  State<CommunityChallengeDetailScreen> createState() =>
      _CommunityChallengeDetailScreenState();
}

class _CommunityChallengeDetailScreenState
    extends State<CommunityChallengeDetailScreen> {
  late CommunityChallengesCubit communityChallengesCubit;

  CommunityChallenge? challengeDetail = null;

  @override
  void initState() {
    communityChallengesCubit = BlocProvider.of(context);
    // WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  /*@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      communityChallengesCubit.userChallengeStatus(widget.challengeModel.id!);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    communityChallengesCubit.userChallengeStatus(widget.challengeModel.id!);

    return Scaffold(
      body: AppBody(
        title: AppLocalisation.getTranslated(context, LKChallenges),
        body: StreamBuilder<CommunityChallenge?>(
            stream: communityChallengesCubit.userChallengeStatusStream,
            initialData: null,
            builder: (context, snapshot) {
              var challenge = snapshot.data;
              challengeDetail = challenge;
              return SingleChildScrollView(
                child: challenge != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          (challenge.assetType == "Image")
                              ? Container(
                                  width: double.maxFinite,
                                  height: HEIGHT_5 * 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BORDER_CIRCULAR_RADIUS,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.5),
                                    //     spreadRadius: 3,
                                    //     blurRadius: 4,
                                    //     offset: const Offset(0, 3), // changes position of shadow
                                    //   ),
                                    // ],
                                    image: DecorationImage(
                                      image:
                                          AssetImage(challenge.assetUrl ?? ""),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: CachedNetworkImage(
                                    imageUrl: challenge.assetUrl ?? "",
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
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
                                            builder: (context) =>
                                                VideoPlayScreen(
                                                    videoPath:
                                                        challenge.assetUrl ??
                                                            "")));
                                  },
                                  child: FutureBuilder<String?>(
                                      future: getThumbnail(
                                          challenge.assetUrl ?? ''),
                                      builder: (context, snapshot) {
                                        print(snapshot.data ?? '');
                                        return Container(
                                          width: double.maxFinite,
                                          height: HEIGHT_5 * 2,
                                          decoration: (snapshot.data ?? null) ==
                                                  null
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
                            challenge.title ?? "",
                            style: subTitleTextStyle(context)?.copyWith(
                                fontSize: defaultSize.screenWidth * .050),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            AppLocalisation.getTranslated(
                                context, LKDescription),
                            style: hintTextStyle(context)?.copyWith(
                                fontSize: defaultSize.screenWidth * .044,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${challenge.description}',
                            style: labelTextStyle(context)?.copyWith(
                              fontSize: defaultSize.screenWidth * .040,
                            ),
                          ),
                          const SizedBox(height: 16),
                          CommunityParticipantsAndRewardWidget(
                              detail: challenge),
                          Text(
                            AppLocalisation.getTranslated(
                                context, LKChallengerValidity),
                            style: subTitleTextStyle(context)?.copyWith(
                                fontSize: defaultSize.screenWidth * .040),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${challenge.challengeExpiry}',
                            // '12 Feb, 10:30 Pm',
                            style: labelTextStyle(context)?.copyWith(
                              fontSize: defaultSize.screenWidth * .039,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(height: 1),
                          Row(
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
                                '(${challenge.commentsCount ?? 0})',
                                style: labelTextStyle(context)?.copyWith(
                                  fontSize: defaultSize.screenWidth * .040,
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () async {
                                  await NavRouter.push(
                                    context,
                                    CommentsScreen(
                                      challengeId: '${challenge.id}',
                                      userId: communityChallengesCubit.userId,
                                    ),
                                  );
                                  communityChallengesCubit.userChallengeStatus(
                                      widget.challengeModel.id!);
                                },
                                child: Text(
                                  AppLocalisation.getTranslated(
                                      context, LKAddComment),
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
                          ),
                          const Divider(height: 1),
                          const SizedBox(height: 16),
                          (challenge.participants == null ||
                                  challenge.participants!.isEmpty ||
                                  !checkIfUserIdContains(
                                      challenge.participants!))
                              ? SalukBottomButton(
                                  title: AppLocalisation.getTranslated(
                                      context, LKStartChallenge),
                                  isButtonDisabled: false,
                                  callback: () async {
                                    var res = await communityChallengesCubit
                                        .startParticipateInChallenge(
                                            widget.challengeModel.id!);
                                    if (res)
                                      NavRouter.push(
                                              context,
                                              CommunitySubmitChallenge(
                                                  challenge:
                                                      widget.challengeModel))
                                          .then((value) =>
                                              communityChallengesCubit
                                                  .userChallengeStatus(widget
                                                      .challengeModel.id!));
                                  },
                                )
                              : !isSubmited(challenge.participants!)
                                  ? SalukBottomButton(
                                      title: AppLocalisation.getTranslated(
                                          context, LKSubmitChallenge),
                                      isButtonDisabled: false,
                                      callback: () async {
                                        NavRouter.push(
                                                context,
                                                CommunitySubmitChallenge(
                                                    challenge:
                                                        challengeDetail!))
                                            .then((value) =>
                                                communityChallengesCubit
                                                    .userChallengeStatus(widget
                                                        .challengeModel.id!));
                                      },
                                    )
                                  : SizedBox.shrink(),
                        ],
                      )
                    : SizedBox.shrink(),
              );
            }),
      ),
      /*bottomNavigationBar: BottomAppBar(
        child: StreamBuilder<CommunityChallenge?>(
            stream: communityChallengesCubit.userChallengeStatusStream,
            initialData: null,
            builder: (context, snapshot) {
              var challenge = snapshot.data;
              return challenge != null
                  ? (challenge.participants == null ||
                          challenge.participants!.isEmpty ||
                          !checkIfUserIdContains(challenge.participants!))
                      ? SalukBottomButton(
                          title: AppLocalisation.getTranslated(context, LKStartChallenge),
                          isButtonDisabled: false,
                          callback: () async {
                            var res =
                                await communityChallengesCubit.startParticipateInChallenge(widget.challengeModel.id!);
                            if (res)
                              NavRouter.push(context, CommunitySubmitChallenge(challenge: widget.challengeModel));
                          },
                        )
                      : !isSubmited(challenge.participants!)
                          ? SalukBottomButton(
                              title: AppLocalisation.getTranslated(context, LKSubmitChallenge),
                              isButtonDisabled: false,
                              callback: () async {
                                NavRouter.push(context, CommunitySubmitChallenge(challenge: challengeDetail!));
                              },
                            )
                          : Container()
                  : Container();
            }),
      ),*/
    );
  }

  bool checkIfUserIdContains(List<Participants> participants) {
    var contains = false;
    participants.forEach((element) {
      if (element.participantId.toString() == communityChallengesCubit.userId) {
        contains = true;
      }
    });
    return contains;
  }

  bool isSubmited(List<Participants> participants) {
    var submitted = false;

    participants.forEach((element) {
      if (element.participantId.toString() == communityChallengesCubit.userId) {
        if (element.assetUrl != null && element.assetUrl!.isNotEmpty) {
          submitted = true;
        }
      }
    });

    /*if (participant.assetUrl != null && participant.assetUrl!.isNotEmpty) {
      return true;
    }*/
    return submitted;
  }
}
