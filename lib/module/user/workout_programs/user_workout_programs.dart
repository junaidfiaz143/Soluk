import 'package:app/module/user/workout_programs/bloc/user_workout_bloc.dart';
import 'package:app/module/user/workout_programs/workout_program_preview.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../influencer/widgets/app_body.dart';
import '../../influencer/widgets/empty_screen.dart';
import '../../influencer/workout/widgets/components/refresh_widget.dart';
import 'widgets/workout_programs_tile.dart';

class UserWorkoutPrograms extends StatefulWidget {
  String userId;

  UserWorkoutPrograms({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserWorkoutPrograms> createState() => _UserWorkoutProgramsState();
}

class _UserWorkoutProgramsState extends State<UserWorkoutPrograms> {
  @override
  Widget build(BuildContext context) {
    UserWorkoutBloc _userWorkoutBloc = BlocProvider.of(context);
    _userWorkoutBloc.getUserWorkouts(selectedInfluencerId: widget.userId);
    return Scaffold(
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: AppBody(
          bgColor: backgroundColor,
          title: "Workout Programs",
          body: Container(
            padding: EdgeInsets.only(top: 2.h),
            child: BlocBuilder<UserWorkoutBloc, UserWorkoutBlocState>(
              builder: (context, state) {
                if (state is UserWorkoutsListLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  );
                } else if (state is UserWorkoutsListEmptyState) {
                  return EmptyScreen(
                    title: "No Workouts Found",
                    callback: () {},
                    hideAddButton: true,
                  );
                } else if (state is UserWorkoutsListDataState) {
                  var workouts = state.userWorkoutsModel?.responseDetails?.data;
                  return RefreshWidget(
                    refreshController: _userWorkoutBloc.refreshController,
                    onLoadMore: () =>
                        _userWorkoutBloc.onLoadMore(widget.userId),
                    onRefresh: () => _userWorkoutBloc.onRefresh(),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: workouts?.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = workouts?[index];
                        return WorkoutProgramTile(
                          title: item?.title ?? "",
                          description: "${item?.description ?? 0} weeks",
                          image: item?.assetUrl ?? "",
                          mediaType: item?.assetType ?? "Image",
                          myWorkoutStats: item?.myWorkoutStats,
                          callback: () {
                            NavRouter.push(
                              context,
                              WorkoutProgramPreview(
                                workoutId: item?.id.toString() ?? "",
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )),
    );
  }
}
