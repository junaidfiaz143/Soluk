import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';
import 'package:app/module/user/models/my_workout_response.dart';
import 'package:app/module/user/profile/sub_screen/my_workouts/bloc/my_workout_cubit.dart';
import 'package:app/module/user/profile/sub_screen/my_workouts/bloc/my_workout_state.dart';
import 'package:app/module/user/widgets/my_workout_program_tile.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/nav_router.dart';
import '../../workout_programs/workout_program_preview.dart';

class MyWorkoutWidget extends StatefulWidget {
  MyWorkoutWidget({Key? key, required this.myWorkoutResponse})
      : super(key: key);
  final MyWorkoutResponse myWorkoutResponse;

  final MyWorkoutCubit myWorkoutCubit = MyWorkoutCubit(MyWorkoutLoadingState());

  @override
  State<MyWorkoutWidget> createState() => _MyWorkoutWidgetState();
}

class _MyWorkoutWidgetState extends State<MyWorkoutWidget> {
  bool isInProgressSelected = true;

  final PageController _pageController = PageController();

  void changetab(bool isApproved) {
    setState(() {
      isInProgressSelected = isApproved;
    });
    _pageController.animateToPage(isApproved ? 0 : 1,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            choiceChipWidget(context,
                title: "In Progress",
                isIncomeSelected: isInProgressSelected, onSelected: (val) {
              changetab(true);
            }),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 2.09.w),
              child: choiceChipWidget(context,
                  title: "Completed",
                  isIncomeSelected: !isInProgressSelected, onSelected: (val) {
                changetab(false);
              }),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Expanded(
            child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  if (page == 0) {
                    changetab(true);
                  } else
                    changetab(false);
                },
                children: [
              (widget.myWorkoutResponse.responseDetails
                          ?.getInProgressList()
                          .isEmpty ==
                      true)
                  ? Center(
                      child: Text(
                      'No In Progress Workouts Found',
                      style: subTitleTextStyle(context)?.copyWith(
                          fontSize: defaultSize.screenHeight * .02,
                          fontWeight: FontWeight.normal),
                    ))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      itemCount: widget.myWorkoutResponse.responseDetails
                              ?.getInProgressList()
                              .length ??
                          0,
                      itemBuilder: (context, index) {
                        if (true) {
                          var item = widget.myWorkoutResponse.responseDetails
                              ?.getInProgressList()[index];
                          return MyWorkoutProgramTile(
                            mediaType: item?.workout?.assetType ?? "",
                            image: item?.workout?.assetUrl ?? "",
                            title: item?.workout?.title ?? "",
                            details: item?.workout?.description ?? "",
                            isCompleted: false,
                            progress: (item!.progress!).toDouble(),
                            callback: () {
                              NavRouter.push(
                                  context,
                                  WorkoutProgramPreview(
                                    workoutId: item.workoutId.toString(),
                                  ));
                            },
                          );
                        }
                        return Container();
                      },
                    ),
              (widget.myWorkoutResponse.responseDetails
                          ?.getCompletedList()
                          .isEmpty ==
                      true)
                  ? Center(
                      child: Text(
                      'No Completed Workouts Found',
                      style: subTitleTextStyle(context)?.copyWith(
                          fontSize: defaultSize.screenHeight * .02,
                          fontWeight: FontWeight.normal),
                    ))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      itemCount: widget.myWorkoutResponse.responseDetails
                              ?.getCompletedList()
                              .length ??
                          0,
                      itemBuilder: (context, index) {
                        // try {
                        var item = widget.myWorkoutResponse.responseDetails
                            ?.getCompletedList()[index];
                        return MyWorkoutProgramTile(
                          mediaType: item!.workout?.assetType ?? "",
                          image: item.workout?.assetUrl ?? "",
                          title: item.workout?.title ?? "",
                          details: item.workout?.description ?? "",
                          isCompleted: true,
                          progress: 1.0,
                          callback: () {
                            NavRouter.push(
                                context,
                                WorkoutProgramPreview(
                                  workoutId: item.workoutId.toString(),
                                ));
                          },
                        );
                      },
                    ),
            ]))
      ],
    );
  }
}
