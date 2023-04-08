import 'package:app/module/influencer/challenges/cubit/participants_bloc/participants_bloc_cubit.dart';
import 'package:app/module/influencer/challenges/cubit/participants_bloc/participants_bloc_state.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:app/module/user/models/community_challenges_model.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../animations/slide_up_transparent_animation.dart';
import '../../../../../../res/constants.dart';
import '../../../../../../services/localisation.dart';
import '../../../../../influencer/more/widget/custom_alert_dialog.dart';
import '../../../../../influencer/widgets/reward_popup.dart';
import '../../../../../influencer/widgets/saluk_gradient_button.dart';
import 'community_challenger_tile_by_influencer.dart';

class CommunityParticipantsByInfluencerScreen extends StatefulWidget {
  CommunityChallenge challengeInfo;
  bool isWinnerByCommunity;

  CommunityParticipantsByInfluencerScreen(this.challengeInfo,
      {Key? key, this.isWinnerByCommunity = false})
      : super(key: key);

  @override
  State<CommunityParticipantsByInfluencerScreen> createState() =>
      _CommunityParticipantsByInfluencerScreenState();
}

class _CommunityParticipantsByInfluencerScreenState
    extends State<CommunityParticipantsByInfluencerScreen> {
  bool isParticipantsSelected = true;
  bool isRewardsSelected = false;

  final PageController _pageController = PageController();

  @override
  void initState() {
    BlocProvider.of<ParticipantsBlocCubit>(context).getParticipants(
        widget.challengeInfo.id.toString(),
        showRating: widget.isWinnerByCommunity); //
    super.initState();
  }

  void _selectParticipantChip() {
    setState(() {
      isParticipantsSelected = true;
      isRewardsSelected = false;
      if (_pageController.hasClients) {
        _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
  }

  void _selectRewardChip() {
    setState(() {
      isParticipantsSelected = false;
      isRewardsSelected = true;
      if (_pageController.hasClients) {
        _pageController.animateToPage(1,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final participantBloc = BlocProvider.of<ParticipantsBlocCubit>(context);

    return Scaffold(
      body: AppBody(
        title: AppLocalisation.getTranslated(context, LKParticipants),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                choiceChipWidget(context,
                    title: AppLocalisation.getTranslated(
                        context, LKAllParticipants),
                    isIncomeSelected: isParticipantsSelected,
                    onSelected: (val) => _selectParticipantChip()),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 2.09.w),
                  child: choiceChipWidget(
                    context,
                    title: AppLocalisation.getTranslated(context, LKRewards),
                    isIncomeSelected: isRewardsSelected,
                    onSelected: (val) => _selectRewardChip(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Expanded(
              child: BlocBuilder<ParticipantsBlocCubit, ParticipantBlocState>(
                  bloc: participantBloc,
                  builder: (context, state) {
                    if (state is ParticipantsLoading) {
                      return Center(
                          child: CircularProgressIndicator(color: Colors.grey));
                    } else if (state is ParticipantsEmpty) {
                      return Center(
                          child: Text(
                        'No challenge participants found',
                        style: subTitleTextStyle(context)?.copyWith(
                            fontSize: defaultSize.screenHeight * .02,
                            fontWeight: FontWeight.normal),
                      ));
                    } else if (state is ParticipantsLoaded) {
                      return PageView(
                        controller: _pageController,
                        onPageChanged: (page) {
                          if (page == 0) {
                            _selectParticipantChip();
                          } else {
                            _selectRewardChip();
                          }
                        },
                        children: [
                          ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            itemCount: state.participantModal?.responseDetails
                                    ?.data?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return CommunityChallengerTileByInfluencer(
                                challengeInfo: widget.challengeInfo,
                                data: state.participantModal?.responseDetails
                                        ?.data?[index] ??
                                    null,
                                onRewardFunction: (var participantId) async {
                                  var result = await participantBloc
                                      .callRewardParticipant(
                                          widget.challengeInfo.id.toString(),
                                          participantId);

                                  if (result) {
                                    navigatorKey.currentState?.push(
                                      SlideUpTransparentRoute(
                                        enterWidget: CustomAlertDialog(
                                          sigmaX: 0,
                                          sigmaY: 0,
                                          contentWidget: RewardPopUp(
                                            iconPath:
                                                'assets/images/ic_success_tick.png',
                                            title:
                                                AppLocalisation.getTranslated(
                                                    context, LKSuccessfully),
                                            content:
                                                AppLocalisation.getTranslated(
                                                    context,
                                                    LKRewardGivenSuccessfully),
                                            actionButtons: SizedBox(
                                              child: SalukGradientButton(
                                                title: AppLocalisation
                                                    .getTranslated(
                                                        context, LKDone),
                                                onPressed: () {
                                                  navigatorKey.currentState
                                                      ?.pop();
                                                  participantBloc.getParticipants(
                                                      widget.challengeInfo.id
                                                          .toString(),
                                                      showRating: widget
                                                          .isWinnerByCommunity); //
                                                },
                                                buttonHeight: HEIGHT_2 + 5,
                                              ),
                                            ),
                                          ),
                                        ),
                                        routeName: CustomAlertDialog.id,
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            itemCount: state.filterList?.length ?? 0,
                            itemBuilder: (context, index) {
                              return CommunityChallengerTileByInfluencer(
                                  challengeInfo: widget.challengeInfo,
                                  data: state.filterList?[index] ?? null);
                            },
                          ),
                        ],
                      );
                    } else
                      return Container();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
