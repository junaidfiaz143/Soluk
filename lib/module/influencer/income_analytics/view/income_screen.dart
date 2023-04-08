import 'package:app/module/influencer/income_analytics/widget/expansion_tile.dart';
import 'package:app/module/influencer/income_analytics/widget/income_horizontal_container.dart';
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
import '../income_bloc/income_graph_bloc.dart';
import '../income_bloc/income_graph_event.dart';
import '../income_bloc/income_graph_state.dart';
import '../widget/income_graph_widget.dart';

class IncomeScreen extends StatefulWidget {
  static const routeName = 'IncomeScreen';

  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  late TooltipBehavior _tooltip;
  bool isOverAllIncomeSelected = true;
  bool isMonthlyIncomeSelected = false;
  final PageController _pageController = PageController();
  IncomeGraphBloc? _incomeGraphBloc;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    _incomeGraphBloc = BlocProvider.of<IncomeGraphBloc>(context);
    _incomeGraphBloc?.add(IncomeGraphOverAllLoadedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: AppBody(
        bgColor: backgroundColor,
        title: AppLocalisation.getTranslated(context, LKIncome),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 1.2.h),
              child: Row(
                children: [
                  choiceChipWidget(context,
                      title: AppLocalisation.getTranslated(
                          context, LKOverallIncome),
                      isIncomeSelected: isOverAllIncomeSelected,
                      onSelected: (val) {
                    _pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                    setState(() {
                      isOverAllIncomeSelected = true;
                      isMonthlyIncomeSelected = false;
                    });
                  }),
                  Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: choiceChipWidget(context,
                        title:
                            AppLocalisation.getTranslated(context, LKMonthly),
                        isIncomeSelected: isMonthlyIncomeSelected,
                        onSelected: (val) {
                      _pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                      setState(() {
                        isOverAllIncomeSelected = false;
                        isMonthlyIncomeSelected = true;
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
                      _incomeGraphBloc?.add(IncomeGraphOverAllLoadedEvent());
                      setState(() {
                        isOverAllIncomeSelected = true;
                        isMonthlyIncomeSelected = false;
                      });
                      break;
                    case 1:
                      _incomeGraphBloc?.add(IncomeGraphMonthlyLoadedEvent());
                      setState(() {
                        isOverAllIncomeSelected = false;
                        isMonthlyIncomeSelected = true;
                      });
                      break;
                  }
                },
                children: [
                  BlocBuilder<IncomeGraphBloc, IncomeGraphState>(
                    buildWhen: (pre, c) {
                      if (c is IncomeGraphOverAllAnalyticsLoadingState ||
                          c is IncomeGraphOverAllAnalyticsLoadedState)
                        return true;
                      return false;
                    },
                    builder: (context, state) {
                      if (state is IncomeGraphOverAllAnalyticsLoadingState) {
                        return loading(context);
                      }
                      if (state is IncomeGraphOverAllAnalyticsLoadedState) {
                        return Column(
                          children: [
                            incomeGraphWidget(
                                context: context,
                                graphData: state.incomeGraphFrontData,
                                tooltipBehavior: _tooltip),
                            incomeHorizontalContainer(context,
                                title: AppLocalisation.getTranslated(
                                    context, LKTotalIncome),
                                totalIncome:
                                    '${(state.total?.views ?? 0) + (state.total?.subscription ?? 0)}',
                                directSubEarning:
                                    '${(state.total?.subscription ?? 0)}',
                                viewsEarning: '${(state.total?.views ?? 0)}')
                            // totalIncomeWidget(),
                          ],
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  BlocBuilder<IncomeGraphBloc, IncomeGraphState>(
                    buildWhen: (pre, c) {
                      if (c is IncomeGraphMonthlyAnalyticsLoadingState ||
                          c is IncomeGraphMonthlyAnalyticsLoadedState)
                        return true;
                      return false;
                    },
                    builder: (context, state) {
                      if (state is IncomeGraphMonthlyAnalyticsLoadingState) {
                        return loading(context);
                      }
                      if (state is IncomeGraphMonthlyAnalyticsLoadedState) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 0.99.h),
                              child: incomeHorizontalContainer(context,
                                  title: AppLocalisation.getTranslated(
                                      context, LKTotalIncome),
                                  totalIncome:
                                      '${(state.count?.views ?? 0) + (state.count?.subscription ?? 0)}',
                                  directSubEarning:
                                      '${(state.count?.subscription ?? 0)}',
                                  viewsEarning: '${(state.count?.views ?? 0)}'),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: 2.98.h),
                              child: Text(
                                AppLocalisation.getTranslated(
                                    context, LKHistory),
                                style: headingTextStyle(context)!
                                    .copyWith(fontSize: 15.6.sp),
                              ),
                            ),
                            Expanded(
                                child: ExpansionTileScreen(
                                    viewsSummary: state.getViewGraphData1))
                          ],
                        );
                      }
                      return SizedBox();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
