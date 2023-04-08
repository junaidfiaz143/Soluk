import 'package:app/module/influencer/dashboard/model/chart.dart';
import 'package:app/module/influencer/dashboard/model/income_month_summary.dart';
import 'package:app/module/influencer/dashboard/model/month_name.dart';

import '../../dashboard/model/dashboard_model.dart';
import '../../dashboard/model/views_month_summary.dart';

List<Month> monthData = [];
List<IncomeMonthSummary> monthSummaryData = [];

List<ViewsMonthSummary>? getMonthlyBlogAndWorkoutGraphData(Views? element) {
  List<ViewsMonthSummary>? views = [];
  if (element?.jan != null) {
    views.add(ViewsMonthSummary(
      month: "Jan",
      viewsBlog: element?.jan?.blog ?? '0',
      viewsWorkout: element?.jan?.workout ?? '0',
      views: element?.jan?.views ?? 0,
      subs: element?.jan?.subscription ?? 0,
    ));
  }
  if (element?.feb != null) {
    views.add(ViewsMonthSummary(
      month: "Feb",
      viewsBlog: element?.feb?.blog ?? '0',
      viewsWorkout: element?.feb?.workout ?? '0',
      views: element?.feb?.views ?? 0,
      subs: element?.feb?.subscription ?? 0,
    ));
  }
  if (element?.march != null) {
    views.add(ViewsMonthSummary(
      month: "Mar",
      viewsBlog: element?.march?.blog ?? '0',
      viewsWorkout: element?.march?.workout ?? '0',
      views: element?.march?.views ?? 0,
      subs: element?.march?.subscription ?? 0,
    ));
  }
  if (element?.april != null) {
    views.add(ViewsMonthSummary(
      month: "Apr",
      viewsBlog: element?.april?.blog ?? '0',
      viewsWorkout: element?.april?.workout ?? '0',
      views: element?.april?.views ?? 0,
      subs: element?.april?.subscription ?? 0,
    ));
  }
  if (element?.may != null) {
    views.add(ViewsMonthSummary(
      month: "Apr",
      viewsBlog: element?.may?.blog ?? '0',
      viewsWorkout: element?.may?.workout ?? '0',
      views: element?.may?.views ?? 0,
      subs: element?.may?.subscription ?? 0,
    ));
  }
  if (element?.june != null) {
    views.add(ViewsMonthSummary(
      month: "Apr",
      viewsBlog: element?.june?.blog ?? '0',
      viewsWorkout: element?.june?.workout ?? '0',
      views: element?.june?.views ?? 0,
      subs: element?.june?.subscription ?? 0,
    ));
  }
  if (element?.july != null) {
    views.add(ViewsMonthSummary(
      month: "July",
      viewsBlog: element?.july?.blog ?? '0',
      viewsWorkout: element?.july?.workout ?? '0',
      views: element?.july?.views ?? 0,
      subs: element?.july?.subscription ?? 0,
    ));
  }
  if (element?.aug != null) {
    views.add(ViewsMonthSummary(
      month: "August",
      viewsBlog: element?.aug?.blog ?? '0',
      viewsWorkout: element?.aug?.workout ?? '0',
      views: element?.aug?.views ?? 0,
      subs: element?.aug?.subscription ?? 0,
    ));
  }
  if (element?.sep != null) {
    views.add(ViewsMonthSummary(
      month: "Sep",
      viewsBlog: element?.sep?.blog ?? '0',
      viewsWorkout: element?.sep?.workout ?? '0',
      views: element?.sep?.views ?? 0,
      subs: element?.sep?.subscription ?? 0,
    ));
  }
  if (element?.oct != null) {
    views.add(ViewsMonthSummary(
      month: "Oct",
      viewsBlog: element?.oct?.blog ?? '0',
      viewsWorkout: element?.oct?.workout ?? '0',
      views: element?.oct?.views ?? 0,
      subs: element?.oct?.subscription ?? 0,
    ));
  }
  if (element?.nov != null) {
    views.add(ViewsMonthSummary(
      month: "Nov",
      viewsBlog: element?.nov?.blog ?? '0',
      viewsWorkout: element?.nov?.workout ?? '0',
      views: element?.nov?.views ?? 0,
      subs: element?.nov?.subscription ?? 0,
    ));
  }
  if (element?.dec != null) {
    views.add(ViewsMonthSummary(
      month: "Dec",
      viewsBlog: element?.dec?.blog ?? '0',
      viewsWorkout: element?.dec?.workout ?? '0',
      views: element?.dec?.views ?? 0,
      subs: element?.dec?.subscription ?? 0,
    ));
  }
  return views;
}

Map<String, List<ChartData>> getBlogAndWorkoutGraphData(Views? element) {
  List<ChartData>? blogData = [];
  List<ChartData>? workoutData = [];
  if (element?.monday != null) {
    if (element?.monday?.blog != null) {
      blogData.add(
          ChartData("Mon", double.parse(element!.monday?.blog?.views ?? '0')));
    }
    if (element?.monday?.workout != null) {
      workoutData.add(ChartData(
          "Mon", double.parse(element!.monday?.workout?.views ?? '0')));
    }
  }
  if (element?.tuesday != null) {
    if (element?.tuesday?.blog != null) {
      blogData.add(
          ChartData("Tue", double.parse(element!.tuesday?.blog?.views ?? '0')));
    }
    if (element?.tuesday?.workout != null) {
      workoutData.add(ChartData(
          "Tue", double.parse(element!.tuesday?.workout?.views ?? '0')));
    }
  }
  if (element?.wednesday != null) {
    if (element?.wednesday?.blog != null) {
      blogData.add(ChartData(
          "Wed", double.parse(element!.wednesday?.blog?.views ?? '0')));
    }
    if (element?.wednesday?.workout != null) {
      workoutData.add(ChartData(
          "Wed", double.parse(element!.wednesday?.workout?.views ?? '0')));
    }
  }

  if (element?.thursday != null) {
    if (element?.thursday?.blog != null) {
      blogData.add(ChartData(
          "Thurs", double.parse(element!.thursday?.blog?.views ?? '0')));
    }
    if (element?.thursday?.workout != null) {
      workoutData.add(ChartData(
          "Thurs", double.parse(element!.thursday?.workout?.views ?? '0')));
    }
  }
  if (element?.friday != null) {
    if (element?.friday?.blog != null) {
      blogData.add(
          ChartData("Fri", double.parse(element!.friday?.blog?.views ?? '0')));
    }
    if (element?.friday?.workout != null) {
      workoutData.add(ChartData(
          "Fri", double.parse(element!.friday?.workout?.views ?? '0')));
    }
  }
  if (element?.saturday != null) {
    if (element?.saturday?.blog != null) {
      blogData.add(ChartData(
          "Sat", double.parse(element!.saturday?.blog?.views ?? '0')));
    }
    if (element?.saturday?.workout != null) {
      workoutData.add(ChartData(
          "Sat", double.parse(element!.saturday?.workout?.views ?? '0')));
    }
  }
  if (element?.sunday != null) {
    if (element?.sunday?.blog != null) {
      blogData.add(
          ChartData("Sun", double.parse(element!.sunday?.blog?.views ?? '0')));
    }
    if (element?.sunday?.workout != null) {
      workoutData.add(ChartData(
          "Sun", double.parse(element!.sunday?.workout?.views ?? '0')));
    }
  }
  return {'blog': blogData, 'workout': workoutData};
}

List<ChartData> getGraphData(IncomeChart? element) {
  List<ChartData>? data = [];
  if (element?.monday != null) {
    data.add(ChartData("Mon", element!.monday!.totalIncome!.toDouble()));
  }
  if (element?.tuesday != null) {
    data.add(ChartData("Tue", element!.tuesday!.totalIncome!.toDouble()));
  }
  if (element?.wednesday != null) {
    data.add(ChartData("Wed", element!.wednesday!.totalIncome!.toDouble()));
  }
  if (element?.thursday != null) {
    data.add(ChartData("Thurs", element!.thursday!.totalIncome!.toDouble()));
  }
  if (element?.friday != null) {
    data.add(ChartData("Fri", element!.friday!.totalIncome!.toDouble()));
  }
  if (element?.saturday != null) {
    data.add(ChartData("Sat", element!.saturday!.totalIncome!.toDouble()));
  }
  if (element?.sunday != null) {
    data.add(ChartData("Sun", element!.sunday!.totalIncome!.toDouble()));
  }
  return data;
}

List<ChartData> getMonthsData() {
  List<ChartData>? data = [];
  data.add(ChartData("Mon", 0));
  data.add(ChartData("Tue", 0));
  data.add(ChartData("Wed", 0));
  data.add(ChartData("Thurs", 0));
  data.add(ChartData("Fri", 0));
  data.add(ChartData("Sat", 0));
  data.add(ChartData("Sun", 0));
  return data;
}

getMonths() {
  monthData = [
    Month(name: 'January'),
    Month(name: 'February'),
    Month(name: 'March'),
    Month(name: 'April'),
    Month(name: 'May'),
    Month(name: 'June'),
    Month(name: 'July'),
    Month(name: 'August'),
    Month(name: 'September'),
    Month(name: 'October'),
    Month(name: 'November'),
    Month(name: 'December'),
  ];
}

final List<ChartData> incomeGraphFrontData = [
  ChartData('Sat', 7011),
  ChartData('Sun', 6012),
  ChartData('Mon', 8911),
  ChartData('Tue', 5011),
  ChartData('Wed', 9011),
  ChartData('Thurs', 5011),
  ChartData('Fri', 7611),
];

final List<ChartData> incomeGraphBackData = [
  ChartData('Sat', 10000),
  ChartData('Sun', 10110),
  ChartData('Mon', 10220),
  ChartData('Tue', 10022),
  ChartData('Wed', 10022),
  ChartData('Thurs', 1020),
  ChartData('Fri', 10000),
];
