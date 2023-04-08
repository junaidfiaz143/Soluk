import 'package:app/module/user/workout_programs/model/user_workout_week_model.dart';
import 'package:app/module/user/workout_programs/model/user_workouts_model.dart';
import 'package:app/module/user/workout_programs/widgets/workout_week_tile.dart';
import 'package:app/module/user/workout_programs/workout_days.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../widgets/top_appbar_row.dart';
import 'bloc/user_workout_bloc.dart';

class WorkoutWeeks extends StatefulWidget {
  final UserWorkout userWorkout;

  const WorkoutWeeks({Key? key, required this.userWorkout}) : super(key: key);

  @override
  WorkoutWeeksState createState() => WorkoutWeeksState();
}

class WorkoutWeeksState extends State<WorkoutWeeks> {
  @override
  Widget build(BuildContext context) {
    UserWorkoutBloc userWorkoutBloc = BlocProvider.of(context);

    userWorkoutBloc.getUserWorkoutWeeks(
        workoutId: widget.userWorkout.id.toString());

    return Scaffold(
        body: Column(
      children: [
        const TopAppbarRow(
          title: 'Workout Programs Weeks',
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 15, right: 15),
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
                Text(
                  "Program 1",
                  style: subTitleTextStyle(context)!
                      .copyWith(fontSize: 8.sp, color: Colors.grey),
                ),
                Text(
                  widget.userWorkout.title ?? "",
                  style: subTitleTextStyle(context)!.copyWith(
                    fontSize: 13.sp,
                  ),
                ),
              ])
            ],
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
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
          ),
          child: Text(
            'All Workout Weeks',
            maxLines: 1,
            style: hintTextStyle(context)?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),
        ),
        StreamBuilder<UserWorkoutWeeksModel?>(
            stream: userWorkoutBloc.userWorkoutWeeksStream,
            initialData: null,
            builder: (context, snapshot) {
              var weeks = snapshot.data?.responseDetails?.data;
              return Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
                  width: double.maxFinite,
                  height: defaultSize.screenHeight * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  child: SingleChildScrollView(
                    child: weeks != null
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: weeks.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = weeks[index];
                              return WorkoutWeekTile(
                                title: item.title ?? "",
                                description: "week ${index + 1}",
                                image: item.assetUrl ?? "",
                                mediaType: item.assetType!,
                                state: item.myWeekStats != null
                                    ? item.myWeekStats!.state!
                                    : "pending",
                                callback: () {
                                  NavRouter.push(
                                    context,
                                    WorkoutDays(
                                      week: item,
                                      title: "week ${index + 1}",
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : const Center(child: Text("No Weeks Found")),
                  ),
                ),
              );
            }),
      ],
    ));
  }
}
