import 'package:app/module/influencer/widgets/workout_tile_video_thumbnail.dart';
import 'package:app/module/user/workout_programs/full_video_player.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/nav_router.dart';
import '../../influencer/widgets/choice_chip_widget.dart';
import '../../influencer/widgets/saluk_transparent_button.dart';
import '../widgets/top_appbar_row.dart';

class WorkoutWeekPreview extends StatefulWidget {
  const WorkoutWeekPreview({Key? key}) : super(key: key);

  @override
  _WorkoutWeeksState createState() => _WorkoutWeeksState();
}

class _WorkoutWeeksState extends State<WorkoutWeekPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.grey.shade200,
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopAppbarRow(
          title: 'Exercise 1',
          actionWidget: SalukTransparentButton(
              borderColor: Colors.grey.shade200,
              buttonColor: Colors.white,
              title: "",
              onPressed: () {
                // NavRouter.push(
                //   context,
                //   FullVideoPlayer(exercise: null,),
                // );
              },
              icon: Icon(
                Icons.timer_outlined,
                color: Colors.blue,
                size: defaultSize.screenWidth * .05,
              ),
              borderRadius: BorderRadius.circular(10),
              buttonWidth: defaultSize.screenWidth * .09,
              buttonHeight: defaultSize.screenWidth * .09),
        ),
        // SizedBox(
        //   height: 2.h,
        // ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          width: double.maxFinite,
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
          decoration: BoxDecoration(
            // color: Colors.grey.shade200,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
          ),
          child: Text(
            'Exercise Title , Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            textAlign: TextAlign.justify,
            // maxLines: 1,
            style: hintTextStyle(context)?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: choiceChipWidget(context,
              title: "Single Workout",
              isIncomeSelected: true,
              onSelected: (val) {}),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Text("Ex Time: 3 min"),
              Spacer(),
              Icon(
                Icons.repeat,
                size: 6.w,
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                "3 Sets",
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: double.maxFinite,
            height: defaultSize.screenHeight * 0.7,
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
                // color: Colors.grey.shade200,
                ),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: defaultSize.screenWidth * 0.78,
                    height: 18.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: WorkoutTileVideoThumbnail(
                      url:
                          "https://soluk.app/storage/images/workoutplan/workout_plan-61-1653927910.mp4",
                      decorated: true,
                      playBack: true,
                      height: 25.h,
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Container(
                    width: defaultSize.screenWidth * 0.06,
                    child: Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                        size: defaultSize.screenWidth * .06,
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Workout Sets",
                  style: labelTextStyle(context)!.copyWith(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, builder) {
                        // return Text("kk");
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 25.w,
                                  child: Text(
                                    builder == 0
                                        ? "Set ${builder + 1} (Dropset)"
                                        : "Set ${builder + 1}",
                                    style: TextStyle(
                                        color: builder == 0
                                            ? Colors.blue
                                            : Colors.black),
                                  )),
                              SizedBox(
                                  width: 25.w,
                                  child: Text("10 Reps",
                                      style: TextStyle(
                                          color: builder == 0
                                              ? Colors.blue
                                              : Colors.black))),
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  color: Colors.grey.withOpacity(0.5),
                  width: 100.w,
                  height: 1,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Rest Time",
                  style: labelTextStyle(context)!.copyWith(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: Colors.blue,
                        size: defaultSize.screenWidth * .06,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text("10s Rest")
                    ],
                  ),
                )
              ],
            )),
          ),
        ),
      ],
    ));
  }
}
