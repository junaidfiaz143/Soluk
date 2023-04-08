import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/fab.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart'
    as get_exercise;
import 'package:app/module/influencer/workout_programs/view/day_detail.dart';
import 'package:app/module/influencer/workout_programs/widgets/plan_title.dart';
import 'package:app/module/influencer/workout_programs/widgets/workout_program_tile.dart';
import 'package:app/module/influencer/workout_programs/widgets/workout_type_custom_dialog.dart';
import 'package:app/module/influencer/workout_programs/widgets/workout_type_dropdown.dart';
import 'package:app/module/influencer/workout_programs/workout_program_bloc/workout_program_bloc.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/model_prgress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../model/get_week_all_days_workouts_response.dart';

class WorkoutDays extends StatefulWidget {
  static const id = 'WorkoutDays';
  final String title;
  final Data data;
  final String workoutID;
  final String weekID;

  WorkoutDays(
      {Key? key,
      required this.title,
      required this.data,
      required this.workoutID,
      required this.weekID})
      : super(key: key);

  @override
  State<WorkoutDays> createState() => _WorkoutDaysState();
}

class _WorkoutDaysState extends State<WorkoutDays> {
  late final _workoutProgramBloc;

  get_exercise.GetAllExerciseResponse? getAllExerciseResponse;

  List<get_exercise.Data> data = [];
  final _scrollController = ScrollController();

  void initState() {
    super.initState();
    print("herr");
    _workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
    _workoutProgramBloc
        .add(GetWorkoutExerciseEvent(id: widget.data.id.toString()));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('Load next Page');
        if (getAllExerciseResponse!.responseDetails!.nextPageUrl != '') {
          print('Loading next Page');
          _workoutProgramBloc.add(GetWorkoutProgramsNextBackPageEvent(
              pageUrl: getAllExerciseResponse!.responseDetails!.nextPageUrl!));
        }
      }
    });
  }

  Future<void> _pullRefresh() async {
    data.clear();
    _workoutProgramBloc
        .add(GetWorkoutExerciseEvent(id: widget.data.id.toString()));
  }

  @override
  Widget build(BuildContext context) {
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
      } else if (state is GetWorkoutExerciseState) {
        print("dATA");
        getAllExerciseResponse = state.getAllExerciseResponse;
        data.addAll(getAllExerciseResponse!.responseDetails!.data!);
        print('>>>>>>>>>>Data Length:${data.length}');
        solukLog(
            logMsg: '>>>>>>>>>>Data Length:${data.length}',
            logDetail: "workout_days");
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: AppBody(
            title: widget.data.title,
            bgColor: SCAFFOLD_BACKGROUND_COLOR,
            body: ModalProgressHUD(
              inAsyncCall: state is LoadingState,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: WorkoutProgramTile(
                        image: widget.data.assetUrl,
                        title: "Day Title ff",
                        description: widget.data.title,
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DayDetail(
                                title: 'Day Title',
                                data: widget.data,
                                workoutId: widget.workoutID,
                                weekId: widget.weekID,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      AppLocalisation.getTranslated(
                          context, LKWorkoutExercises),
                      style: subTitleTextStyle(context)?.copyWith(
                        color: Colors.black,
                        fontSize: 18.sp,
                      ),
                    ),
                    SB_1H,
                    getAllExerciseResponse != null
                        ? data.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: getAllExerciseResponse != null
                                    ? data.length
                                    : 0,
                                itemBuilder: (BuildContext context, int index) {
                                  solukLog(
                                      logMsg: "--- ${data[index].title} ---");
                                  return PlanTile(
                                    title: data[index].title,
                                    description: data[index].description,
                                    image: data[index].assetUrl,
                                    mediaType: data[index].assetType,
                                    callback: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (_) => WorkoutWeek(),
                                      //   ),
                                      // );
                                    },
                                  );
                                },
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return WorkoutTypeCustomDialog(
                                                contentWidget:
                                                    WorkoutTypeDropDown(),
                                                workoutID: widget.workoutID,
                                                weekID: widget.weekID,
                                                dayID:
                                                    widget.data.id.toString(),
                                                data: widget.data,
                                              );
                                            });
                                      },
                                      child: SvgPicture.asset(PLUS_ICON)),
                                  const SizedBox(height: 14),
                                  Text(
                                    AppLocalisation.getTranslated(
                                        context, LKCreateExercise),
                                    style: subTitleTextStyle(context)?.copyWith(
                                        fontSize:
                                            defaultSize.screenWidth * .050),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sollicitudin porttitor turpis non at nec facilisis lacus.",
                                      textAlign: TextAlign.center,
                                      style: hintTextStyle(context),
                                    ),
                                  ),
                                ],
                              )
                        : SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FAB(
          callback: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return WorkoutTypeCustomDialog(
                    contentWidget: WorkoutTypeDropDown(),
                    workoutID: widget.workoutID,
                    weekID: widget.weekID,
                    dayID: widget.data.id.toString(),
                    data: widget.data,
                  );
                });
          },
        ),
      );
    });
  }
}
