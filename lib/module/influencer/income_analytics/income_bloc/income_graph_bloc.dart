import 'package:app/module/influencer/views_analytics/repo/views_graph_repo.dart';
import 'package:bloc/bloc.dart';

import '../../dashboard/model/dashboard_model.dart';
import '../../dashboard/model/views_month_summary.dart';
import '../../income_analytics/data/income_dummy_data.dart';
import 'income_graph_event.dart';
import 'income_graph_state.dart';

class IncomeGraphBloc extends Bloc<IncomeGraphEvent, IncomeGraphState> {
  final ViewsGraphRepo _viewsGraphRepo;
  ResponseDetails? monthlyViewsGraphFrontData;
  ResponseDetailsIncome? overAllViewsGraphFrontData;

  clear() {
    if (monthlyViewsGraphFrontData != null) monthlyViewsGraphFrontData = null;
    if (overAllViewsGraphFrontData != null) overAllViewsGraphFrontData = null;
  }

  IncomeGraphBloc(this._viewsGraphRepo)
      : super(IncomeGraphMonthlyAnalyticsLoadingState()) {
    on<IncomeGraphMonthlyLoadingEvent>(
        (event, emit) => emit(IncomeGraphMonthlyAnalyticsLoadingState()));

    on<IncomeGraphMonthlyLoadedEvent>((event, emit) async {
      emit(IncomeGraphMonthlyAnalyticsLoadingState());
      if (monthlyViewsGraphFrontData == null) {
        monthlyViewsGraphFrontData =
            await _viewsGraphRepo.getAnalyticsIncomeMonthlyGraphData();
      }

      List<ViewsMonthSummary>? views =
          getMonthlyBlogAndWorkoutGraphData(monthlyViewsGraphFrontData?.data);

      if (monthlyViewsGraphFrontData != null)
        emit(IncomeGraphMonthlyAnalyticsLoadedState(
            views, monthlyViewsGraphFrontData?.totalObj));
    });

    on<IncomeGraphOverAllLoadedEvent>((event, emit) async {
      emit(IncomeGraphOverAllAnalyticsLoadingState());
      if (overAllViewsGraphFrontData == null) {
        overAllViewsGraphFrontData =
            await _viewsGraphRepo.getAnalyticsIncomeOverAllGraphData();
      }

      if (overAllViewsGraphFrontData != null)
        emit(IncomeGraphOverAllAnalyticsLoadedState(
            overAllViewsGraphFrontData?.data,
            overAllViewsGraphFrontData?.totalObj));
    });
  }
}
