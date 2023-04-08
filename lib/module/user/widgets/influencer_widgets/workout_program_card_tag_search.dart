// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:app/module/user/models/dashboard/tag_search_influencer_model.dart';
import 'package:app/module/user/models/dashboard/user_dashboard_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/thumbnail.dart';
import '../../../../res/color.dart';
import '../../../../res/globals.dart';
import '../../../influencer/workout_programs/model/get_workout_plan_response.dart';

class WorkoutProgramCardTagSearh extends StatelessWidget {
  const WorkoutProgramCardTagSearh({
    Key? key,
    required this.workout,
    required this.courseIndex,
    required this.onItemPress,
  }) : super(key: key);

  final WorkoutPlans? workout;
  final int? courseIndex;
  final Function onItemPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onItemPress();
      },
      child: SizedBox(
        width: 300,
        height: 157,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              (workout != null && workout?.assetUrl != "")
                  ? (workout?.assetType == "Image")
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            width: WIDTH_5 * 3,
                            height: HEIGHT_5 * 1.3,
                            imageUrl: workout!.assetUrl ?? "",
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  color: PRIMARY_COLOR,
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        )
                      : InkWell(
                          child: FutureBuilder<String?>(
                              future: getThumbnail(workout!.assetUrl ?? ""),
                              builder: (context, snapshot) {
                                return Container(
                                  width: WIDTH_5 * 3,
                                  height: HEIGHT_5 * 1.3,
                                  decoration: (snapshot.data ?? null) == null
                                      ? BoxDecoration(
                                          borderRadius: BORDER_CIRCULAR_RADIUS)
                                      : BoxDecoration(
                                          borderRadius: BORDER_CIRCULAR_RADIUS,
                                          image: DecorationImage(
                                            image:
                                                FileImage(File(snapshot.data!)),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                  child: Center(
                                    child: (snapshot.data ?? null) == null
                                        ? CircularProgressIndicator(
                                            color: PRIMARY_COLOR,
                                          )
                                        : Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                            size: 4.h,
                                          ),
                                  ),
                                );
                              }),
                        )
                  : SizedBox.shrink(),
              Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${workout?.title}",
                      style: headingTextStyle(context)
                          ?.copyWith(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
