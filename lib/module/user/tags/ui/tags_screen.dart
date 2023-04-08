import 'package:app/utils/app_colors.dart';
import 'package:app/utils/nav_router.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/globals.dart';
import '../../../influencer/challenges/widget/challenge_types_chip.dart';
import '../../../influencer/widgets/show_snackbar.dart';
import '../../../influencer/workout/bloc/tags_bloc/tagsbloc_cubit.dart';
import '../../../influencer/workout/model/tags.dart';
import '../../../influencer/workout_programs/view/bloc/day_bloc/daybloc_bloc.dart';
import '../../influencer_workout_listing/ui/influencer_workout_screen.dart';

class TagsScreen extends StatelessWidget {
  const TagsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TagsblocCubit _tagsBloc = BlocProvider.of(context);
    _tagsBloc.getTags();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              getAppBar(context),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(24),
                  children: [
                    Text(
                      "Tags",
                      style: subTitleTextStyle(context)?.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<TagsblocCubit, TagsblocState>(
                      builder: (context, state) {
                        if (state is TagsblocInitial) {
                          BotToast.showLoading();
                        } else if (state is InternetErrorState) {
                          showSnackBar(
                            context,
                            "No Internet Found",
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                          );
                          return Center(
                            child: Text("No Internet Found"),
                          );
                        } else if (state is TagsLoaded) {
                          BotToast.closeAllLoading();
                          List<String> itemList = [];
                          List<TagData> tagsList =
                              state.tagsModel?.responseDetails?.data ?? [];

                          if (tagsList.isEmpty) {
                            return Center(
                              child: Text("No Tags Found"),
                            );
                          }
                          for (TagData element in tagsList) {
                            if (element.name != null) {
                              itemList.add(element.name ?? '');
                            }
                          }
                          return CustomChipsGroup(
                            isBorderStyle: true,
                            chips: itemList,
                            onItemClick: (selectedItemIndex) {
                              NavRouter.push(
                                  context,
                                  InfluencerWorkoutScreen(
                                    selectedItem:
                                        tagsList.elementAt(selectedItemIndex),
                                  ));
                            },
                          );
                        }
                        return Center(
                          child: Text("Loading..."),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget getAppBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      color: AppColors.silver_bg2,
      height: 47,
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
              ),
              child: GestureDetector(
                  onTap: () {
                    NavRouter.pop(context);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    size: 30,
                  ))),
          SizedBox(
            width: 22,
          ),
          Text(
            "Search",
            style: labelTextStyle(context)
                ?.copyWith(fontSize: 16, color: AppColors.silver),
          ),
        ],
      ),
    );
  }
}
