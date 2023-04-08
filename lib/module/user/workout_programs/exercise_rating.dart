import 'package:app/module/user/workout_programs/workout_program_preview.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

import '../../../res/constants.dart';
import '../../../utils/nav_router.dart';
import '../../influencer/widgets/info_dialog_box.dart';
import '../../influencer/widgets/saluk_gradient_button.dart';
import '../home/sub_screen/influencer_screen/bloc/influencer_screen_bloc_state.dart';
import '../home/sub_screen/influencer_screen/bloc/influencer_screen_cubit.dart';

class ExerciseRating extends StatelessWidget {
  ExerciseRating({required this.workoutId});

  final int? workoutId;
  double influencerRating = 3.0;
  double workoutRating = 3.0;
  InfluencerScreenCubit _aboutBloc = InfluencerScreenCubit();

  @override
  Widget build(BuildContext context) {
    _aboutBloc.getInfluencerData('$selectedWorkoutProgramId');

    return BlocConsumer<InfluencerScreenCubit, InfluencerblocState>(
        bloc: _aboutBloc,
        listener: (context, state) {
          if (state is InfluencerDataLoaded &&
              state.influencerModel?.responseCode == '15') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return InfoDialogBox(
                    title: "Not Found",
                    description:
                        state.influencerModel?.responseDescription ?? '',
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  );
                });
          }
        },
        builder: (context, state) {
          if (state is InfluencerblocInitial) {
            return SizedBox(
              height: HEIGHT_5 * 6,
              child: Container(
                color: backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is InfluencerDataLoaded) {
            return Scaffold(
              // backgroundColor: Colors.red,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Image.asset(
                          "assets/images/ic_success_tick.png",
                          scale: 2,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          "Congratulations!",
                          style: headingTextStyle(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "You have been completed Exercise 1 successfully.",
                            textAlign: TextAlign.center,
                            style: labelTextStyle(context),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 100 / 2.0),
                              child: Container(
                                width: defaultSize.screenWidth,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0)),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        state.influencerModel?.responseDetails
                                                ?.userInfo?.fullname ??
                                            'N/A',
                                        style: headingTextStyle(context)!
                                            .copyWith(fontSize: 15.sp),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text("Rate Influencer"),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      RatingBar.builder(
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        unratedColor: Colors.grey.shade300,
                                        itemSize: 25.0,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star_rounded,
                                          color: Colors.blue,
                                        ),
                                        onRatingUpdate: (double value) {
                                          influencerRating = value;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.blue, width: 2)),
                              child: Padding(
                                padding: EdgeInsets.all(00),
                                child: DecoratedBox(
                                  decoration: ShapeDecoration(
                                      shape: CircleBorder(),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            state
                                                    .influencerModel
                                                    ?.responseDetails
                                                    ?.userInfo
                                                    ?.imageUrl ??
                                                'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5',
                                          ))),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          width: defaultSize.screenWidth,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0)),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 2.5.h,
                                ),
                                Text(
                                  selectedWorkoutProgram ??
                                      "Workout Program Name",
                                  style: headingTextStyle(context)!
                                      .copyWith(fontSize: 15.sp),
                                ),
                                SizedBox(
                                  height: 2.5.h,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text("Rate Workout Program"),
                                SizedBox(
                                  height: 1.h,
                                ),
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  unratedColor: Colors.grey.shade300,
                                  itemSize: 25.0,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star_rounded,
                                    color: Colors.blue,
                                  ),
                                  onRatingUpdate: (double value) {
                                    workoutRating = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Skip",
                            style: labelTextStyle(context),
                          ),
                        ),
                        Spacer(),
                        SalukGradientButton(
                            title: "DONE",
                            onPressed: () async {
                              SolukToast.showLoading();
                              bool? ratedSuccessfully =
                                  await _aboutBloc.rateInfluencerRating(
                                      selectedWorkoutProgramId ?? 0,
                                      influencerRating,
                                      workoutId ?? 0,
                                      workoutRating);
                              SolukToast.closeAllLoading();
                              NavRouter.push(
                                  context,
                                  WorkoutProgramPreview(
                                    workoutId: this.workoutId!.toString(),
                                  ));
                            },
                            buttonHeight: 6.h)
                      ]),
                ),
              ),
            );
          }

          return Container();
        });
  }
}
// Center(
// child: Container(
// width: 100,
// height: 100,
// child: ClipOval(
// clipBehavior: Clip.antiAliasWithSaveLayer,
// child: CachedNetworkImage(
// imageUrl: state.influencerModel
//     ?.responseDetails?.imageUrl ??
// "",
// fit: BoxFit.cover,
// progressIndicatorBuilder:
// (context, url, downloadProgress) =>
// Center(
// child: CircularProgressIndicator(
// color: PRIMARY_COLOR,
// value: downloadProgress.progress),
// ),
// errorWidget: (context, url, error) =>
// Icon(Icons.error),
// ),
// ),
// ),
// ),
