import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/fab.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/model/get_workout_plan_response.dart';
import 'package:app/module/influencer/workout_programs/view/add_workout_program.dart';
import 'package:app/module/influencer/workout_programs/view/add_workout_program_1b.dart';
import 'package:app/module/influencer/workout_programs/widgets/main_workout_program_tile.dart';
import 'package:app/module/influencer/workout_programs/workout_program_bloc/workout_program_bloc.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/model_prgress_hud.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../workout/bloc/tags_bloc/tagsbloc_cubit.dart';

class WorkoutPrograms extends StatefulWidget {
  static const id = 'WorkoutProgramScreen';

  WorkoutPrograms({
    Key? key,
  }) : super(key: key);

  @override
  State<WorkoutPrograms> createState() => _WorkoutProgramsState();
}

class _WorkoutProgramsState extends State<WorkoutPrograms> {
  String selectedTab = 'All Programs';
  late TabController _tabController;
  bool isSearching = false;
  bool isPublished = false;
  bool isUnpublished = false;
  int pageNumber = 1;
  List<WorkoutPlan> searchList = [];

  final TextEditingController _searchController = TextEditingController();

  GetWorkoutPlansResponse? getWorkoutPlansResponse;

  List<WorkoutPlan> data = [];

  late final _workoutProgramBloc;

  final _scrollController = ScrollController();

  search(String value, List<WorkoutPlan> list) {
    {
      setState(() {
        if (value.isEmpty) searchList.clear();
        isSearching = value.isEmpty ? false : true;
      });
      searchList = list
          .where((element) =>
              element.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
    TagsblocCubit _tagsBloc = BlocProvider.of(context, listen: false);
    _tagsBloc.getTags(initial: false);

    _workoutProgramBloc.add(GetWorkoutProgramsEvent(pageNumber: pageNumber));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('Load next Page');
        pageNumber++;
        _workoutProgramBloc
            .add(GetWorkoutProgramsEvent(pageNumber: pageNumber));
      }
    });
    //_tabController = TabController(vsync: this, length: 3);
  }

  Future<void> _pullRefresh() async {
    // data.clear();
    // if (getWorkoutPlansResponse != null) {
    //   getWorkoutPlansResponse!.responseDetails.totalPublished = 0;
    //   getWorkoutPlansResponse!.responseDetails.totalUnpublished = 0;
    // }
    pageNumber++;
    _workoutProgramBloc.add(GetWorkoutProgramsEvent(pageNumber: pageNumber));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkoutProgramBloc, WorkoutProgramState>(
        listener: (context, state) {
      if (state is LoadingState) {
        //data.clear();
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
      } else if (state is GetWorkoutProgramsState) {
        if (pageNumber == 1) {
          data.clear();
        }
        getWorkoutPlansResponse = state.getWorkoutPlansResponse;
        data.addAll(getWorkoutPlansResponse!.responseDetails.data);
        if (data.isNotEmpty) {
          isPublished =
              data.firstWhereOrNull((element) => element.isActive == 1) != null;
          isUnpublished =
              data.firstWhereOrNull((element) => element.isActive == 0) != null;
        }
      } else if (state is RefreshWorkoutProgramsState) {
        data.removeWhere((element) => element.id==state.id);
      }
    }, builder: (context, state) {
      return DefaultTabController(
        length: 3,
        child: ModalProgressHUD(
          inAsyncCall: state is LoadingState,
          child: Scaffold(
            backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
            body: RefreshIndicator(
              onRefresh: () => _pullRefresh(),
              child: AppBody(
                  title:
                      AppLocalisation.getTranslated(context, LKWorkoutPrograms),
                  bgColor: SCAFFOLD_BACKGROUND_COLOR,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data.isNotEmpty
                          ? TabBar(
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      AppLocalisation.getTranslated(
                                          context, LKAll),
                                      maxLines: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
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
                                ])
                          : SizedBox(),
                      data.isNotEmpty ? SB_1H : SizedBox(),
                      data.isNotEmpty
                          ? Container(
                              height: HEIGHT_3,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  defaultSize.radius(60),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultSize.screenWidth * .02,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      onChanged: (text) {
                                        search(text, data);
                                      },
                                      decoration: InputDecoration(
                                        hintText: AppLocalisation.getTranslated(
                                            context, LKSearch),
                                        hintStyle: hintTextStyle(context),
                                        border: InputBorder.none,
                                        labelStyle: hintTextStyle(context),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                              defaultSize.screenHeight * .02,
                                          horizontal:
                                              defaultSize.screenWidth * .02,
                                        ),
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: defaultSize.screenWidth * .02,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: HEIGHT_1 * 1.5,
                                      width: HEIGHT_1 * 1.5,
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.search,
                                        size: defaultSize.screenWidth * .05,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      SB_1H,
                      Expanded(
                        child: TabBarView(
                          children: [
                            getWorkoutPlansResponse != null
                                ? data.isNotEmpty
                                    ? ListView.builder(
                                        controller: _scrollController,
                                        shrinkWrap: true,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemCount:
                                            getWorkoutPlansResponse != null
                                                ? isSearching
                                                    ? searchList.length
                                                    : data.length
                                                : 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          WorkoutPlan item = isSearching
                                              ? searchList[index]
                                              : data[index];

                                          return MainWorkoutProgramTile(
                                            image: item.assetUrl ?? "",
                                            id: item.id,
                                            mediaType: item.assetType ?? "",
                                            title: item.title ?? "",
                                            details:
                                                "${item.weeksCount} Weeks - ${item.exercisesCount} Workouts",
                                            numberOfViews:
                                                item.userViews.toString(),
                                            ratting: item.rating.toString(),
                                            callback: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      AddWorkoutPrograms1b(
                                                    title: 'Workout Title',
                                                    iD: item.id,
                                                    data: item,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        AddWorkoutProgram(
                                                      isEditScreen: false,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child:
                                                  SvgPicture.asset(PLUS_ICON)),
                                          const SizedBox(height: 14),
                                          Text(
                                            AppLocalisation.getTranslated(
                                                context,
                                                LKCreateWorkoutProgram),
                                            style: subTitleTextStyle(context)
                                                ?.copyWith(
                                                    fontSize: defaultSize
                                                            .screenWidth *
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
                                      )
                                : const SizedBox.shrink(),
                            getWorkoutPlansResponse != null &&
                                    isPublished == true
                                ? Container(
                                    height: defaultSize.screenHeight * 0.7,
                                    child: ListView.builder(
                                      controller: _scrollController,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemCount: getWorkoutPlansResponse != null
                                          ? data.length
                                          : 0,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return data[index].isActive == 1
                                            ? MainWorkoutProgramTile(
                                                image:
                                                    data[index].assetUrl ?? "",
                                                mediaType:
                                                    data[index].assetType ?? "",
                                                title: data[index].title ?? "",
                                                id: data[index].id,
                                                details:
                                                    "${data[index].weeksCount} Weeks - ${data[index].exercisesCount} Workouts",
                                                numberOfViews: data[index]
                                                    .userViews
                                                    .toString(),
                                                ratting: data[index]
                                                    .rating
                                                    .toString(),
                                                callback: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          AddWorkoutPrograms1b(
                                                        title: 'Workout Title',
                                                        iD: data[index].id,
                                                        data: data[index],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            : const SizedBox.shrink();
                                      },
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalisation.getTranslated(
                                            context, LKNoPublishedProgram),
                                        style: subTitleTextStyle(context)
                                            ?.copyWith(
                                                fontSize:
                                                    defaultSize.screenWidth *
                                                        .050),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                            getWorkoutPlansResponse != null &&
                                    isUnpublished == true
                                ? SizedBox(
                                    height: defaultSize.screenHeight * 0.7,
                                    child: ListView.builder(
                                      controller: _scrollController,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemCount: getWorkoutPlansResponse != null
                                          ? data.length
                                          : 0,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return data[index].isActive != 1
                                            ? MainWorkoutProgramTile(
                                                image:
                                                    data[index].assetUrl ?? "",
                                                mediaType:
                                                    data[index].assetType ?? "",
                                                title: data[index].title ?? "",
                                                id: data[index].id,
                                                details:
                                                    "${data[index].weeksCount} Weeks - ${data[index].exercisesCount} Workouts",
                                                numberOfViews: data[index]
                                                    .userViews
                                                    .toString(),
                                                ratting: data[index]
                                                    .rating
                                                    .toString(),
                                                callback: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          AddWorkoutPrograms1b(
                                                        title: 'Workout Title',
                                                        iD: data[index].id,
                                                        data: data[index],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            : const SizedBox.shrink();
                                      },
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalisation.getTranslated(
                                            context, LKNoUnPublishedProgram),
                                        style: subTitleTextStyle(context)
                                            ?.copyWith(
                                                fontSize:
                                                    defaultSize.screenWidth *
                                                        .050),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            floatingActionButton: getWorkoutPlansResponse != null
                ? data.isNotEmpty
                    ? FAB(
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddWorkoutProgram(
                                isEditScreen: false,
                              ),
                            ),
                          );
                        },
                      )
                    : const SizedBox.shrink()
                : const SizedBox.shrink(),
          ),
        ),
      );
    });
  }
}
