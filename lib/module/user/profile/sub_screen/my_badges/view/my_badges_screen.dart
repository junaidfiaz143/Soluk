import 'package:app/module/influencer/challenges/challenge_const.dart/challenge_const.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/user/models/my_badges_response.dart';
import 'package:app/module/user/profile/sub_screen/my_badges/bloc/my_badges_cubit.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../bloc/my_badges_state.dart';

class MyBadgesScreen extends StatelessWidget {
  final MyBadgesCubit myBadgesCubit = MyBadgesCubit(MyBadgesLoadingState());

  @override
  Widget build(BuildContext context) {
    myBadgesCubit.getBadgesList();
    return Scaffold(
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: AppBody(
        showBackButton: true,
        title: "My Badges",
        body: BlocBuilder<MyBadgesCubit, MyBadgesState>(
          bloc: myBadgesCubit,
          builder: (context, state) {
            if (state is MyBadgesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            } else if (state is MyBadgesEmptyState) {
              return Center(
                child: Text(
                  "No Data found",
                  style: subTitleTextStyle(context)?.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 10.sp,
                  ),
                ),
              );
            } else if (state is MyBadgesDataLoaded) {
              return ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(15.0),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 3.h, left: 2.w, right: 2.w, bottom: 3.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset(SOLUK_BADGE,
                                    height: 60, width: 30),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  myBadgesCubit.badgesCountList[3].toString(),
                                  style: subTitleTextStyle(context)?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Soluk",
                                  style: labelTextStyle(context)?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.sp,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset(GOLD_BADGE,
                                    height: 60, width: 30),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  myBadgesCubit.badgesCountList[2].toString(),
                                  style: subTitleTextStyle(context)?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Gold",
                                  style: labelTextStyle(context)?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.sp,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset(BRONZE_BADGE,
                                    height: 60, width: 30),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  myBadgesCubit.badgesCountList[1].toString(),
                                  style: subTitleTextStyle(context)?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Bronze",
                                  style: labelTextStyle(context)?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.sp,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset(SILVER_BADGE,
                                    height: 60, width: 30),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  myBadgesCubit.badgesCountList[0].toString(),
                                  style: subTitleTextStyle(context)?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Silver",
                                  style: labelTextStyle(context)?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.sp,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "Badges Details",
                        style: headingTextStyle(context)?.copyWith(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 2.h, left: 2.w, right: 2.w, bottom: 3.h),
                        child: (state.myBadgesModelResponse?.responseDetails
                                    ?.userBadgeDetails?.data?.isNotEmpty ==
                                true)
                            ? GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 0),
                                itemBuilder: (_, index) {
                                  var item = state
                                      .myBadgesModelResponse
                                      ?.responseDetails
                                      ?.userBadgeDetails
                                      ?.data?[index];
                                  return createBadgeTrophy(context, item!);
                                },
                                itemCount: state
                                        .myBadgesModelResponse
                                        ?.responseDetails
                                        ?.userBadgeDetails
                                        ?.data
                                        ?.length ??
                                    0,
                              )
                            : Container(
                                height: SizerUtil.height * 0.3,
                                child: Center(
                                    child: Text(
                                  "No Badges Found",
                                  style: subTitleTextStyle(context)?.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                  ),
                                )),
                              ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Center();
            }
          },
        ),
      ),
    );
  }

  createBadgeTrophy(BuildContext context, BadgesDetailData item) {
    return Tooltip(
      message: item.actionTitle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(getBadgeIcon(item.badgeTitle.toString()),
              height: 45, width: 25),
          Text(
            item.actionType ?? "",
            style: subTitleTextStyle(context)?.copyWith(
              color: greyTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 9.sp,
            ),
          ),
          Text(
            item.actionTitle ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: subTitleTextStyle(context)?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  getBadgeIcon(String badgeTitle) {
    switch (badgeTitle) {
      case "Soluk":
        return ChallengeConst.badges['1'];

      case "Gold":
        return ChallengeConst.badges['2'];
      case "Silver":
        return ChallengeConst.badges['3'];
      case "Bronze":
        return ChallengeConst.badges['4'];
    }
  }
}
