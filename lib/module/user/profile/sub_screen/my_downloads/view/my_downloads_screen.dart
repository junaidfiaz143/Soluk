import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/module/user/profile/sub_screen/my_downloads/bloc/my_downloads_cubit.dart';
import 'package:app/module/user/profile/sub_screen/my_downloads/bloc/my_downloads_state.dart';
import 'package:app/module/user/widgets/my_download_tile.dart';
import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../influencer/workout_programs/widgets/main_workout_program_tile.dart';

class MyDownloadsScreen extends StatelessWidget {
  final MyDownloadsCubit myInfluencersCubit =
      MyDownloadsCubit(MyDownloadLoadingState());

  @override
  Widget build(BuildContext _context) {
    myInfluencersCubit.getInfluencersList();
    return Scaffold(
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: AppBody(
        showBackButton: true,
        title: "My Downloads",
        body: BlocBuilder<MyDownloadsCubit, MyDownloadState>(
          bloc: myInfluencersCubit,
          builder: (context, state) {
            if (state is MyDownloadLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            } else if (state is MyDownloadEmptyState) {
              return const Center(
                child: Text("No Item found"),
              );
            } else if (state is MyDownloadDataLoaded) {
              return RefreshWidget(
                enablePullDown: false,
                enablePullUp: true,
                refreshController: myInfluencersCubit.refreshController,
                onLoadMore: () => myInfluencersCubit.onLoadMore("id here"),
                onRefresh: () => null,
                child: ListView.builder(
                  itemBuilder: (BuildContext, index) {
                    print(state.myInfluencersModel[index].name);
                    return MyDownloadTile(
                      mediaType: state.myInfluencersModel[index].name
                                  .contains("mp4") ==
                              true
                          ? "Video"
                          : "Image",
                      // image:
                      //     "https://static.toiimg.com/thumb/resizemode-4,msid-76729750,imgsize-249247,width-720/76729750.jpg",
                      image: state.myInfluencersModel[index].name,
                      title: state.myInfluencersModel[index].name
                          .split("/")
                          .last
                          .split("download")
                          .last
                          .split(".")
                          .first
                          .split("_")
                          .last,
                      details: "HEllo this is details",
                      numberOfViews: "10",
                      totalSets: state.myInfluencersModel[index].name
                              .contains(":")
                          ? state.myInfluencersModel[index].name.split(":")[3]
                          : "",
                      excerciseType: state.myInfluencersModel[index].name
                              .contains(":")
                          ? state.myInfluencersModel[index].name.split(":")[2]
                          : "",
                      description: state.myInfluencersModel[index].name
                              .contains(":")
                          ? state.myInfluencersModel[index].name.split(":")[1]
                          : "",
                      callback: () {
                        var res = showDeleteConfirmationDialog(_context,
                            path: state.myInfluencersModel[index].name,
                            downloadsCubit: myInfluencersCubit);
                      },
                    );
                  },
                  itemCount: state.myInfluencersModel.length,
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
