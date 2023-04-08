import 'dart:io';

import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/default_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../animations/slide_up_transparent_animation.dart';
import '../../../influencer/more/widget/custom_alert_dialog.dart';
import '../../../influencer/widgets/reward_popup.dart';
import '../../../influencer/widgets/workout_tile_video_thumbnail.dart';
import '../model/user_workout_day_exercises_model.dart';

class WorkoutDayTile extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String mediaType;
  final VoidCallback callback;
  final String state;
  final DayExercise dayExercise;

  const WorkoutDayTile({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    this.mediaType = "Image",
    required this.callback,
    required this.dayExercise,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            callback();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: double.maxFinite,
            height: HEIGHT_5 * 1.3,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      (dayExercise.assetType == "Image")
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: CachedNetworkImage(
                                width: WIDTH_5 * 3,
                                height: HEIGHT_5 * 1.3,
                                imageUrl: image,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                  child:
                                      CircularProgressIndicator(color: PRIMARY_COLOR, value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                callback();
                              },
                              child: SizedBox(
                                width: WIDTH_5 * 3,
                                height: HEIGHT_5 * 1.3,
                                child: WorkoutTileVideoThumbnail(
                                  url: image,
                                  playBack: false,
                                  decorated: true,
                                ),
                              ),
                            ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   height: 2.h,
                          // ),
                          Container(
                            width: DefaultSize.defaultSize.width * 0.48,
                            child: Text(
                              description,
                              overflow: TextOverflow.ellipsis,
                              style: subTitleTextStyle(context)?.copyWith(
                                color: Colors.grey,
                                fontSize: 8.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: .3.h,
                          ),
                          Container(
                            width: DefaultSize.defaultSize.width * 0.48,
                            child: Text(
                              title,
                              maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                              style: subTitleTextStyle(context)?.copyWith(
                                color: Colors.black,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: .3.h,
                          ),
                          Row(
                            children: [
                              Text(
                                dayExercise.workoutType ?? "",
                                style: subTitleTextStyle(context)
                                    ?.copyWith(color: Colors.grey, fontSize: 8.sp, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Icon(
                                Icons.repeat,
                                size: 4.w,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                getWorkoutTypeString(dayExercise),
                                style:
                                    subTitleTextStyle(context)?.copyWith(fontSize: 8.sp, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),

                          SizedBox(
                            height: .3.h,
                          ),
                          InkResponse(
                            onTap: () {
                              // _listofFiles();
                              downloadFile(
                                  dayExercise.assetUrl!,
                                  title +
                                      ":" +
                                      description +
                                      ":" +
                                      dayExercise.workoutType.toString() +
                                      ":" +
                                      getWorkoutTypeString(dayExercise) +
                                      ":" +
                                      title +
                                      "." +
                                      dayExercise.assetUrl!.split(".").last);
                              // downloadFile(
                              //     "https://pngimg.com/uploads/mario/mario_PNG53.png",
                              //     "mario_PNG53.png");
                              // NavRouter.push(context, WorkoutWeeks());
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 0, bottom: 8.0, right: 38.0),
                              child: Icon(
                                Icons.file_download,
                                size: 4.w,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SB_1W,
                      this.state == "completed"
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: defaultSize.screenWidth * .06,
                            )
                          : SizedBox.shrink()

                      // SB_1W,
                    ],
                  ),
                ]),
          ),
        ),
        SB_1H
      ],
    );
  }

  void _listofFiles() async {
    final directory = (await getApplicationDocumentsDirectory()).path;

    final file = Directory("$directory/").listSync(); //use your folder name insted of resume.
    for (var f in file) {
      if (f.toString().split("/")[6].contains("download_")) {
        print(f.toString().split("/")[6].replaceAll("\'", ""));
      }
    }
  }

  downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File("${appStorage.path}/download_$name");

    final response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes, followRedirects: false, receiveTimeout: 0),
    );
    if (response.data != null) {
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      print("downloaded");
      navigatorKey.currentState?.push(
        SlideUpTransparentRoute(
          enterWidget: CustomAlertDialog(
            sigmaX: 0,
            sigmaY: 0,
            contentWidget: RewardPopUp(
              iconPath: 'assets/images/ic_success_tick.png',
              title: "",
              actionButtons: Container(),
              content: 'Your exercises is downloaded',
            ),
          ),
          routeName: CustomAlertDialog.id,
        ),
      );
      _listofFiles();
      return true;
    } else {
      print("not downloaded");
      _listofFiles();

      return false;
    }
  }

  String getWorkoutTypeString(DayExercise exc) {
    if (exc.workoutType == "Single Workout") {
      if (exc.sets != null && exc.sets!.isNotEmpty) {
        // if (exc.sets![0].type == "Time") {
        //   return "Timebase";
        // } else {
        return "${exc.sets?.length} Sets";
        // }
      }
    } else if (exc.workoutType == "Supersets" || exc.workoutType == "Circuit") {
      if (exc.subTypes != null && exc.subTypes!.isNotEmpty) {
        if (exc.subTypes![0].subType == "timebased") {
          return "${exc.sets?.length} Exercises";
          // return "Timebase";
        } else if (exc.subTypes![0].subType == "round") {
          return "${exc.subTypes?.length} Rounds";
        }
      }
    } else if (exc.workoutType == "Long Video") {
      return solukFormatTime(exc.exerciseTime!)["time"]! + " " + solukFormatTime(exc.exerciseTime!)["type"]!;
      return exc.exerciseTime ?? "1";
    }

    return "";
  }
}
