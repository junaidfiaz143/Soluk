import 'package:app/module/user/workout_programs/bloc/user_workout_bloc.dart';
import 'package:app/module/user/workout_programs/model/user_workout_days_model.dart';
import 'package:app/module/user/workout_programs/widgets/workout_week_tile.dart';
import 'package:app/module/user/workout_programs/workout_exercises.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/default_size.dart';
import '../widgets/top_appbar_row.dart';
import 'model/user_workout_week_model.dart';

class WorkoutDays extends StatefulWidget {
  // static const id = 'ProgramDetail';
  Weeks week;
  String title;

  WorkoutDays({Key? key, required this.week, required this.title})
      : super(key: key);

  @override
  _WorkoutDaysState createState() => _WorkoutDaysState();
}

class _WorkoutDaysState extends State<WorkoutDays> {
  @override
  Widget build(BuildContext context) {
    UserWorkoutBloc _userWorkoutBloc = BlocProvider.of(context);
    _userWorkoutBloc.getUserWorkoutDays(
        workoutId: widget.week.workoutPlanId.toString(),
        weekId: widget.week.id.toString());
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
                      widget.week.description ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: subTitleTextStyle(context)!
                          .copyWith(fontSize: 8.sp, color: Colors.grey),
                    ),
                  ),
                  Container(
                    width: DefaultSize.defaultSize.width * 0.50,
                    child: Text(
                      widget.week.title ?? "",
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
            "All Week Days",
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
              child: StreamBuilder<UserWorkoutDaysModel?>(
                  stream: _userWorkoutBloc.userWorkoutDaysStream,
                  initialData: null,
                  builder: (context, snapshot) {
                    var days = snapshot.data?.responseDetails?.data;
                    return (days != null && days.isNotEmpty)
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: days.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = days[index];
                              return WorkoutWeekTile(
                                title: item.title ?? "",
                                description: "Day ${index + 1}",
                                image: item.assetUrl ?? "",
                                mediaType: item.assetType!,
                                state: item.myDayStats?.state ?? 'pending',
                                callback: () {
                                  NavRouter.push(
                                      context,
                                      WorkoutExercises(
                                          day: item,
                                          title: "Day ${index + 1}"));
                                },
                              );
                            },
                          )
                        : Center(child: Text("No Days Found in this week"));
                  }),
            ),
          ),
        ),
      ],
    ));
  }
}
