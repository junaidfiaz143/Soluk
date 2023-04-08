import 'package:app/module/influencer/dashboard/model/chart.dart';
import 'package:app/module/influencer/dashboard/model/views_month_summary.dart';

List<ViewsMonthSummary> viewSummaryData = [];

final List<ChartData> viewChartDataList1 = [
  ChartData('Sat', 35),
  ChartData('Sun', 13),
  ChartData('Mon', 34),
  ChartData('Tue', 27),
  ChartData('Wed', 50),
  ChartData('Thu', 20),
  ChartData('Fri', 40)
];

final List<ChartData> viewChartDataList2 = [
  ChartData('Sat', 30),
  ChartData('Sun', 20),
  ChartData('Mon', 10),
  ChartData('Tue', 35),
  ChartData('Wed', 40),
  ChartData('Thu', 35),
  ChartData('Fri', 30)
];

getViewsExpansionSummary(){
  viewSummaryData = [
    ViewsMonthSummary(viewsBlog: '1600'),
    ViewsMonthSummary(viewsBlog: '1200'),
    ViewsMonthSummary(viewsBlog: '1300'),
    ViewsMonthSummary(viewsBlog: '1000'),
    ViewsMonthSummary(viewsBlog: '1800'),
    ViewsMonthSummary(viewsBlog: '2600'),
    ViewsMonthSummary(viewsBlog: '600'),
    ViewsMonthSummary(viewsBlog: '1600'),
    ViewsMonthSummary(viewsBlog: '1200'),
    ViewsMonthSummary(viewsBlog: '1300'),
    ViewsMonthSummary(viewsBlog: '1000'),
    ViewsMonthSummary(viewsBlog: '1800'),
    ViewsMonthSummary(viewsBlog: '2600'),
    ViewsMonthSummary(viewsBlog: '600'),
  ];
}