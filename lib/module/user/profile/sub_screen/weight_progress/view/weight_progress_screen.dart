import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/media_upload_progress_popup.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/user/models/weight_progress_response.dart';
import 'package:app/module/user/profile/sub_screen/weight_progress/bloc/weight_progress_cubit.dart';
import 'package:app/module/user/profile/sub_screen/weight_progress/bloc/weight_progress_state.dart';
import 'package:app/module/user/profile/widgets/pop_up_weight_dialog.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../repo/data_source/local_store.dart';
import '../../../../../../res/color.dart';
import '../../../../../influencer/more/widget/custom_alert_dialog.dart';
import '../../../../user_info/cubit/user_info_cubit.dart';
import 'weight_gallery_screen.dart';

class WeightProgressScreen extends StatelessWidget {
  final WeightProgressCubit weightProgressCubit =
      WeightProgressCubit(WeightProgressLoadingState());

  int? weight = 0;

  Future<int>? getWeight(BuildContext context) async {
    weight = await LocalStore.getData(USER_WEIGHT);
    if (weight == null) {
      String userId = await LocalStore.getData(PREFS_USERID);
      await context.read<UserInfoCubit>().fetchUserInfo(userId);
      weight = await LocalStore.getData(USER_WEIGHT);
    }
    return weight ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    weightProgressCubit.getWeightProgressList();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: AppBody(
        showBackButton: true,
        title: "Weight Progress",
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
              return Center(
                child: (state.weightProgressResponse?.responseDetails?.data
                                ?.length ??
                            0) >
                        0
                    ? Column(
                        children: [
                          Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Padding(
                              padding: EdgeInsets.all(20.sp),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(
                                    children: [
                                      FutureBuilder<int>(
                                        future: getWeight(context),
                                        initialData: 0,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<int> snapshot) {
                                          if (snapshot.data != 0) {
                                            return Text(
                                              "${snapshot.data}Kg",
                                              style: labelTextStyle(context)
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 16.sp),
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Your Weight",
                                        style: labelTextStyle(context)
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: greyTextColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SvgPicture.asset(WEIGHT_PROGRESS_ICON)
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "Weight Graph",
                                      style: labelTextStyle(context)?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SfCartesianChart(
                                      title: ChartTitle(text: ""),
                                      plotAreaBorderWidth: 0,
                                      primaryYAxis: NumericAxis(
                                        rangePadding: ChartRangePadding.none,
                                        labelStyle: labelTextStyle(context)
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp),
                                        minorGridLines: MinorGridLines(
                                            color: Colors.transparent),
                                        majorGridLines: MajorGridLines(
                                            dashArray: <double>[3, 3, 3, 3, 3]),
                                        opposedPosition: true,
                                        labelFormat: '{value}',
                                        decimalPlaces: 0,
                                        axisLine: const AxisLine(width: 0),
                                        majorTickLines: const MajorTickLines(
                                            color: Colors.transparent),
                                      ),
                                      legend: Legend(
                                          isVisible: false,
                                          overflowMode:
                                              LegendItemOverflowMode.wrap),
                                      // Enable tooltip
                                      tooltipBehavior:
                                          TooltipBehavior(enable: true),
                                      enableAxisAnimation: true,
                                      // Initialize category axis
                                      primaryXAxis: CategoryAxis(
                                          labelStyle: labelTextStyle(context)
                                              ?.copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.sp),
                                          majorTickLines: const MajorTickLines(
                                              color: Colors.transparent),
                                          borderWidth: 0,
                                          minorGridLines: MinorGridLines(
                                              color: Colors.transparent),
                                          borderColor: Colors.transparent,
                                          majorGridLines: MajorGridLines(
                                              color: Colors.transparent)),
                                      series: <LineSeries<Data, String>>[
                                        LineSeries<Data, String>(
                                          dataSource: state
                                                  .weightProgressResponse
                                                  ?.responseDetails
                                                  ?.data ??
                                              [],
                                          xValueMapper: (Data sales, _) =>
                                              DateFormat("dd MMM")
                                                  .format(sales.createdDate!),
                                          yValueMapper: (Data sales, _) =>
                                              sales.weight,
                                          markerSettings: MarkerSettings(
                                              isVisible: true,
                                              color: Colors.blueAccent),
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: SalukGradientButton(
                              style: labelTextStyle(context)?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                  color: Colors.white),
                              title: 'Weight Gallery',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => WeightGalleryScreen(
                                              weightProgressResponse: state
                                                      .weightProgressResponse ??
                                                  null,
                                            )));
                              },
                              buttonHeight: HEIGHT_3,
                            ),
                          ),
                        ],
                      )
                    : Text("No data found"),
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
              onSave: ((weightInKg, imagePath) async {
                if (weightInKg.isEmpty) return;

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
    if (imagePath != "") {
      fields.add('imageURL');
      paths.add(imagePath);
    }
    print(body);
    bool res;

    res = await weightProgressCubit.addWeightProgress(body, fields, paths);

    Navigator.pop(context);
  }
}
