import 'package:app/module/influencer/challenges/cubit/participants_bloc/participants_bloc_cubit.dart';
import 'package:app/module/influencer/challenges/cubit/participants_bloc/participants_bloc_state.dart';
import 'package:app/module/influencer/challenges/model/challenges_details_modals.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../res/constants.dart';
import '../../../../../services/localisation.dart';
import '../../widget/cards_tiles/challenge_winner_tile.dart';

class ParticipantsByCommunityScreen extends StatefulWidget {
  ChallengeModel detail;

  ParticipantsByCommunityScreen(this.detail, {Key? key}) : super(key: key);

  @override
  State<ParticipantsByCommunityScreen> createState() =>
      _ParticipantsByCommunityScreenState();
}

class _ParticipantsByCommunityScreenState
    extends State<ParticipantsByCommunityScreen> {
  bool isParticipantsSelected = true;
  bool isRewardsSelected = false;

  @override
  void initState() {
    BlocProvider.of<ParticipantsBlocCubit>(context).getParticipants(
        widget.detail.id.toString(),
        showRating: true); //widget.challengeId
    super.initState();
  }

  final PageController _pageController = PageController();

  void _selectParticipantTile() {
    setState(() {
      isParticipantsSelected = true;
      isRewardsSelected = false;
    });
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void _selectRewardTile() {
    setState(() {
      isParticipantsSelected = false;
      isRewardsSelected = true;
    });
    _pageController.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
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
                choiceChipWidget(
                  context,
                  title:
                      AppLocalisation.getTranslated(context, LKAllParticipants),
                  isIncomeSelected: isParticipantsSelected,
                  onSelected: (val) => _selectParticipantTile(),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 2.09.w),
                  child: choiceChipWidget(
                    context,
                    title: AppLocalisation.getTranslated(context, LKWinner),
                    isIncomeSelected: isRewardsSelected,
                    onSelected: (val) => _selectRewardTile(),
                  ),
                )
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
                              _selectParticipantTile();
                            } else {
                              _selectRewardTile();
                            }
                          },
                          children: [
                            ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              itemCount: state.participantModal?.responseDetails
                                      ?.data?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                var item = state.participantModal
                                    ?.responseDetails?.data?[index];
                                return ChallengeWinnerTile(
                                  data: item,
                                  challengeInfo: widget.detail,
                                );
                              },
                            ),
                            state.filterList != null &&
                                    state.filterList!.isNotEmpty
                                ? ListView.builder(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 6),
                                    itemCount: state.filterList?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return ChallengeWinnerTile(
                                        hasWonTheReward: true,
                                        challengeInfo: widget.detail,
                                        data: state.filterList?[index],
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text(
                                    'No participants win the challenge yet',
                                    style: subTitleTextStyle(context)?.copyWith(
                                        fontSize:
                                            defaultSize.screenHeight * .02,
                                        fontWeight: FontWeight.normal),
                                  )),
                          ]);
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
