import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/module/user/home/sub_screen/influencer_insight/view/influencer_insights.dart';
import 'package:app/module/user/home/sub_screen/influencer_screen/bloc/influencer_screen_bloc_state.dart';
import 'package:app/module/user/home/sub_screen/influencer_screen/bloc/influencer_screen_cubit.dart';
import 'package:app/module/user/home/sub_screen/influencer_screen/bloc/influencer_status_bloc_state.dart';
import 'package:app/module/user/home/sub_screen/influencer_screen/bloc/influencer_status_cubit.dart';
import 'package:app/module/user/home/sub_screen/influencer_workout/view/influencer_workouts.dart';
import 'package:app/module/user/home/widgets/influencer_tabbar.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../influencer/challenges/cubit/challenges_bloc/challengesbloc_cubit.dart';
import '../../../../../influencer/widgets/info_dialog_box.dart';
import '../../influencer_about_me/view/influencer_about_me.dart';

class InfluencerDetailsScreen extends StatefulWidget {
  final String userId;

  InfluencerDetailsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<InfluencerDetailsScreen> createState() =>
      _InfluencerDetailsScreenState();
}

class _InfluencerDetailsScreenState extends State<InfluencerDetailsScreen>
    with TickerProviderStateMixin {
  late TabController _controller;

  InfluencerScreenCubit _aboutBloc = InfluencerScreenCubit();

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InfluencerStatusScreenCubit _influencerStatusBloc =
        InfluencerStatusScreenCubit();
    _influencerStatusBloc.getInfluencerFollowStatus(widget.userId);
    BlocProvider.of<ChallengesblocCubit>(context)
        .getChallengeData(isOnlyApprovedChallenges: true);

    _aboutBloc.getInfluencerData(widget.userId);
    return BlocConsumer<InfluencerScreenCubit, InfluencerblocState>(
        bloc: _aboutBloc,
        listener: (context, state) {
          if (state is InfluencerDataLoaded &&
              state.influencerModel?.responseCode == '15') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return InfoDialogBox(
                    title: "Not Found",
                    description:
                        state.influencerModel?.responseDescription ?? '',
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  );
                });
          }
        },
        builder: (context, state) {
          if (state is InfluencerblocInitial) {
            return SizedBox(
              height: HEIGHT_5 * 6,
              child: Container(
                color: backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is InfluencerDataLoaded) {
            return Container(
              color: backgroundColor,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: backgroundColor,
                  appBar: PreferredSize(
                    preferredSize:
                        Size.fromHeight(defaultSize.screenHeight * .330),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: HORIZONTAL_PADDING),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: defaultSize.screenHeight * .03,
                              ),
                              child: AppBar(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                automaticallyImplyLeading: false,
                                flexibleSpace: Center(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        top: 7,
                                        bottom: 0,
                                        child: Text(
                                          state.influencerModel?.responseDetails
                                                  ?.userInfo?.fullname ??
                                              "N/A",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          // style: headingTextStyle(context),
                                          style: subTitleTextStyle(context),
                                        ),
                                      ),
                                      Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SolukBackButton(
                                            callback: () {},
                                          ),
                                          Spacer(),
                                          BlocBuilder<
                                                  InfluencerStatusScreenCubit,
                                                  InfluencerStatusBlocState>(
                                              bloc: _influencerStatusBloc,
                                              builder: (context, state) {
                                                if (state
                                                    is InfluencerStatusBlocInitial) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: PRIMARY_COLOR,
                                                    ),
                                                  );
                                                } else if (state
                                                    is InfluencerStatusLoaded)
                                                  return InkWell(
                                                    onTap: () {
                                                      if (state.isFollowed!) {
                                                        _influencerStatusBloc
                                                            .unfollowInfluencer(
                                                                widget.userId);
                                                      } else {
                                                        _influencerStatusBloc
                                                            .followInfluencer(
                                                                widget.userId);
                                                      }
                                                    },
                                                    child: Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          (state.isFollowed!)
                                                              ? "unfollow"
                                                              : "+ Follow",
                                                          style: labelTextStyle(
                                                                  context)!
                                                              .copyWith(
                                                                  fontSize:
                                                                      10.5.sp,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                      color: PRIMARY_COLOR,
                                                    ),
                                                  );

                                                return Container();
                                              })
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                child: ClipOval(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: CachedNetworkImage(
                                    imageUrl: state.influencerModel
                                            ?.responseDetails?.imageUrl ??
                                        "",
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
                                ),
                              ),
                            ),
                            SB_1H,
                            InfluencerTab(
                              controller: _controller,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: DefaultTabController(
                      length: 3,
                      child: Container(
                        color: backgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SB_1H,
                            Expanded(
                              child: TabBarView(
                                controller: _controller,
                                children: [
                                  SingleChildScrollView(
                                    child: InfluencerWorkouts(
                                        userId: widget.userId),
                                  ),
                                  SingleChildScrollView(
                                    child: InfluencerInsights(
                                        influencerInfo: state.influencerModel),
                                  ),
                                  SingleChildScrollView(
                                    child: InfluencerAboutMe(
                                        influencerInfo: state.influencerModel),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          return Container();
        });
  }
}
