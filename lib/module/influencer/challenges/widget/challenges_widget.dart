import 'package:app/module/influencer/challenges/cubit/challenges_bloc/challengesbloc_cubit.dart';
import 'package:app/module/influencer/challenges/model/challenges_modal.dart';
import 'package:app/module/influencer/challenges/model/challenges_model.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';
import '../../widgets/searchfield_with_prefixicon.dart';
import 'cards_tiles/challenges_card.dart';

class ChallengesWidget extends StatefulWidget {
  const ChallengesWidget({Key? key}) : super(key: key);

  @override
  State<ChallengesWidget> createState() => _ChallengesWidgetState();
}

class _ChallengesWidgetState extends State<ChallengesWidget> {
  bool isApprovedSelected = true;

  final PageController _pageController = PageController();

  void changetab(bool isApproved) {
    setState(() {
      isApprovedSelected = isApproved;
    });
    _pageController.animateToPage(isApproved ? 0 : 1,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  // void _selectUnapprovedChip() {
  //   setState(() {
  //     isApprovedSelected = false;
  //     _pageController.animateToPage(1,
  //         duration: const Duration(milliseconds: 500), curve: Curves.ease);
  //   });
  // }
  TextEditingController searchCont = TextEditingController();
  bool approveSearch = false;
  bool unApproveSearch = false;
  List<Data> approveSearchList = [];
  List<Data> unApproveSearchList = [];

  search(String value, List<Data> list) {
    if (isApprovedSelected) {
      setState(() {
        if (value.isEmpty) approveSearchList.clear();
        approveSearch = value.isEmpty ? false : true;
      });
      approveSearchList = list
          .where((element) =>
              element.challengeStatus == 'Approved' &&
              element.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      setState(() {
        if (value.isEmpty) unApproveSearchList.clear();
        unApproveSearch = value.isEmpty ? false : true;
      });
      unApproveSearchList = list
          .where((element) =>
              element.challengeStatus == 'Unapproved' &&
              element.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengesblocCubit, ChallengesblocState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.isOnlyApprovedChallenges == false)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  choiceChipWidget(context,
                      title: AppLocalisation.getTranslated(context, LKApproved),
                      isIncomeSelected: isApprovedSelected, onSelected: (val) {
                    searchCont.clear();
                    changetab(true);
                  }),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 2.09.w),
                    child: choiceChipWidget(context,
                        title: AppLocalisation.getTranslated(
                            context, LKUnapproved),
                        isIncomeSelected: !isApprovedSelected,
                        onSelected: (val) {
                      searchCont.clear();
                      changetab(false);
                    }),
                  ),
                ],
              ),
            const SizedBox(height: 14),
            SearchFieldWithPrefixIcon(
                controller: searchCont,
                onValueChange: (value) => search(
                    value, state.challengeData?.responseDetails?.data ?? [])),
            const SizedBox(height: 14),
            Expanded(
                child: PageView(
                    controller: _pageController,
                    onPageChanged: (page) {
                      if (page == 0) {
                        changetab(true);
                      } else
                        changetab(false);

                      // if (page == 0) {
                      //   _selectParticipantTile();
                      // } else {
                      //   _selectRewardTile();
                      // }
                    },
                    children: [
                  state.approveEmpty!
                      ? Center(
                          child: Text(
                          'No Approved Challenges Found',
                          style: subTitleTextStyle(context)?.copyWith(
                              fontSize: defaultSize.screenHeight * .02,
                              fontWeight: FontWeight.normal),
                        ))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          itemCount: approveSearch
                              ? approveSearchList.length
                              : state.challengeData?.responseDetails?.data
                                      ?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            Data item = approveSearch
                                ? approveSearchList[index]
                                : state.challengeData!.responseDetails!
                                    .data![index];
                            if (item.challengeStatus == 'Approved') {
                              return ChallengesCard(
                                challengesModel: ChallengesModel(
                                    mediaType: item.assetType!,
                                    id: item.id!,
                                    imageUrl: item.assetUrl!,
                                    name: item.title!,
                                    status: item.state == 'completed'
                                        ? 'closed'
                                        : item.state!),
                                isApproved: true,
                              );
                            }
                            return Container();
                          },
                        ),
                  state.disApproveEmpty!
                      ? Center(
                          child: Text(
                          'No Unapproved Challenges Found',
                          style: subTitleTextStyle(context)?.copyWith(
                              fontSize: defaultSize.screenHeight * .02,
                              fontWeight: FontWeight.normal),
                        ))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          itemCount: unApproveSearch
                              ? unApproveSearchList.length
                              : state.challengeData?.responseDetails?.data
                                      ?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            Data item = unApproveSearch
                                ? unApproveSearchList[index]
                                : state.challengeData!.responseDetails!
                                    .data![index];
                            if (item.challengeStatus == 'Unapproved') {
                              return ChallengesCard(
                                challengesModel: ChallengesModel(
                                    mediaType: item.assetType!,
                                    id: item.id!,
                                    imageUrl: item.assetUrl!,
                                    name: item.title!,
                                    status: item.state!),
                                isApproved: false,
                              );
                            }
                            return Container();
                          },
                        ),
                ]))
          ],
        );
      },
    );
  }
}
