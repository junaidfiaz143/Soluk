class ViewsMonthSummary {
  String viewsBlog;
  String viewsWorkout;
  String month;
  int views;
  int subs;

  ViewsMonthSummary(
      {this.month = '',
      required this.viewsBlog,
      this.viewsWorkout = '0',
      this.views = 0,
      this.subs = 0});
}
