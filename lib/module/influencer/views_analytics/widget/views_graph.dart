import 'package:app/module/influencer/dashboard/model/chart.dart';
import 'package:app/module/influencer/views_analytics/widget/graph_info_widget.dart';
import 'package:app/res/constants.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../income_analytics/data/income_dummy_data.dart';

class ViewsGraph extends StatelessWidget {
  final List<ChartData> viewGraphData1;
  final List<ChartData> viewGraphData2;
  late TooltipBehavior _tooltip;

  ViewsGraph(
      {Key? key, required this.viewGraphData1, required this.viewGraphData2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _tooltip = TooltipBehavior(enable: true);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.98.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 4.15.w, right: 4.15.w, top: 1.49.h, bottom: 1.49.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Views',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5.sp,
                        color: Colors.black),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      graphInfoWidget(
                          color: const Color(0xFF498aee),
                          title: AppLocalisation.getTranslated(
                              context, LKWorkOutVideos)),
                      graphInfoWidget(
                          color: const Color(0xFF7ef6dd),
                          title:
                              AppLocalisation.getTranslated(context, LKBlogs)),
                    ],
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 0.99.h),
                child: SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    borderWidth: 0,
                    primaryXAxis: CategoryAxis(
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 7.81.sp),
                      majorGridLines: const MajorGridLines(width: 0),
                      axisLine: const AxisLine(
                        width: 0,
                      ),
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: 50,
                      interval: 10,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 7.81.sp),
                      majorGridLines: const MajorGridLines(width: 1),
                      axisLine: const AxisLine(width: 0),
                      majorTickLines: const MajorTickLines(width: 0),
                      minorTickLines: const MinorTickLines(width: 0),
                      labelFormat: '{value}K',
                    ),
                    tooltipBehavior: _tooltip,
                    series: <ChartSeries>[
                      // Renders spline chart
                      SplineSeries<ChartData, String>(
                          enableTooltip: true,
                          name: 'Blogs',
                          width: 3,
                          color: const Color(0xFF7ef6dd),
                          dataSource: this.viewGraphData1,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y),
                      SplineSeries<ChartData, String>(
                          enableTooltip: true,
                          width: 3,
                          name: 'Workout videos',
                          color: const Color(0xFF498aee),
                          dataSource: this.viewGraphData2,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y),
                      SplineSeries<ChartData, String>(
                          enableTooltip: false,
                          width: 0,
                          name: 'Workout videos',
                          color: Colors.transparent,
                          dataSource: getMonthsData(),
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y),
                    ])),
          ],
        ),
      ),
    );
  }
}

// class ChartData {
//   ChartData(this.x, this.y);
//
//   final String x;
//   final double y;
// }
