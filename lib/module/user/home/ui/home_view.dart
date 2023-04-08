import 'package:app/module/influencer/workout/model/tags.dart';
import 'package:app/module/user/home/sub_screen/influencer_screen/view/influencer_details_screen.dart';
import 'package:app/module/user/tags/ui/tags_screen.dart';
import 'package:app/module/user/widgets/influencer_widgets/influencer_card.dart';
import 'package:app/utils/nav_router.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repo/data_source/local_store.dart';
import '../../../../res/color.dart';
import '../../../../res/constants.dart';
import '../../../../res/globals.dart';
import '../../../../utils/app_Icons.dart';
import '../../../influencer/dashboard/widget/top_widget.dart';
import '../../../influencer/widgets/show_snackbar.dart';
import '../../../influencer/workout/widgets/blog_detail.dart';
import '../../influencer_listing/bloc/influencer_listing_cubit.dart';
import '../../influencer_listing/ui/influencer_list_screen.dart';
import '../../influencer_workout_listing/ui/influencer_workout_screen.dart';
import '../../models/dashboard/user_dashboard_model.dart';
import '../../widgets/influencer_widgets/workout_program_card.dart';
import '../../widgets/search_edit_text.dart';
import '../../workout_program_listing/ui/workout_list_screen.dart';
import '../../workout_programs/bloc/user_workout_bloc.dart';
import '../../workout_programs/workout_program_preview.dart';
import '../home.dart';
import '../widgets/dotted_card.dart';
import '../widgets/home_view_chip.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CarouselController _controller = CarouselController();

  int selectedIndex = 0;
  int selectedChipIndex = -1;
  List<Widget> indicators = [];
  List<FeaturedInfluencers>? imgList;
  HomeViewCubit? bloc;
  String userName = 'User';

  @override
  void initState() {
    bloc = BlocProvider.of<HomeViewCubit>(context);
    bloc?.getUserDashboard();
    super.initState();
    fetchUserName();
    loadPackageDetails();
  }

  void fetchUserName() async {
    userName = await LocalStore.getData(PREFS_USERNAME);
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<HomeViewCubit, HomeViewState>(
          builder: (context, state) {
            if (state is HomeViewLoadingState) {
              SolukToast.showLoading();
            } else if (state is HomeViewEmptyState) {
              SolukToast.closeAllLoading();
              return Center(
                child: Text("No Data Found"),
              );
            } else if (state is InternetErrorState) {
              SolukToast.closeAllLoading();

              // NavRouter.push(context, WorkoutProgramPreview(workoutId: "65"));

              // NavRouter.push(
              //     context,
              //     BlocProvider(
              //       create: (_) => UserWorkoutBloc(),
              //       child: WorkoutProgramPreview(workoutId: "65"),
              //     ));

              showSnackBar(
                context,
                state.error,
                backgroundColor: Colors.black,
                textColor: Colors.white,
              );
              return Center();
            } else if (state is HomeViewLoadedState) {
              SolukToast.closeAllLoading();
              return ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 30),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child:
                        topWidget(context, name: "$userName", notification: 1),
                  ),
                  GestureDetector(
                      onTap: () {
                        NavRouter.push(context, const TagsScreen());
                      },
                      child: SearchEditText()),
                  getHeadingTextView(context, "FEATURED"),
                  CarouselSlider(
                    items: getImageSliders(state
                        .dashboardData?.responseDetails?.featuredInfluencers),
                    options: CarouselOptions(
                        enlargeCenterPage: true,
                        height: 239,
                        viewportFraction: 0.5,
                        onScrolled: (a) {
                          print("$a");
                        },
                        onPageChanged: (int index, abc) {
                          setState(() {
                            selectedIndex = index;
                          });
                          print("$index, ${abc.index}");
                        }),
                    carouselController: _controller,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: getIndicators() ?? [],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  getHeadingTextView(context, "TOP RATED INFLUENCERS",
                      topMargin: 0),
                  SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      itemCount: (state.dashboardData?.responseDetails
                                  ?.topRatedInfluencers?.length ??
                              0) +
                          1,
                      itemBuilder: (context, index) {
                        if (index ==
                            state.dashboardData?.responseDetails
                                ?.topRatedInfluencers?.length)
                          return DottedCard(
                            cardWidth: 160,
                            assetPath: Assets.dottedSquare,
                            onClick: () {
                              NavRouter.push(
                                context,
                                BlocProvider(
                                  create: (_) => InfluencerListingCubit(),
                                  child: InfluencerListScreen(
                                    isBlog: false,
                                  ),
                                ),
                              );
                            },
                          );
                        return InfluencerCard(
                            influencer: state.dashboardData?.responseDetails
                                ?.topRatedInfluencers?[index],
                            isBlog: false,
                            courseIndex: index,
                            onItemPress: () {
                              /*NavRouter.push(context, InfluencerProfile());*/

                              NavRouter.push(
                                  context,
                                  InfluencerDetailsScreen(
                                      userId: state
                                              .dashboardData
                                              ?.responseDetails
                                              ?.topRatedInfluencers?[index]
                                              .userId
                                              .toString() ??
                                          ""));
                            });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  getHeadingTextView(context, "TOP WORKOUT PLANS",
                      topMargin: 0),
                  SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      shrinkWrap: true,
                      itemCount: (state.dashboardData?.responseDetails
                                  ?.topRatedworkoutPlans?.length ??
                              0) +
                          1,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            if (index ==
                                state.dashboardData?.responseDetails
                                    ?.topRatedworkoutPlans?.length)
                              DottedCard(
                                cardWidth: 300,
                                assetPath: Assets.dottedRect,
                                onClick: () {
                                  NavRouter.push(
                                      context,
                                      BlocProvider(
                                        create: (_) => InfluencerListingCubit(),
                                        child: const WorkoutListScreen(),
                                      ));
                                },
                              )
                            else
                              WorkoutProgramCard(
                                workout: state.dashboardData!.responseDetails!
                                    .topRatedworkoutPlans![index],
                                courseIndex: 1,
                                onItemPress: () {
                                  NavRouter.push(
                                      context,
                                      WorkoutProgramPreview(
                                        workoutId: state
                                            .dashboardData!
                                            .responseDetails!
                                            .topRatedworkoutPlans![index]
                                            .id
                                            .toString(),
                                      ));
                                },
                              ),
                            SizedBox(
                              width: 8,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  getHeadingTextView(context, "LATEST BLOGS", topMargin: 0),
                  SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      itemCount: (state.dashboardData?.responseDetails
                                  ?.topViewedBlogs?.length ??
                              0) +
                          1,
                      itemBuilder: (context, index) {
                        if (index ==
                            state.dashboardData?.responseDetails?.topViewedBlogs
                                ?.length)
                          return DottedCard(
                            cardWidth: 160,
                            assetPath: Assets.dottedSquare,
                            onClick: () {
                              NavRouter.push(
                                context,
                                BlocProvider(
                                  create: (_) => InfluencerListingCubit(),
                                  child: InfluencerListScreen(
                                    isBlog: true,
                                  ),
                                ),
                              );
                            },
                          );

                        return InfluencerCard(
                            blog: state.dashboardData?.responseDetails
                                ?.topViewedBlogs?[index],
                            isBlog: true,
                            courseIndex: 1,
                            onItemPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlogDetail(
                                      blog: state.dashboardData?.responseDetails
                                          ?.topViewedBlogs?[index]),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  getHeadingTextView(context, "EXPLORE BY TAGS", topMargin: 0),
                  SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      physics: ClampingScrollPhysics(),
                      itemCount:
                          state.dashboardData?.responseDetails?.topTags?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            TagData tagData = TagData();
                            tagData.id = state.dashboardData!.responseDetails!
                                .topTags![index].id;
                            tagData.name = state.dashboardData!.responseDetails!
                                .topTags![index].name;

                            NavRouter.push(
                              context,
                              InfluencerWorkoutScreen(
                                selectedItem: tagData,
                              ),
                            );
                          },
                          child: HomeViewChip(
                            /*onClick: () {

    */ /*setState(() {
                                selectedChipIndex = index;
                              });*/ /*

                             */ /* setState(() {
                                selectedChipIndex = -1;
                              });*/ /*
                            },*/
                            isSelectedChip: selectedChipIndex == index,
                            label: state.dashboardData?.responseDetails
                                    ?.topTags?[index].name ??
                                '',
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  getHeadingTextView(BuildContext context, String title,
      {double topMargin = 40}) {
    return Padding(
      padding: EdgeInsets.only(left: 25, top: topMargin),
      child: Text(
        title,
        style: headingTextStyle(context)?.copyWith(fontSize: 16),
      ),
    );
  }

  getIndicators() {
    indicators.clear();
    for (int a = 0; a < (imgList?.length ?? 0); a++) {
      indicators.add(Row(
        children: [
          Container(
            width: selectedIndex == a
                ? defaultSize.screenWidth * .1
                : defaultSize.screenWidth * .05,
            height: defaultSize.screenHeight * .007,
            decoration: BoxDecoration(
              color: selectedIndex == a ? PRIMARY_COLOR : Colors.grey,
              borderRadius: BORDER_CIRCULAR_RADIUS,
            ),
          ),
          SizedBox(
            width: defaultSize.screenWidth * .02,
          ),
        ],
      ));
    }
    return indicators;
  }

  List<Widget> getImageSliders(List<FeaturedInfluencers>? list) {
    imgList = list;
    return imgList != null
        ? imgList!.map((item) {
            return GestureDetector(
              onTap: () {
                NavRouter.push(
                  context,
                  InfluencerDetailsScreen(
                      userId: item.influencer?.id.toString() ?? '0'),
                );
              },
              child: CarouselCard(
                singleItem: item,
              ),
            );
          }).toList()
        : [];
  }
}
