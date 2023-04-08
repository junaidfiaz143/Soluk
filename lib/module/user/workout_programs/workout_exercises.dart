import 'package:app/module/user/workout_programs/full_video_player.dart';
import 'package:app/module/user/workout_programs/model/user_workout_day_exercises_model.dart';
import 'package:app/module/user/workout_programs/model/user_workout_days_model.dart';
import 'package:app/module/user/workout_programs/widgets/workout_day_tile.dart';
import 'package:app/module/user/workout_programs/workout_exercise_preview.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/default_size.dart';
import '../widgets/top_appbar_row.dart';
import 'bloc/user_workout_bloc.dart';

class WorkoutExercises extends StatefulWidget {
  // static const id = 'ProgramDetail';
  Days day;
  String title;
  WorkoutExercises({Key? key, required this.day, required this.title})
      : super(key: key);

  @override
  _WorkoutExercisesState createState() => _WorkoutExercisesState();
}

class _WorkoutExercisesState extends State<WorkoutExercises> {
  List<int> checkForFeedback = [];

  @override
  Widget build(BuildContext context) {
    UserWorkoutBloc _userWorkoutBloc = BlocProvider.of(context);
    _userWorkoutBloc.getUserWorkoutDayExercises(
        workoutDayId: widget.day.id.toString());

    return Scaffold(
        body: Column(
      children: [
        TopAppbarRow(
          title: widget.title,
        ),
        SizedBox(
          height: 2.h,
        ),
        GestureDetector(
          onTap: () {
            // NavRouter.push(context, WorkoutWeekPreview());
          },
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            padding: EdgeInsets.only(top: 30, bottom: 30, left: 15, right: 15),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.play_circle_fill,
                  color: Colors.blue,
                  size: 4.h,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    width: DefaultSize.defaultSize.width * 0.50,
                    child: Text(
                      widget.day.description ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: subTitleTextStyle(context)!
                          .copyWith(fontSize: 8.sp, color: Colors.grey),
                    ),
                  ),
                  Container(
                    width: DefaultSize.defaultSize.width * 0.50,
                    child: Text(
                      widget.day.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: subTitleTextStyle(context)!.copyWith(
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          width: double.maxFinite,
          padding:
              const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
          ),
          child: Text(
            'All Day Exercises',
            maxLines: 1,
            style: hintTextStyle(context)?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
            width: double.maxFinite,
            height: defaultSize.screenHeight * 0.7,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            child: SingleChildScrollView(
              child: StreamBuilder<UserWorkoutDayExercisesModel?>(
                  stream: _userWorkoutBloc.userWorkoutDayExercisesStream,
                  initialData: null,
                  builder: (context, snapshot) {
                    var exercises = snapshot.data?.responseDetails?.data;
                    return (exercises != null && exercises.isNotEmpty)
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: exercises.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = exercises[index];
                              if (item.myExerciseStats != null) {
                                item.myExerciseStats!.state != "completed"
                                    ? checkForFeedback.add(1)
                                    : checkForFeedback.add(0);
                              }
                              return WorkoutDayTile(
                                title: item.title ?? "",
                                description: "Exercise ${index + 1}",
                                image: item.assetUrl ?? "",
                                mediaType: item.assetType ?? "",
                                state: item.myExerciseStats != null
                                    ? item.myExerciseStats!.state!
                                    : "",
                                callback: () {
                                  NavRouter.push(
                                      context,
                                      WorkoutExercisePreview(
                                        exercise: item,
                                        title: "Exercise ${index + 1}",
                                        redirectFeedback: true,
                                        // redirectFeedback: checkForFeedback
                                        //             .length !=
                                        //         1
                                        //     ? checkForFeedback.length -
                                        //                 1 ==
                                        //             checkForFeedback
                                        //                 .where(
                                        //                     (c) => c == 1)
                                        //                 .length
                                        //         ? true
                                        //         : false
                                        //     : true
                                      )).then((value) {
                                    checkForFeedback = [];
                                    _userWorkoutBloc.getUserWorkoutDayExercises(
                                        workoutDayId: widget.day.id.toString());
                                  });
                                },
                                dayExercise: item,
                              );
                            },
                          )
                        : Center(child: Text("No Exercises Found"));
                  }),
            ),
          ),
        ),
      ],
    ));
  }
}
