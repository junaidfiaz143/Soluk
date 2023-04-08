import 'package:app/module/influencer/income_analytics/widget/expansion_tile.dart';
import 'package:app/module/influencer/views_analytics/widget/view_horizontal_container.dart';
import 'package:app/module/influencer/views_analytics/widget/views_graph.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../dashboard/widget/loading.dart';
import '../bloc/views_graph_bloc.dart';

class ViewsScreen extends StatefulWidget {
  static const routeName = 'ViewsScreen';

  const ViewsScreen({Key? key}) : super(key: key);

  @override
  State<ViewsScreen> createState() => _ViewsScreenState();
}

class _ViewsScreenState extends State<ViewsScreen> {
  late TooltipBehavior _tooltip;
  bool isOverAllViewsSelected = true;
  bool isMonthlyViewsSelected = false;
  final PageController _pageController = PageController();
  ViewsGraphBloc? _viewGraphBloc;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);

    _viewGraphBloc = BlocProvider.of<ViewsGraphBloc>(context);
    // _viewGraphBloc?.add(ViewsGraphMonthlyLoadedEvent());
    _viewGraphBloc?.add(ViewsGraphOverAllLoadedEvent());

    super.initState();
  }

  @override
  void dispose() {
    _viewGraphBloc?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: AppBody(
        bgColor: backgroundColor,
        title: AppLocalisation.getTranslated(context, LKViews),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 1.2.h),
              child: Row(
                children: [
                  choiceChipWidget(context,
                      title: AppLocalisation.getTranslated(
                          context, LKOverallViews),
                      isIncomeSelected: isOverAllViewsSelected,
                      onSelected: (val) {
                    _pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                    setState(() {
                      isOverAllViewsSelected = true;
                      isMonthlyViewsSelected = false;
                    });
                  }),
                  Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: choiceChipWidget(context,
                        title:
                            AppLocalisation.getTranslated(context, LKMonthly),
                        isIncomeSelected: isMonthlyViewsSelected,
                        onSelected: (val) {
                      _pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                      setState(() {
                        isOverAllViewsSelected = false;
                        isMonthlyViewsSelected = true;
                      });
                    }),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  switch (page) {
                    case 0:
                      _viewGraphBloc?.add(ViewsGraphOverAllLoadedEvent());
                      setState(() {
                        isOverAllViewsSelected = true;
                        isMonthlyViewsSelected = false;
                      });
                      break;
                    case 1:
                      _viewGraphBloc?.add(ViewsGraphMonthlyLoadedEvent());
                      setState(() {
                        isOverAllViewsSelected = false;
                        isMonthlyViewsSelected = true;
                      });
                      break;
                  }
                },
                children: [
                  BlocBuilder<ViewsGraphBloc, ViewsGraphState>(
                    buildWhen: (pre, c) {
                      if (c is ViewsGraphOverAllAnalyticsLoadingState ||
                          c is ViewsGraphOverAllAnalyticsLoadedState)
                        return true;
                      return false;
                    },
                    builder: (context, state) {
                      if (state is ViewsGraphOverAllAnalyticsLoadingState) {
                        return loading(context);
                      }
                      if (state is ViewsGraphOverAllAnalyticsLoadedState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ViewsGraph(
                              viewGraphData1: state.getViewGraphData1 ?? [],
                              viewGraphData2: state.getViewGraphData2 ?? [],
                            ),
                            viewHorizontalContainer(context,
                                title: AppLocalisation.getTranslated(
                                    context, LKOverallViews),
                                totalViews: state.count,
                                blogViews: '',
                                workoutView: '')
                          ],
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  BlocBuilder<ViewsGraphBloc, ViewsGraphState>(
                    buildWhen: (pre, c) {
                      if (c is ViewsGraphMonthlyAnalyticsLoadingState ||
                          c is ViewsGraphMonthlyAnalyticsLoadedState)
                        return true;
                      return false;
                    },
                    builder: (context, state) {
                      if (state is ViewsGraphMonthlyAnalyticsLoadingState) {
                        return loading(context);
                      }
                      if (state is ViewsGraphMonthlyAnalyticsLoadedState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 0.99.h),
                                child: viewHorizontalContainer(context,
                                    title: AppLocalisation.getTranslated(
                                        context, LKTotalViews),
                                    totalViews: state.count,
                                    blogViews: '',
                                    workoutView: '')),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: 2.98.h),
                              child: Text(
                                AppLocalisation.getTranslated(
                                    context, LKHistory),
                                style: headingTextStyle(context)!.copyWith(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                                child: ExpansionTileScreen(
                                    isViews: true,
                                    viewsSummary: state.getViewGraphData1))
                          ],
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
