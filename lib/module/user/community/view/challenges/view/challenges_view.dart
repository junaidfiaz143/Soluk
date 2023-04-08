import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/community_header_text.dart';
import '../../../widgets/user_community_challenges_card.dart';
import '../bloc/community_challenges_cubit.dart';
import 'community_challenges_detail_screen.dart';

class ChallengesView extends StatelessWidget {
  ChallengesView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    CommunityChallengesCubit communityChallengesCubit = BlocProvider.of(context);
    communityChallengesCubit.getUserId();

    communityChallengesCubit.getCommunityChallengesList();
    return BlocBuilder<CommunityChallengesCubit, CommunityChallengesState>(
        bloc: communityChallengesCubit,
        builder: (context, state) {
          if (state is CommunityChallengesLoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: PRIMARY_COLOR,
            ));
          } else if (state is CommunityChallengesEmptyState) {
            return Center(
              child: Text(
                "No Challenges found",
                style: subTitleTextStyle(context)?.copyWith(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: FONT_FAMILY),
              ),
            );
          } else if (state is CommunityChallengesDataLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommunityHeaderText('All Challenges'),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.only(top: 8, bottom: 10),
                      itemCount: state.myChallengesResponse?.responseDetails
                              ?.data?.length ??
                          0,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 190,
                        mainAxisExtent: 190,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        var item = state.myChallengesResponse?.responseDetails
                            ?.data?[index];
                        return InkWell(
                          onTap: () {
                            NavRouter.push(
                                context,
                                CommunityChallengeDetailScreen(
                                  challengeModel: state.myChallengesResponse!
                                      .responseDetails!.data![index],
                                ));
                          },
                          child: UserCommunityChallengesCard(
                            imageUrl: item?.assetUrl ?? "",
                            title: item?.title ?? "",
                            assetType: item?.assetType??"",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else
            return Container();
        });
  }
}
