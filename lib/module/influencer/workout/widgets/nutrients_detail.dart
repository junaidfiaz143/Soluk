import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/workout/bloc/meal_bloc/mealbloc_cubit.dart';
import 'package:app/module/influencer/workout/model/meals_modal.dart'
    as mealMod;
import 'package:app/module/influencer/workout/model/nutrients_modal.dart';
import 'package:app/module/influencer/workout/widgets/add_blog.dart';
import 'package:app/module/influencer/workout/widgets/add_nutrient.dart';
import 'package:app/module/influencer/workout/widgets/blog_detail.dart';
import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../res/constants.dart';
import '../../../common/commonbloc.dart';

class NutrientsDetail extends StatefulWidget {
  static const id = 'ProgramDetail';
  final Data? nutrientsData;

  const NutrientsDetail({Key? key, this.nutrientsData}) : super(key: key);

  @override
  State<NutrientsDetail> createState() => _NutrientsDetailState();
}

class _NutrientsDetailState extends State<NutrientsDetail> {
  @override
  Widget build(BuildContext context) {
    final _mealsBloc = BlocProvider.of<MealblocCubit>(context);
    CommonBloc commonBloc = BlocProvider.of(context);
    _mealsBloc.getMeals('${widget.nutrientsData!.id}');
    // _workoutProgramBloc.add(SubscribersListLoadingEvent());
    return SafeArea(
      child: Scaffold(body: BlocBuilder<MealblocCubit, MealblocState>(
        builder: (context, state) {
          if (state is MealsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          }
          if (state is MealsLoaded) {
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: HEIGHT_5 * 3.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              '${state.blogData?.responseDetails?.imageUrl ?? ''}'),
                          fit: BoxFit.cover,
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
                                'Nutrients Detail',
                                style: subTitleTextStyle(context)?.copyWith(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SB_2W
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          height: HEIGHT_5 * 1.3,
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
                                          'Title',
                                          maxLines: 1,
                                          style:
                                              hintTextStyle(context)?.copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${widget.nutrientsData?.title}',
                                          // '${widget.nutrientsData!.title}',
                                          maxLines: 1,
                                          style:
                                              hintTextStyle(context)?.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    commonBloc.userType == INFLUENCER
                                        ? InkWell(
                                            onTap: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => AddNutrients(
                                                          nutrientsData: widget
                                                              .nutrientsData)));
                                              // setState(() {});
                                            },
                                            child: Container(
                                              height:
                                                  defaultSize.screenWidth * .09,
                                              width:
                                                  defaultSize.screenWidth * .09,
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(30.0),
                                                  topLeft:
                                                      Radius.circular(30.0),
                                                  bottomLeft:
                                                      Radius.circular(30.0),
                                                  bottomRight:
                                                      Radius.circular(30.0),
                                                ),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.blue,
                                                  size:
                                                      defaultSize.screenWidth *
                                                          .05,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                                SB_1H,
                                Text(
                                  'Meals Plan',
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
                                Expanded(
                                  child:
                                      BlocBuilder<MealblocCubit, MealblocState>(
                                    builder: (context, state) {
                                      if (state is MealsLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.grey,
                                          ),
                                        );
                                      } else
                                      //  if(state is MealsLoaded)
                                      {
                                        return RefreshWidget(
                                          refreshController:
                                              _mealsBloc.refreshController,
                                          onLoadMore: () =>
                                              _mealsBloc.onLoadMore(
                                                  '${widget.nutrientsData!.id}'),
                                          onRefresh: () =>
                                              _mealsBloc.onRefresh(),
                                          child: GridView.count(
                                              // physics:
                                              //     const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              crossAxisCount: 2,
                                              childAspectRatio: 1.1,
                                              children: [
                                                ...List.generate(
                                                    state
                                                            .blogData
                                                            ?.responseDetails
                                                            ?.meals
                                                            ?.data
                                                            ?.length ??
                                                        0, (index) {
                                                  mealMod.Data item = state
                                                      .blogData!
                                                      .responseDetails!
                                                      .meals!
                                                      .data![index];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  BlogDetail(
                                                                      mealBlog:
                                                                          item,
                                                                      isMealBlog:
                                                                          true)));
                                                    },
                                                    child: Container(
                                                      height: HEIGHT_5 * 2,
                                                      width: HEIGHT_5 * 2,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    WIDTH_3),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                '${item.imageUrl}'),
                                                            fit: BoxFit.cover),
                                                      ),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                commonBloc.userType ==
                                                                        INFLUENCER
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          BlocProvider.of<MealblocCubit>(context)
                                                                              .delete('${item.id}');
                                                                        },
                                                                        child: Container(
                                                                            padding: EdgeInsets.all(3),
                                                                            decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0x63ffffff)),
                                                                            child: const Icon(
                                                                              Icons.close,
                                                                              size: 15,
                                                                              color: TOGGLE_BACKGROUND_COLOR,
                                                                            )),
                                                                      )
                                                                    : Container(),
                                                              ],
                                                            ),
                                                            Container(
                                                              alignment: Alignment
                                                                  .bottomLeft,
                                                              child: Text(
                                                                "${item.title}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: labelTextStyle(
                                                                        context)
                                                                    ?.copyWith(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                              ),
                                                            )
                                                          ]),
                                                    ),
                                                  );
                                                }),
                                                commonBloc.userType ==
                                                        INFLUENCER
                                                    ? SizedBox(
                                                        height: HEIGHT_5 * 2,
                                                        width: HEIGHT_5 * 2,
                                                        child:
                                                            MediaTypeSelectionCard(
                                                          callback: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => AddBlog(
                                                                        nutrientId:
                                                                            '${widget.nutrientsData!.id}',
                                                                        isMealBlog:
                                                                            true)));
                                                          },
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .add_circle,
                                                                size: WIDTH_4,
                                                                color:
                                                                    PRIMARY_COLOR,
                                                              ),
                                                              Text(
                                                                "Add Meal",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: labelTextStyle(
                                                                        context)
                                                                    ?.copyWith(
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : Container()
                                              ]),
                                        );
                                      }
                                    },
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
            );
          }
          return Container();
        },
      )),
    );
  }
}
