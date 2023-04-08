import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/view/add_workout_day.dart';
import 'package:app/module/influencer/workout_programs/view/bloc/day_bloc/daybloc_bloc.dart'
    as dayBloc;
import 'package:app/module/influencer/workout_programs/view/media_screen.dart';
import 'package:app/module/influencer/workout_programs/workout_program_bloc/workout_program_bloc.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/model_prgress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/info_dialog_box.dart';
import '../model/add_workout_week_request_model.dart';
import '../model/get_week_all_days_workouts_response.dart';

class DayDetail extends StatefulWidget {
  static const id = 'DayDetail';
  final String title;
  final Data data;
  final String workoutId;
  final String weekId;

  const DayDetail(
      {Key? key,
      required this.title,
      required this.data,
      required this.workoutId,
      required this.weekId})
      : super(key: key);

  @override
  State<DayDetail> createState() => _DayDetailState();
}

class _DayDetailState extends State<DayDetail> {
  bool _switchValue = true;
  bool _loading = false;
  dayBloc.DayblocBloc? _workoutDayBloc;

  @override
  void initState() {
    _workoutDayBloc = BlocProvider.of<dayBloc.DayblocBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);

    _workoutProgramBloc.add(WorkoutPrerequisitesLoadingEvent());
    return BlocConsumer<WorkoutProgramBloc, WorkoutProgramState>(
        listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is ErrorState) {
        showSnackBar(
          context,
          state.error,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      } else if (state is InternetErrorState) {
        showSnackBar(
          context,
          state.error,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState || _loading,
        child: Scaffold(
            body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MediaScreen(
                                  videoUrl: widget.data.assetUrl,
                                  title: widget.data.title,
                                  mediaTypeisVideo:
                                      widget.data.assetType == 'Image'
                                          ? false
                                          : true,
                                )),
                      );
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: HEIGHT_5 * 3.5,
                      decoration: const BoxDecoration(
                          // image: DecorationImage(
                          //   image: AssetImage(WORKOUT_COVER2),
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                      child: CachedNetworkImage(
                        imageUrl: widget.data.assetUrl,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              color: PRIMARY_COLOR,
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SolukBackButton(
                              callback: () {},
                            ),
                            Text(
                              widget.data.title,
                              style: subTitleTextStyle(context)?.copyWith(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: defaultSize.screenWidth * .09,
                                  width: defaultSize.screenWidth * .09,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.delete_outline_outlined,
                                      color: Colors.red,
                                      size: defaultSize.screenWidth * .05,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: defaultSize.screenHeight * 0.17,
                      ),
                      Container(
                        width: double.maxFinite,
                        height: defaultSize.screenHeight * 0.7,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            topLeft: Radius.circular(30.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 15, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Day title',
                                        maxLines: 1,
                                        style: hintTextStyle(context)?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        widget.data.title,
                                        maxLines: 1,
                                        style: hintTextStyle(context)?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => AddWorkoutDay(
                                                  isEditScreen: true,
                                                  workoutId: widget.workoutId,
                                                  weekId: widget.weekId,
                                                  data: widget.data,
                                                )),
                                      );
                                    },
                                    child: Visibility(
                                      visible: true,
                                      child: Container(
                                        height: defaultSize.screenWidth * .09,
                                        width: defaultSize.screenWidth * .09,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            topLeft: Radius.circular(30.0),
                                            bottomLeft: Radius.circular(30.0),
                                            bottomRight: Radius.circular(30.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                            size: defaultSize.screenWidth * .05,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SB_1H,
                              Text(
                                AppLocalisation.getTranslated(
                                    context, LKDescription),
                                maxLines: 1,
                                style: hintTextStyle(context)?.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                widget.data.description,
                                style: hintTextStyle(context)?.copyWith(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                ),
                              ),
                              Container(
                                height: defaultSize.screenHeight * .08,
                                width: defaultSize.screenWidth,
                                margin: EdgeInsets.only(top: 16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: defaultSize.screenHeight * .025,
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: defaultSize.screenHeight * .08,
                                        width: defaultSize.screenWidth * 0.5,
                                        child: Text(
                                          AppLocalisation.getTranslated(
                                              context, LKPublished),
                                          style: subTitleTextStyle(context)
                                              ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 12.sp,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      CupertinoSwitch(
                                        value: _switchValue,
                                        activeColor: Colors.blue,
                                        onChanged: (value) async {
                                          setState(() {
                                            _loading = true;
                                          });
                                          bool? isActive =
                                              await _workoutDayBloc?.updateDay(
                                            AddWorkoutWeekRequestModel(
                                                workoutTitle: '',
                                                description: '',
                                                workoutID:
                                                    int.parse(widget.workoutId),
                                                weekID:
                                                    int.parse(widget.weekId)),
                                            widget.data.id,
                                            isActive: widget.data.isActive,
                                          );
                                          if(mounted){
                                            setState(() {
                                              _loading = false;
                                              if (isActive == true) {
                                                _switchValue = value;
                                                if (_switchValue == true) {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext context) {
                                                        return InfoDialogBox(
                                                          icon:
                                                          'assets/images/tick_ss.png',
                                                          title: AppLocalisation
                                                              .getTranslated(
                                                              context,
                                                              LKSuccessful),
                                                          description: AppLocalisation
                                                              .getTranslated(
                                                              context,
                                                              LKYourWorkoutPrgramisPublic),
                                                          onPressed: () async {
                                                            _workoutProgramBloc.add(
                                                                GetWorkoutDaysEvent(
                                                                    id: widget
                                                                        .weekId,
                                                                    workoutId: widget
                                                                        .workoutId));
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        );
                                                      });
                                                }
                                              }
                                            });
                                          }

                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        )),
      );
    });
  }
}
