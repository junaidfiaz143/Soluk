import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/fab.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
// import 'package:app/module/influencer/workout_programs/workout_program_bloc/workout_program_bloc.dart';

import 'package:app/module/influencer/workout_programs/model/get_workout_all_weeks_response.dart';
import 'package:app/module/influencer/workout_programs/model/get_workout_plan_response.dart'
    as workout_plan;
import 'package:app/module/influencer/workout_programs/view/add_workout_week.dart';
import 'package:app/module/influencer/workout_programs/view/bloc/week_bloc/week_bloc_bloc.dart';
import 'package:app/module/influencer/workout_programs/view/prgram_detail.dart';
import 'package:app/module/influencer/workout_programs/view/workout_weeks.dart';
import 'package:app/module/influencer/workout_programs/widgets/plan_title.dart';
import 'package:app/module/influencer/workout_programs/widgets/workout_program_tile.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/model_prgress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class AddWorkoutPrograms1b extends StatefulWidget {
  static const id = 'AddWorkoutPrograms1b';
  final String title;
  final int iD;
  final workout_plan.WorkoutPlan data;

  AddWorkoutPrograms1b(
      {Key? key, required this.title, required this.iD, required this.data})
      : super(key: key);

  @override
  State<AddWorkoutPrograms1b> createState() => _AddWorkoutPrograms1bState();
}

class _AddWorkoutPrograms1bState extends State<AddWorkoutPrograms1b> {
  GetWorkoutAllWeeksResponse? getWorkoutAllWeeksResponse;
  List<Data> data = [];
  final _scrollController = ScrollController();
  late final _workoutProgramBloc;

  void initState() {
    super.initState();
    _workoutProgramBloc = BlocProvider.of<WeekBlocBloc>(context);
    _workoutProgramBloc.add(GetWorkoutWeeksEvent(id: widget.iD.toString()));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('Load next Page');
        if (getWorkoutAllWeeksResponse!.responseDetails.nextPageUrl != '') {
          print('Loading next Page');
          _workoutProgramBloc.add(GetWorkoutProgramsNextBackPageEvent(
              pageUrl:
                  getWorkoutAllWeeksResponse!.responseDetails.nextPageUrl));
        }
      }
    });
    //_tabController = TabController(vsync: this, length: 3);
  }

  Future<void> _pullRefresh() async {
    data.clear();
    _workoutProgramBloc.add(GetWorkoutWeeksEvent(id: widget.iD.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeekBlocBloc, WeekBlocState>(
        listener: (context, state) {
      if (state is LoadingState) {
        // data.clear();
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
      } else if (state is GetWorkoutWeeksState) {
        data.clear();
        getWorkoutAllWeeksResponse = state.getWorkoutAllWeeksResponse;
        data.addAll(getWorkoutAllWeeksResponse!.responseDetails.data);
        solukLog(
            logMsg: '>>>>>>>>>>Data Length:${data.length}',
            logDetail: "add_workout_program_1b");
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
        body: AppBody(
            title: widget.data.title ?? "",
            bgColor: SCAFFOLD_BACKGROUND_COLOR,
            body: ModalProgressHUD(
              inAsyncCall: state is LoadingState,
              child: RefreshIndicator(
                onRefresh: _pullRefresh,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: WorkoutProgramTile(
                          image: widget.data.assetUrl ?? "",
                          mediaType: widget.data.assetType ?? "",
                          title: "Workout Title ",
                          description: widget.data.title ?? "",
                          callback: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProgramDetail(
                                  data: widget.data,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Text(
                        AppLocalisation.getTranslated(context, LKWorkoutWeek),
                        style: subTitleTextStyle(context)?.copyWith(
                          color: Colors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                      SB_1H,
                      getWorkoutAllWeeksResponse != null
                          ? data.isNotEmpty
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: getWorkoutAllWeeksResponse != null
                                      ? data.length
                                      : 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return PlanTile(
                                      title: data[index].title,
                                      description: data[index].description,
                                      image: data[index].assetUrl,
                                      mediaType: data[index].assetType,
                                      callback: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => WorkoutWeek(
                                              workoutId:
                                                  widget.data.id.toString(),
                                              data: data[index],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                )
                              : Container(
                                  height: defaultSize.screenHeight * .4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => AddWorkoutWeek(
                                                  isEditScreen: false,
                                                  iD: widget.iD,
                                                ),
                                              ),
                                            );
                                          },
                                          child: SvgPicture.asset(PLUS_ICON)),
                                      const SizedBox(height: 14),
                                      Text(
                                        AppLocalisation.getTranslated(
                                            context, LKCreateWeek),
                                        style: subTitleTextStyle(context)
                                            ?.copyWith(
                                                fontSize:
                                                    defaultSize.screenWidth *
                                                        .050),
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
                                  ),
                                )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            )),
        floatingActionButton: getWorkoutAllWeeksResponse != null
            ? data.isNotEmpty
                ? FAB(
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddWorkoutWeek(
                            isEditScreen: false,
                            iD: widget.iD,
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox()
            : SizedBox(),
      );
    });
  }
}
