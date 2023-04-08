import 'package:app/module/user/widgets/influencer_widgets/workout_program_card.dart';
import 'package:app/module/user/workout_programs/workout_program_preview.dart';
import 'package:app/utils/nav_router.dart';
import 'package:app/module/user/widgets/influencer_widgets/workout_program_card_tag_search.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/nav_router.dart';
import '../../../influencer/widgets/show_snackbar.dart';
import '../../../influencer/workout_programs/model/get_workout_plan_response.dart';
import '../../../influencer/workout_programs/view/add_workout_program_1b.dart';
import '../../influencer_listing/bloc/influencer_listing_cubit.dart';
import '../../influencer_listing/bloc/influencer_listing_state.dart';
import '../../widgets/top_appbar_row.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<InfluencerListingCubit>(context).getInfluencerWorkoutList();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              TopAppbarRow(
                title: 'WORKOUT PROGRAMS',
                topHeight: 30,
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder<InfluencerListingCubit, InfluenceListingState>(
                builder: (context, state) {
                  if (state is InfluencerListingLoadingState) {
                    BotToast.showLoading();
                  } else if (state is InfluencerListingEmptyState) {
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
                  } else if (state is InfluencerListingLoadedState) {
                    BotToast.closeAllLoading();
                    return Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: List.generate(
                          state.influencerWorkoutViewAllModel?.responseDetails
                                  ?.data?.length ??
                              0,
                          (index) {
                            var workput = state.influencerWorkoutViewAllModel
                                ?.responseDetails?.data?[index];

                            //      WorkoutPlan w=WorkoutPlan(userId: workput!.userId!, id: workput.id!,assetUrl: workput.assetUrl,assetType: workput.assetType,title: workput.title);

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(24, 0, 16, 14),
                              child: WorkoutProgramCardTagSearh(
                                workout: workput,
                                courseIndex: index,
                                onItemPress: () {
                                  NavRouter.push(
                                    context,
                                    WorkoutProgramPreview(
                                        workoutId: workput!.id.toString()),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ));
  }
}
