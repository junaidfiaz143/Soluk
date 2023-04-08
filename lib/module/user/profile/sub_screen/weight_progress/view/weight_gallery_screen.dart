import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/media_upload_progress_popup.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/view/prgram_detail.dart';
import 'package:app/module/user/models/weight_progress_response.dart';
import 'package:app/module/user/profile/sub_screen/weight_progress/bloc/weight_progress_cubit.dart';
import 'package:app/module/user/profile/sub_screen/weight_progress/bloc/weight_progress_state.dart';
import 'package:app/module/user/profile/widgets/pop_up_weight_dialog.dart';
import 'package:app/module/user/widgets/weight_gallery_tile_widget.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../influencer/more/widget/custom_alert_dialog.dart';

class WeightGalleryScreen extends StatelessWidget {
  final WeightProgressResponse? weightProgressResponse;
  final WeightProgressCubit weightProgressCubit =
      WeightProgressCubit(WeightProgressLoadingState());

  WeightGalleryScreen({Key? key, required this.weightProgressResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (weightProgressResponse != null) {
      weightProgressCubit
          .emit(WeightProgressDataLoaded(weightProgressResponse!));
    } else
      weightProgressCubit.getWeightProgressList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: AppBody(
        showBackButton: true,
        title: "Weight Gallery",
        body: BlocBuilder<WeightProgressCubit, WeightProgressState>(
          bloc: weightProgressCubit,
          builder: (context, state) {
            if (state is WeightProgressLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: PRIMARY_COLOR,
                ),
              );
            } else if (state is WeightProgressEmptyState) {
              return const Center(
                child: Text("No Item found"),
              );
            } else if (state is WeightProgressDataLoaded) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 16, crossAxisCount: 2),
                itemBuilder: (_, index) {
                  var item = state
                      .weightProgressResponse?.responseDetails?.data![index];
                  return WeightGalleryTile(
                    weight: item?.weight.toString() ?? "",
                    date: DateFormat("dd, MMM yyyy")
                        .format(item?.createdDate ?? DateTime.now()),
                    path: (item?.imageUrl == null || item?.imageUrl == "")
                        ? "https://static.toiimg.com/thumb/resizemode-4,msid-76729750,imgsize-249247,width-720/76729750.jpg"
                        : item!.imageUrl!,
                    onClose: () {
                      print('object');
                      showDeleteConfirmationDialog(context, false,
                          (String? a) async {
                        bool result =
                            await weightProgressCubit.deleteWeightProgressItem(
                                item?.id?.toString() ?? "");
                        if (result) {
                          showSnackBar(context, "Weight Progress Deleted");
                          state.weightProgressResponse?.responseDetails?.data
                              ?.remove(item);
                          weightProgressCubit.emit(WeightProgressDataLoaded(
                              state.weightProgressResponse!));
                          ;
                        }
                      });
                    },
                  );
                },
                itemCount: state.weightProgressResponse?.responseDetails?.data
                        ?.length ??
                    0,
              );
            } else {
              return Center();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpWeightDialog(context, 'Add Weight',
              onSave: ((weightInKg, imagePath) {
            addWeightProgress(weightInKg, imagePath, context);
          }));
        },
        child: Icon(
          Icons.add,
          size: WIDTH_4,
        ),
        backgroundColor: PRIMARY_COLOR,
      ),
    );
  }

  void addWeightProgress(
      String weightInKg, String imagePath, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StreamBuilder<ProgressFile>(
            stream: weightProgressCubit.progressStream,
            builder: (context, snapshot) {
              return CustomAlertDialog(
                isSmallSize: true,
                contentWidget: MediaUploadProgressPopup(
                  snapshot: snapshot,
                ),
              );
            });
      },
    );

    Map<String, String> body = {
      'weight': weightInKg,
      'createdDate': DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
    };
    List<String> fields = [];
    List<String> paths = [];
    if (imagePath != null) {
      fields.add('imageURL');
      paths.add(imagePath);
    }
    print(body);
    bool res;

    res = await weightProgressCubit.addWeightProgress(body, fields, paths);

    Navigator.pop(context);
  }
}
