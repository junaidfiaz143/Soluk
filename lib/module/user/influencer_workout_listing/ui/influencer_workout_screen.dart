import 'package:app/module/influencer/workout/model/tags.dart';
import 'package:app/module/user/widgets/influencer_widgets/influencer_card_tag_search.dart';
import 'package:app/module/user/widgets/influencer_widgets/workout_program_card_tag_search.dart';
import 'package:app/res/color.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/nav_router.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/globals.dart';
import '../../../influencer/widgets/show_snackbar.dart';
import '../../home/sub_screen/influencer_screen/view/influencer_details_screen.dart';
import '../../influencer_listing/ui/influencer_list_screen.dart';
import '../../workout_program_listing/ui/workout_list_screen.dart';
import '../../workout_programs/workout_program_preview.dart';
import '../bloc/influencer_workout_cubit.dart';
import '../bloc/influencer_workout_state.dart';

class InfluencerWorkoutScreen extends StatelessWidget {
  const InfluencerWorkoutScreen({Key? key, required this.selectedItem})
      : super(key: key);
  final TagData selectedItem;

  @override
  Widget build(BuildContext context) {
    InfluencerWorkoutCubit influencerWorkoutBloc = BlocProvider.of(context);
    influencerWorkoutBloc.getInfluencerByTagSearch(id: selectedItem.id!);

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              getAppBar(context, selectedItem.name ?? ""),
              BlocBuilder<InfluencerWorkoutCubit, InfluencerWorkoutState>(
                builder: (context, state) {
                  if (state is InfluencerWorkoutLoadingState) {
                    BotToast.showLoading();
                  } else if (state is InfluencerWorkoutEmptyState) {
                    return Center(
                      child: Text("No Data Found"),
                    );
                  } else if (state is InternetErrorState) {
                    showSnackBar(
                      context,
                      state.error,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                    return Center(
                      child: Text(state.error),
                    );
                  } else if (state is InfluencerWorkoutLoadedState) {
                    BotToast.closeAllLoading();

                    return Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                            child: Text(
                              "Search Results",
                              style: labelTextStyle(context)?.copyWith(
                                  fontSize: 16, color: AppColors.silver),
                            ),
                          ),
                          getHeading(context, "INFLUENCERS", true),
                          state.tagSearchInfluencerModel!.responseDetails!
                                      .influencersInfo!.length ==
                                  0
                              ? SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text(
                                        "No Influencer linked with this Tag"),
                                  ),
                                )
                              : GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 14,
                                  padding: EdgeInsets.fromLTRB(24, 6, 24, 30),
                                  crossAxisCount: 2,
                                  children: List.generate(
                                    state
                                                .tagSearchInfluencerModel!
                                                .responseDetails!
                                                .influencersInfo!
                                                .length >
                                            4
                                        ? 4
                                        : state
                                            .tagSearchInfluencerModel!
                                            .responseDetails!
                                            .influencersInfo!
                                            .length,
                                    (index) {
                                      return InfluencerCardTagSearch(
                                        influencer: state
                                            .tagSearchInfluencerModel!
                                            .responseDetails!
                                            .influencersInfo![index],
                                        courseIndex: index,
                                        isBlog: false,
                                        onItemPress: () {
                                          NavRouter.push(
                                              context,
                                              InfluencerDetailsScreen(
                                                  userId: state
                                                      .tagSearchInfluencerModel!
                                                      .responseDetails!
                                                      .influencersInfo![index]
                                                      .id
                                                      .toString()));
                                        },
                                      );
                                    },
                                  ),
                                ),
                          getHeading(context, "WORKOUT PROGRAMS", false),
                          SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 160,
                            child: state
                                        .tagSearchInfluencerModel
                                        ?.responseDetails
                                        ?.workoutPlans
                                        ?.length ==
                                    0
                                ? Center(
                              child: Text(
                                        "No Workout Program linked with this Tag"),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: ClampingScrollPhysics(),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    shrinkWrap: true,
                                    itemCount: (state
                                            .tagSearchInfluencerModel
                                            ?.responseDetails
                                            ?.workoutPlans
                                            ?.length) ??
                                        0,
                                    itemBuilder: (context, index) {
                                      var workput = state
                                          .tagSearchInfluencerModel
                                          ?.responseDetails
                                          ?.workoutPlans?[index];

                                      return Row(
                                        children: [
                                          WorkoutProgramCardTagSearh(
                                            workout: state
                                                .tagSearchInfluencerModel!
                                                .responseDetails!
                                                .workoutPlans![index],
                                            courseIndex: 1,
                                            onItemPress: () {
                                              NavRouter.push(
                                                  context,
                                                  WorkoutProgramPreview(
                                                      workoutId: workput!.id
                                                          .toString()));

                                              /* Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              AddWorkoutPrograms1b(
                                                title: 'Workout Title',
                                                iD: workput.id!,
                                                data: w,
                                              ),
                                        ),
                                      );*/
                                            },
                                          ),
                                          SizedBox(
                                            width: 8,
                                          )
                                        ],
                                      );
                                    },
                                  ),
                          )
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: Text(""),
                  );
                },
              ),
            ],
          ),
        ));
  }

  Widget getAppBar(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      color: AppColors.silver_bg2,
      height: 47,
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
              ),
              child: GestureDetector(
                  onTap: () {
                    NavRouter.pop(context);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    size: 30,
                  ))),
          SizedBox(
            width: 22,
          ),
          Text(
            "$title",
            style: labelTextStyle(context)
                ?.copyWith(fontSize: 16, color: AppColors.silver),
          ),
        ],
      ),
    );
  }

  getHeading(BuildContext context, String mainHeading, bool isInfluencer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$mainHeading",
            style: headingTextStyle(context)?.copyWith(fontSize: 16),
          ),
          TextButton(
            child: Row(
              children: [
                Text(
                  "VIEW ALL",
                  textAlign: TextAlign.center,
                  style: subTitleTextStyle(context)
                      ?.copyWith(fontSize: 12, color: PRIMARY_COLOR),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.arrow_forward_outlined,
                  size: 16,
                )
              ],
            ),
            onPressed: () {
              NavRouter.push(
                context,
                isInfluencer
                    ? InfluencerListScreen(
                        isBlog: false,
                      )
                    : WorkoutListScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}
