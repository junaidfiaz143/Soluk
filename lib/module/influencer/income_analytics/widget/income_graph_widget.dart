import 'package:app/module/influencer/dashboard/model/chart.dart';
import 'package:app/module/influencer/income_analytics/widget/column_graph.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/res/constants.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../dashboard/model/dashboard_model.dart';
import '../data/income_dummy_data.dart';

Widget incomeGraphWidget(
    {required IncomeChart? graphData,
    required BuildContext context,
    required TooltipBehavior tooltipBehavior}) {
  return Container(
    margin: EdgeInsets.only(top: 2.48.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
    ),
    height: MediaQuery.of(context).size.height * 0.4,
    child: Padding(
      padding: EdgeInsets.only(top: 1.8.h, bottom: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (graphData == null || graphData.isDataFound() == false)
            Positioned(top: 150, child: TextView("No Data Found")),
          // getCartesianChart(seriesChartGraph: <ChartSeries<ChartData, String>>[
          //
          // ]),
          getCartesianChart(
            tooltipBehavior: tooltipBehavior,
            seriesChartGraph: <ChartSeries<ChartData, String>>[
              StackedColumnSeries<ChartData, String>(
                  dataSource: getMonthsData(),
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: AppLocalisation.getTranslated(context, LKIncome),
                  enableTooltip: true,
                  borderRadius: BorderRadius.circular(50),
                  width: 0.3,
                  color: Colors.transparent),
              StackedColumnSeries<ChartData, String>(
                dataSource: getGraphData(graphData),
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                enableTooltip: true,
                name: 'Income',
                borderRadius: BorderRadius.circular(50),
                width: 0.3,
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.6,
                    0.9,
                  ],
                  colors: [
                    Color(0xFF7ef6dd),
                    Color(0xFF498aee),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
