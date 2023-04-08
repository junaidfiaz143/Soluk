import 'package:app/module/influencer/dashboard/model/chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

getCartesianChart({TooltipBehavior? tooltipBehavior, required List<ChartSeries<ChartData, String>> seriesChartGraph}){
  return SfCartesianChart(
      plotAreaBorderWidth: 0,
      borderWidth: 0,
      title: ChartTitle(
        text: ' Income\n',
        alignment: ChartAlignment.near,
        textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.5.sp,
            color: Colors.black
        ),
      ),
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 7.81.sp
        ),
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0,),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 7.81.sp
        ),
        minimum: 0,
        maximum: 100,
        interval: 10,
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
        minorTickLines: const MinorTickLines(width: 0),
        numberFormat: NumberFormat.currency(
          symbol: "\$",
          decimalDigits: 0,
        ),
      ),
      tooltipBehavior: tooltipBehavior,
      series: seriesChartGraph
  );
}