import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/module/user/profile/sub_screen/my_challenges/bloc/my_challenges_cubit.dart';
import 'package:app/module/user/profile/sub_screen/my_challenges/bloc/my_challenges_state.dart';
import 'package:app/module/user/widgets/user_challenges_title.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../utils/nav_router.dart';
import '../../../../community/view/challenges/view/community_challenges_detail_screen.dart';
import '../../../../models/community_challenges_model.dart';

class MyChallengesScreen extends StatelessWidget {
  final MyChallengesCubit myChallengesCubit =
      MyChallengesCubit(MyChallengesLoadingState());

  @override
  Widget build(BuildContext context) {
    myChallengesCubit.getMyChallengesList();
    return Scaffold(
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: AppBody(
        showBackButton: true,
        title: "My Challenges",
        body: BlocBuilder<MyChallengesCubit, MyChallengesState>(
          bloc: myChallengesCubit,
          builder: (context, state) {
            if (state is MyChallengesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            } else if (state is MyChallengesEmptyState) {
              var sp;
              return Center(
                child: Text(
                  "No Challenges found",
                  style: subTitleTextStyle(context)?.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontFamily: FONT_FAMILY),
                ),
              );
            } else if (state is MyChallengesDataLoaded) {
              return RefreshWidget(
                enablePullDown: false,
                enablePullUp: true,
                refreshController: myChallengesCubit.refreshController,
                onLoadMore: () => myChallengesCubit.onLoadMore(),
                onRefresh: () => null,
                child: ListView.builder(
                  itemBuilder: (BuildContext, index) {
                    var item = state
                        .myChallengeResponse?.responseDetails?.data![index];
                    if (item?.challengeInfo != null)
                      return UserChallengesTile(
                        mediaType: item!.challengeInfo?.assetType ?? "",
                        image: item.challengeInfo?.assetUrl ?? "",
                        title: item.challengeInfo?.title ?? "",
                        callback: () {
                          NavRouter.push(
                              context,
                              CommunityChallengeDetailScreen(
                                challengeModel: CommunityChallenge(
                                    id: item.challengeInfo?.id,
                                    userId: item.challengeInfo?.userId,
                                    title: item.challengeInfo?.title,
                                    description:
                                        item.challengeInfo?.description,
                                    badge: item.challengeInfo?.badge,
                                    winnerBy: item.challengeInfo?.winnerBy,
                                    challengeExpiry:
                                        item.challengeInfo?.challengeExpiry,
                                    challengeStatus:
                                        item.challengeInfo?.challengeStatus,
                                    state: item.challengeInfo?.state,
                                    rejectionReason:
                                        item.challengeInfo?.rejectionReason,
                                    assetUrl: item.challengeInfo?.assetUrl,
                                    assetType: item.challengeInfo?.assetType),
                              ));
                        },
                      );
                    return SizedBox.shrink();
                  },
                  itemCount: state
                          .myChallengeResponse?.responseDetails?.data?.length ??
                      0,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(5),
                  scrollDirection: Axis.vertical,
                ),
              );
            } else {
              return Center();
            }
          },
        ),
      ),
    );
  }
}
