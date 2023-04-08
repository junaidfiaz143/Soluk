import 'package:app/module/influencer/dashboard/widget/circular_graph.dart';
import 'package:app/module/influencer/dashboard/widget/loading.dart';
import 'package:app/module/influencer/dashboard/widget/rounded_widget.dart';
import 'package:app/module/influencer/dashboard/widget/top_widget.dart';
import 'package:app/module/influencer/income_analytics/bloc/dashboard_data_bloc.dart';
import 'package:app/module/influencer/income_analytics/bloc/dashboard_graph_event.dart';
import 'package:app/module/influencer/income_analytics/widget/income_graph_widget.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../repo/data_source/local_store.dart';
import '../../../../res/constants.dart';
import '../../subscribers/bloc/subscriber_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String userName = 'User';

  @override
  void initState() {
    super.initState();
    fetchUserName();
    initCurrentGlobalUser();
  }

  initCurrentGlobalUser() async {
    globalUserId = await LocalStore.getData(PREFS_USERID);
    globalUserName = await LocalStore.getData(PREFS_USERNAME);
    globalProfilePic = await LocalStore.getData(PREFS_PROFILE);
    globalUserType = await LocalStore.getData(PREFS_USERTYPE);
  }

  void fetchUserName() async {
    userName = await LocalStore.getData(PREFS_USERNAME);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TooltipBehavior _tooltip = TooltipBehavior(enable: true);
    final _incomeGraphBloc = BlocProvider.of<DashboardDataBloc>(context);
    // final _viewsGraphBloc = BlocProvider.of<ViewsGraphBloc>(context);
    final _subscriberBloc = BlocProvider.of<SubscriberBloc>(context);

    _subscriberBloc.add(SubscribersListLoadedEvent());
    _incomeGraphBloc.add(DashboardGraphLoadedEvent());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.71.w, vertical: 6.5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topWidget(context, name: userName, notification: 1),
              // Income Graph
              BlocBuilder<DashboardDataBloc, DashboardGraphState>(
                buildWhen: (pre, c) {
                  if (c is IncomeGraphLoadedState ||
                      c is IncomeGraphLoadingState) return true;
                  return false;
                },
                builder: (context, state) {
                  if (state is IncomeGraphLoadingState) {
                    return loading(context);
                  }
                  if (state is IncomeGraphLoadedState) {
                    return incomeGraphWidget(
                        graphData: state.getIncomeGraphData,
                        context: context,
                        tooltipBehavior: _tooltip);
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: 1.98.h,
              ),
              // Views Graph
              // BlocBuilder<DashboardDataBloc, DashboardGraphState>(
              //   buildWhen: (pre, c) {
              //     if (c is ViewGraphLoadedState || c is ViewsGraphLoadingState)
              //       return true;
              //     return false;
              //   },
              //   builder: (context, state) {
              //     if (state is ViewsGraphLoadingState) {
              //       return loading(context);
              //     }
              //     if (state is ViewGraphLoadedState) {
              //       return ViewsGraph(
              //         viewGraphData1: state.getViewGraphData1 ?? [],
              //         viewGraphData2: state.getViewGraphData2 ?? [],
              //       );
              //     }
              //     return Container();
              //   },
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BlocBuilder<SubscriberBloc, SubscriberState>(
                    builder: (context, state) {
                      if (state is SubscribersListLoadedState) {
                        return roundedWidget(
                            context: context,
                            value: state.subscribersList?.length.toString() ??
                                '0');
                      }
                      return const SizedBox();
                    },
                  ),
                  BlocBuilder<DashboardDataBloc, DashboardGraphState>(
                    buildWhen: (pre, c) {
                      if (c is RatingLoadedState) return true;
                      return false;
                    },
                    builder: (context, state) {
                      if (state is RatingLoadedState) {
                        return roundedWidget(
                            context: context,
                            isRating: true,
                            value: '${state.rating ?? 0}');
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              getHeadingTextView(
                context,
                "Workout Programs",
              ),

              BlocBuilder<DashboardDataBloc, DashboardGraphState>(
                buildWhen: (pre, c) {
                  if (c is WorkoutLoadedState || c is WorkoutLoadingState)
                    return true;
                  return false;
                },
                builder: (context, state) {
                  if (state is WorkoutLoadingState) {}
                  if (state is WorkoutLoadedState) {
                    return CircularGraph(
                      published: int.parse(state.workouts?.published ?? '0'),
                      unPublished:
                          int.parse(state.workouts?.unPublished ?? '0'),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getHeadingTextView(
    BuildContext context,
    String title,
  ) {
    return Text(
      title,
      textAlign: TextAlign.left,
      style: headingTextStyle(context)?.copyWith(fontSize: 18),
    );
  }
}
