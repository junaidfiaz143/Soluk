import 'package:app/module/influencer/dashboard/model/views_month_summary.dart';
import 'package:app/module/influencer/income_analytics/widget/income_horizontal_container.dart';
import 'package:app/module/influencer/views_analytics/widget/view_horizontal_container.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ExpansionTileScreen extends StatelessWidget {
  final bool? isViews;
  List<ViewsMonthSummary>? viewsSummary;

  ExpansionTileScreen({this.isViews, this.viewsSummary, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return viewsSummary?.isEmpty == true
        ? Center(
            child: Text("No History Found"),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: viewsSummary?.length,
            itemBuilder: (BuildContext context, int index) {
              return expansionTileWidget(
                  viewsSummary?[index].month ?? '', context,
                  isViews: isViews ?? false,
                  viewsSummary: viewsSummary?[index]);
            },
          );
  }

  Widget expansionTileWidget(String month, BuildContext context,
      {bool? isViews, ViewsMonthSummary? viewsSummary}) {
    return Card(
      margin: EdgeInsets.only(top: 1.h),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.49.h),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            iconColor: Colors.black,
            collapsedIconColor: Colors.black,
            title: Text(
              month,
              style: headingTextStyle(context)!.copyWith(fontSize: 10.9.sp),
            ),
            children: <Widget>[
              isViews!
                  ? viewHorizontalContainer(context,
                      isExpansion: true,
                      title: '',
                      totalViews:
                          '${int.parse(viewsSummary!.viewsBlog) + int.parse(viewsSummary.viewsWorkout)}',
                      blogViews: viewsSummary.viewsBlog,
                      workoutView: viewsSummary.viewsWorkout)
                  : incomeHorizontalContainer(context,
                      isExpansion: true,
                      title: '',
                      totalIncome: '${viewsSummary!.views + viewsSummary.subs}',
                      directSubEarning: '${viewsSummary.subs}',
                      viewsEarning: '${viewsSummary.views}')
            ],
          ),
        ),
      ),
    );
  }
}
