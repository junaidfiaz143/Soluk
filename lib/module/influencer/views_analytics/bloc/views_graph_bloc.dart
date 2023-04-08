import 'package:app/module/influencer/views_analytics/repo/views_graph_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dashboard/model/chart.dart';
import '../../dashboard/model/dashboard_model.dart';
import '../../dashboard/model/views_month_summary.dart';
import '../../income_analytics/data/income_dummy_data.dart';

part 'views_graph_event.dart';

part 'views_graph_state.dart';

class ViewsGraphBloc extends Bloc<ViewsGraphEvent, ViewsGraphState> {
  final ViewsGraphRepo _viewsGraphRepo;
  ResponseDetails? monthlyViewsGraphFrontData;
  ResponseDetails? overAllViewsGraphFrontData;

  clear() {
    if (monthlyViewsGraphFrontData != null) monthlyViewsGraphFrontData = null;
    if (overAllViewsGraphFrontData != null) overAllViewsGraphFrontData = null;
  }

  ViewsGraphBloc(this._viewsGraphRepo)
      : super(ViewsGraphMonthlyAnalyticsLoadingState()) {
    on<ViewsGraphMonthlyLoadingEvent>(
        (event, emit) => emit(ViewsGraphMonthlyAnalyticsLoadingState()));

    on<ViewsGraphMonthlyLoadedEvent>((event, emit) async {
      emit(ViewsGraphMonthlyAnalyticsLoadingState());
      if (monthlyViewsGraphFrontData == null) {
        monthlyViewsGraphFrontData =
            await _viewsGraphRepo.getAnalyticsViewsGraphData(true);
      }

      List<ViewsMonthSummary>? views =
          getMonthlyBlogAndWorkoutGraphData(monthlyViewsGraphFrontData?.data);

      if (monthlyViewsGraphFrontData != null)
        emit(ViewsGraphMonthlyAnalyticsLoadedState(
            views, monthlyViewsGraphFrontData?.total ?? ''));
    });

    on<ViewsGraphOverAllLoadedEvent>((event, emit) async {
      emit(ViewsGraphOverAllAnalyticsLoadingState());
      if (overAllViewsGraphFrontData == null) {
        overAllViewsGraphFrontData =
            await _viewsGraphRepo.getAnalyticsViewsGraphData(false);
      }
      Map<String, List<ChartData>> graphData =
          getBlogAndWorkoutGraphData(overAllViewsGraphFrontData?.data);

      if (overAllViewsGraphFrontData != null)
        emit(ViewsGraphOverAllAnalyticsLoadedState(graphData['blog'],
            graphData['workout'], overAllViewsGraphFrontData?.total ?? ''));
    });
  }
}
