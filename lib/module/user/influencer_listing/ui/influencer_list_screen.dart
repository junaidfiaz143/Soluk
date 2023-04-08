import 'package:app/module/user/home/sub_screen/influencer_screen/view/influencer_details_screen.dart';
import 'package:app/module/user/widgets/influencer_widgets/influencer_card_tag_search.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/nav_router.dart';
import '../../../influencer/widgets/show_snackbar.dart';
import '../../widgets/influencer_widgets/influencer_card.dart';
import '../../widgets/top_appbar_row.dart';
import '../bloc/influencer_listing_cubit.dart';
import '../bloc/influencer_listing_state.dart';

class InfluencerListScreen extends StatelessWidget {
  InfluencerListScreen({Key? key, required this.isBlog})
      : super(key: key);

  final bool isBlog;

  @override
  Widget build(BuildContext context) {
    InfluencerListingCubit _influencerListingCubit=BlocProvider.of(context);
    // BlocProvider.of<InfluencerListingCubit>(context).getInfluencerWorkoutList();
    _influencerListingCubit.isBlog=isBlog;
    if(isBlog){
      _influencerListingCubit.getInfluencerBlogsList();
    }else{
      _influencerListingCubit.getInfluencersList();
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              TopAppbarRow(
                title: isBlog ? 'BLOGS' : 'INFLUENCERS',
                topHeight: 30,
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder<InfluencerListingCubit, InfluenceListingState>(
                builder: (context, state) {
                  if (state is InfluencerListingLoadingState) {
                    BotToast.showLoading();
                  }
                  else if (state is InfluencerListingEmptyState) {
                    return Center(
                      child: Text("No Data Found"),
                    );
                  }
                  else if (state is InternetErrorState) {
                    showSnackBar(
                      context,
                      state.error,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  else if (state is InfluencerListingLoadedState) {
                    BotToast.closeAllLoading();
                    return Expanded(
                      child: SingleChildScrollView(
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 14,
                          padding: EdgeInsets.fromLTRB(24, 10, 24, 30),
                          crossAxisCount: 2,
                          children: List.generate(
                            isBlog
                                ? (state.influencerBlogsViewAllModel?.responseDetails
                                        ?.data?.length ??
                                    0)
                                : state.influencerViewAllModel?.responseDetails
                                        ?.data?.length ??
                                    0,
                            (index) {
                              return InfluencerCardTagSearch(
                                influencer: isBlog
                                    ? null
                                    : state
                                        .influencerViewAllModel
                                        ?.responseDetails
                                        ?.data?[index],
                                blog: isBlog
                                    ? (state
                                        .influencerBlogsViewAllModel
                                        ?.responseDetails
                                        ?.data?[index])
                                    : null,
                                isBlog: isBlog,
                                courseIndex: index,
                                onItemPress: () {
                                  if(!isBlog){
                                    NavRouter.push(
                                        context,
                                        InfluencerDetailsScreen(
                                            userId :state
                                                .influencerViewAllModel
                                                ?.responseDetails
                                                ?.data?[index].id!.toString()??""));
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ));
  }
}
