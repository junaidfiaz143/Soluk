import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/fab.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/model/get_week_all_days_workouts_response.dart';
import 'package:app/module/influencer/workout_programs/model/get_workout_all_weeks_response.dart'
    as workout_week;
import 'package:app/module/influencer/workout_programs/view/add_workout_day.dart';
import 'package:app/module/influencer/workout_programs/view/bloc/day_bloc/daybloc_bloc.dart';
import 'package:app/module/influencer/workout_programs/view/week_detail.dart';
import 'package:app/module/influencer/workout_programs/view/workout_day/view/workout_days.dart';
import 'package:app/module/influencer/workout_programs/widgets/plan_title.dart';
import 'package:app/module/influencer/workout_programs/widgets/workout_program_tile.dart';
// import 'package:app/module/influencer/workout_programs/workout_program_bloc/workout_program_bloc.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/model_prgress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class WorkoutWeek extends StatefulWidget {
  static const id = 'WorkoutWeek';
  final String workoutId;
  final workout_week.Data data;

  WorkoutWeek({Key? key, required this.data, required this.workoutId})
      : super(key: key);

  @override
  State<WorkoutWeek> createState() => _WorkoutWeekState();
}

class _WorkoutWeekState extends State<WorkoutWeek>
    with SingleTickerProviderStateMixin {
  GetWeekAllDaysWorkoutsResponse? getWeekAllDaysWorkoutsResponse;
  List<Data> data = [];
  final _scrollController = ScrollController();
  late final _workoutProgramBloc;

  int selectedTabIndex = 0;

  TabController? tabController;

  @override
  void initState() {
    super.initState();

    tabController =
        TabController(length: 2, vsync: this, initialIndex: selectedTabIndex);

    tabController!.addListener(() {
      selectedTabIndex = tabController!.index;
      setState(() {
        tabController!.index;
      });
    });

    _workoutProgramBloc = BlocProvider.of<DayblocBloc>(context);
    _workoutProgramBloc.add(GetWorkoutDaysEvent(
        id: widget.data.id.toString(), workoutId: widget.workoutId));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('Load next Page');
        if (getWeekAllDaysWorkoutsResponse!.responseDetails.nextPageUrl != '') {
          print('Loading next Page');
          _workoutProgramBloc.add(GetWorkoutProgramsNextBackPageEvent(
              pageUrl:
                  getWeekAllDaysWorkoutsResponse!.responseDetails.nextPageUrl));
        }
      }
    });
    //_tabController = TabController(vsync: this, length: 3);
  }

  Future<void> _pullRefresh() async {
    data.clear();
    _workoutProgramBloc.add(GetWorkoutDaysEvent(
        id: widget.data.id.toString(), workoutId: widget.workoutId));
  }

  tabsData() {
    Widget d = getWeekAllDaysWorkoutsResponse != null
        ? data.isNotEmpty
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: getWeekAllDaysWorkoutsResponse != null
                    ? data.isNotEmpty
                        ? data.length
                        : 0
                    : 0,
                itemBuilder: (BuildContext context, int index) {
                  return PlanTile(
                    title: data[index].title,
                    description: data[index].description,
                    image: data[index].assetUrl,
                    mediaType: data[index].assetType,
                    dayId: data[index].id,
                    weekId: data[index].workoutWeekId,
                    workoutId: data[index].workoutId,
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WorkOutDaysScreen(
                            title: 'Day ${index + 1}',
                            data: data[index],
                            workoutID: widget.workoutId,
                            weekID: widget.data.id.toString(),
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
                              builder: (_) => AddWorkoutDay(
                                workoutId: widget.workoutId,
                                weekId: widget.data.id.toString(),
                                isEditScreen: false,
                              ),
                            ),
                          );
                        },
                        child: SvgPicture.asset(PLUS_ICON)),
                    const SizedBox(height: 14),
                    Text(
                      AppLocalisation.getTranslated(context, LKCreateDay),
                      style: subTitleTextStyle(context)
                          ?.copyWith(fontSize: defaultSize.screenWidth * .050),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sollicitudin porttitor turpis non at nec facilisis lacus.",
                        textAlign: TextAlign.center,
                        style: hintTextStyle(context),
                      ),
                    ),
                  ],
                ),
              )
        : const SizedBox();

    return selectedTabIndex == 0 ? d : const Center(child: Text("unPublished"));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DayblocBloc, DayblocState>(listener: (context, state) {
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
      } else if (state is GetWorkoutWeeksAllDaysState) {
        data.clear();
        getWeekAllDaysWorkoutsResponse = state.getWeekAllDaysWorkoutsResponse;
        data.addAll(getWeekAllDaysWorkoutsResponse!.responseDetails.data);
        print('>>>>>>>>>>Data Length:${data.length}');
        solukLog(logMsg: '>>>>>>>>>>Data Length:${data.length}');
      } else if (state is RefreshWorkoutDayState) {
        data.removeWhere((element) => element.id == state.dayId);
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
        body: AppBody(
            title: widget.data.title,
            bgColor: SCAFFOLD_BACKGROUND_COLOR,
            body: ModalProgressHUD(
              inAsyncCall: state is LoadingState,
              child: RefreshIndicator(
                onRefresh: _pullRefresh,
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: WorkoutProgramTile(
                          image: widget.data.assetUrl,
                          mediaType: widget.data.assetType,
                          title: "Week Title",
                          description: widget.data.title,
                          callback: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => WeekDetail(
                                  title: widget.data.title,
                                  data: widget.data,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Text(
                        AppLocalisation.getTranslated(context, LKWorkOutDays),
                        style: subTitleTextStyle(context)?.copyWith(
                          color: Colors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                      SB_1H,
                      TabBar(
                          controller: tabController,
                          labelColor: Colors.white,
                          labelStyle: labelTextStyle(context)!
                              .copyWith(fontSize: 10.sp),
                          unselectedLabelColor: Colors.black,
                          unselectedLabelStyle: labelTextStyle(context)!
                              .copyWith(fontSize: 10.sp),
                          indicator: BoxDecoration(
                              color: PRIMARY_COLOR,
                              borderRadius: BorderRadius.circular(
                                  defaultSize.screenHeight * 0.05)),
                          tabs: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                AppLocalisation.getTranslated(
                                    context, LKPublished),
                                maxLines: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                              ),
                              child: Text(
                                AppLocalisation.getTranslated(
                                    context, LKUnPublished),
                                maxLines: 1,
                              ),
                            ),
                          ]),
                      SB_1H,
                      // SizedBox(
                      //   height: 500,
                      // ),
                      tabsData(),
                      // getWeekAllDaysWorkoutsResponse != null
                      //     ? data.isNotEmpty
                      //         ? ListView.builder(
                      //             physics: const NeverScrollableScrollPhysics(),
                      //             shrinkWrap: true,
                      //             itemCount:
                      //                 getWeekAllDaysWorkoutsResponse != null
                      //                     ? data.isNotEmpty
                      //                         ? data.length
                      //                         : 0
                      //                     : 0,
                      //             itemBuilder:
                      //                 (BuildContext context, int index) {
                      //               return PlanTile(
                      //                 title: data[index].title,
                      //                 description: data[index].description,
                      //                 image: data[index].assetUrl,
                      //                 mediaType: data[index].assetType,
                      //                 callback: () {
                      //                   Navigator.push(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                       builder: (_) => WorkOutDaysScreen(
                      //                         title: 'Day ${index + 1}',
                      //                         data: data[index],
                      //                         workoutID: widget.workoutId,
                      //                         weekID: widget.data.id.toString(),
                      //                       ),
                      //                     ),
                      //                   );
                      //                 },
                      //               );
                      //             },
                      //           )
                      //         : Container(
                      //             height: defaultSize.screenHeight * .4,
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 GestureDetector(
                      //                     onTap: () {
                      //                       Navigator.push(
                      //                         context,
                      //                         MaterialPageRoute(
                      //                           builder: (_) => AddWorkoutDay(
                      //                             workoutId: widget.workoutId,
                      //                             weekId:
                      //                                 widget.data.id.toString(),
                      //                             isEditScreen: false,
                      //                           ),
                      //                         ),
                      //                       );
                      //                     },
                      //                     child: SvgPicture.asset(PLUS_ICON)),
                      //                 const SizedBox(height: 14),
                      //                 Text(
                      //                   AppLocalisation.getTranslated(
                      //                       context, LKCreateDay),
                      //                   style: subTitleTextStyle(context)
                      //                       ?.copyWith(
                      //                           fontSize:
                      //                               defaultSize.screenWidth *
                      //                                   .050),
                      //                 ),
                      //                 const SizedBox(height: 10),
                      //                 Padding(
                      //                   padding: const EdgeInsets.symmetric(
                      //                       horizontal: 20.0),
                      //                   child: Text(
                      //                     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sollicitudin porttitor turpis non at nec facilisis lacus.",
                      //                     textAlign: TextAlign.center,
                      //                     style: hintTextStyle(context),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           )
                      //     : SizedBox()
                    ],
                  ),
                ),
              ),
            )),
        floatingActionButton: getWeekAllDaysWorkoutsResponse != null
            ? data.isNotEmpty
                ? data.length < 7
                    ? FAB(
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddWorkoutDay(
                                workoutId: widget.workoutId,
                                weekId: widget.data.id.toString(),
                                isEditScreen: false,
                              ),
                            ),
                          );
                        },
                      )
                    : const SizedBox()
                : const SizedBox()
            : const SizedBox(),
      );
    });
  }
}
