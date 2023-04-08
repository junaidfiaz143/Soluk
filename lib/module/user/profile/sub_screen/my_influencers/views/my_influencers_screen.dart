import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/module/user/home/sub_screen/influencer_screen/view/influencer_details_screen.dart';
import 'package:app/module/user/profile/sub_screen/my_influencers/bloc/my_influencers_cubit.dart';
import 'package:app/module/user/profile/sub_screen/my_influencers/bloc/my_influencers_state.dart';
import 'package:app/module/user/widgets/influencer_tile_widget.dart';
import 'package:app/res/color.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MyInfluencersScreen extends StatelessWidget {
  final MyInfluencersCubit myInfluencersCubit =
      MyInfluencersCubit(MyInfluencersLoadingState());

  @override
  Widget build(BuildContext context) {
    myInfluencersCubit.getInfluencersList();
    return Scaffold(
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: AppBody(
        showBackButton: true,
        title: "My Infleuncers",
        body: BlocBuilder<MyInfluencersCubit, MyInfluencersState>(
          bloc: myInfluencersCubit,
          builder: (context, state) {
            if (state is MyInfluencersLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            } else if (state is MyInfluencersEmptyState) {
              return const Center(
                child: Text("No Item found"),
              );
            } else if (state is MyInfluencersDataLoaded) {
              return RefreshWidget(
                enablePullDown: false,
                enablePullUp: true,
                refreshController: myInfluencersCubit.refreshController,
                onLoadMore: () => myInfluencersCubit.onLoadMore(),
                onRefresh: () => null,
                child: ListView.builder(
                  itemBuilder: (BuildContext, index) {
                    var influencerModel = state.myInfluencersModel?.responseDetails?.data![index];
                    return InfluencerTile(name: influencerModel?.fullname??"",imgUrl: influencerModel?.imageUrl??"",onPressed: (){
                      NavRouter.push(
                          context,
                          InfluencerDetailsScreen(
                              userId : influencerModel?.id.toString()??""));
                    },);
                  },
                  itemCount: state.myInfluencersModel?.responseDetails?.data?.length??0,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(5),
                  scrollDirection: Axis.vertical,
                ),
              );
            } else {
              return Center();
            }
          },
        ),
      ),
    );
  }
}
