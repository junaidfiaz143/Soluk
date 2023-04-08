import 'dart:io';

import 'package:app/module/influencer/widgets/image_container.dart';
import 'package:app/module/influencer/widgets/workout_tile_video_thumbnail.dart';
import 'package:app/module/user/workout_programs/model/user_workouts_model.dart';
import 'package:app/module/user/workout_programs/workout_weeks.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/enums.dart';
import '../../influencer/challenges/challenge_const.dart/challenge_const.dart';
import '../../influencer/widgets/saluk_gradient_button.dart';
import '../../influencer/widgets/show_snackbar.dart';
import '../profile/sub_screen/in_active_subscription/view/in_active_subcription_view.dart';
import '../widgets/top_appbar_row.dart';
import 'bloc/user_workout_bloc.dart';

class WorkoutProgramPreview extends StatefulWidget {
  final String workoutId;

  WorkoutProgramPreview({Key? key, required this.workoutId}) : super(key: key);

  @override
  _WorkoutWeeksState createState() => _WorkoutWeeksState();
}

class _WorkoutWeeksState extends State<WorkoutProgramPreview> {
  @override
  Widget build(BuildContext context) {
    UserWorkoutBloc _userWorkoutBloc = BlocProvider.of(context);
    _userWorkoutBloc.getUserWorkoutDetail(workoutId: widget.workoutId);

    return Scaffold(
        body: StreamBuilder<UserWorkoutsModel?>(
            stream: _userWorkoutBloc.userWorkoutDetailStream,
            initialData: null,
            builder: (context, snapshot) {
              var workout = snapshot.data?.responseDetails?.data?[0] ?? null;
              selectedWorkoutProgram = workout?.title;
              selectedWorkoutProgramId = workout?.userId;
              return snapshot.data != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TopAppbarRow(
                          title: 'Workout Program',
                        ),
                        // SizedBox(
                        //   height: 2.h,
                        // ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.0),
                              topLeft: Radius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            workout?.title ?? "",
                            textAlign: TextAlign.center,
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
                            width: double.maxFinite,
                            height: defaultSize.screenHeight * 0.7,
                            padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Container(
                                      width: defaultSize.screenWidth * 0.60,
                                      height: 25.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: workout?.assetType != "Image"
                                          ? WorkoutTileVideoThumbnail(
                                              url: workout?.assetUrl ?? "",
                                              decorated: true,
                                              playBack: workout?.assetType != "Image",
                                              height: 25.h,
                                              workoutId: widget.workoutId,
                                            )
                                          : ImageContainer(
                                              height: defaultSize.screenWidth * 0.60,
                                              path: workout!.assetUrl!,
                                              isCloseShown: false,
                                              onClose: () {}),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: defaultSize.screenWidth * 0.25,
                                          height: 11.5.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                            Text(
                                              workout?.weeksCount.toString() ?? "0",
                                              style: headingTextStyle(context)!
                                                  .copyWith(color: Colors.blue, fontSize: 32.sp),
                                            ),
                                            Text("Weeks")
                                          ]),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Container(
                                          width: defaultSize.screenWidth * 0.25,
                                          height: 11.5.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                            Text(
                                              workout?.exercisesCount.toString() ?? "0",
                                              style: headingTextStyle(context)!
                                                  .copyWith(color: Colors.blue, fontSize: 32.sp),
                                            ),
                                            Text("Workouts")
                                          ]),
                                        )
                                      ],
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      "Description",
                                      style: hintTextStyle(context)!.copyWith(fontSize: 16.sp),
                                    ),
                                  ),
                                  Text(workout?.description ?? ""),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 50.w - 20,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Completion Badge",
                                              style: hintTextStyle(context),
                                            ),
                                            SizedBox(
                                              height: .5.h,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                    height: 3.h,
                                                    child: SvgPicture.asset(
                                                        "${ChallengeConst.badges["${workout?.completionBadge}"]}")),
                                                Text('${ChallengeConst.title["${workout?.completionBadge}"]}'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50.w - 20,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Rating",
                                              style: hintTextStyle(context),
                                            ),
                                            SizedBox(
                                              height: .5.h,
                                            ),
                                            Row(
                                              children: [
                                                RatingBarIndicator(
                                                  rating: workout?.rating?.toDouble() ?? 0,
                                                  unratedColor: Colors.grey.shade400,
                                                  itemBuilder: (context, index) => Icon(
                                                    Icons.star_rounded,
                                                    color: Colors.orangeAccent,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 20.0,
                                                  direction: Axis.horizontal,
                                                ),
                                                Text("${workout?.rating ?? 0}")
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 50.w - 20,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Program Type",
                                              style: hintTextStyle(context),
                                            ),
                                            SizedBox(
                                              height: .5.h,
                                            ),
                                            Text(
                                              workout?.programType ?? "",
                                              style: TextStyle(color: Colors.blue),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50.w - 20,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Difficulty Level",
                                              style: hintTextStyle(context),
                                            ),
                                            SizedBox(
                                              height: .5.h,
                                            ),
                                            Text(workout?.difficultyLevel ?? ""),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 50.w - 20,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Views",
                                              style: hintTextStyle(context),
                                            ),
                                            SizedBox(
                                              height: .5.h,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: 3.h,
                                                  child: Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.blue,
                                                  ),
                                                  // child:
                                                  //     SvgPicture.asset("assets/svgs/gold.svg")
                                                ),
                                                SizedBox(
                                                  width: 1.w,
                                                ),
                                                Text("${workout?.views ?? "0"}"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            width: defaultSize.screenWidth,
                            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20) +
                                EdgeInsets.only(bottom: Platform.isIOS ? 12 : 0),
                            // color: Colors.white,
                            child: SizedBox(
                              width: defaultSize.screenWidth,
                              height: 50,
                              child: SalukGradientButton(
                                dim: false,
                                title: workout!.myWorkoutStats != null ? "CONTINUE" : 'START NOW',
                                style: buttonTextStyle(context)?.copyWith(fontWeight: FontWeight.w500),
                                onPressed: () async {
                                  if (workout.myWorkoutStats == null) {
                                    solukLog(logMsg: workout.myWorkoutStats);
                                    final apiRes = await _userWorkoutBloc.startUserWorkout(workout.id.toString());
                                    bool startCallenge = apiRes.status == APIStatus.success;
                                    if (!startCallenge) {
                                      if (apiRes.statusCode == 204) {
                                        showSnackBar(context, apiRes.data);
                                      } else if (apiRes.statusCode == 403) {
                                        if (!mounted) return;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => InActiveSubscriptionScreen(),
                                          ),
                                        );
                                      }
                                      return;
                                    }
                                  }

                                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                                    await NavRouter.push(context, WorkoutWeeks(userWorkout: workout)).then((value) {
                                      _userWorkoutBloc.getUserWorkoutDetail(workoutId: widget.workoutId);
                                    });
                                  });
                                  // await NavRouter.push(context,
                                  //         WorkoutWeeks(userWorkout: workout))
                                  //     .then((value) {
                                  //   _userWorkoutBloc.getUserWorkoutDetail(
                                  //       workoutId: widget.workoutId);
                                  // });

                                  print("okokokok");
                                },
                                buttonHeight: HEIGHT_2 + 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container();
            }));
  }
}
