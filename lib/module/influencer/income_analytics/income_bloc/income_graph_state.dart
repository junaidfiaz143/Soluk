import 'package:equatable/equatable.dart';

import '../../dashboard/model/dashboard_model.dart';
import '../../dashboard/model/views_month_summary.dart';

abstract class IncomeGraphState extends Equatable {
  const IncomeGraphState();

  @override
  List<Object> get props => [];
}

class IncomeGraphMonthlyAnalyticsLoadedState extends IncomeGraphState {
  final List<ViewsMonthSummary>? _viewGraphFrontData1;
  final TotalObj? count;

  const IncomeGraphMonthlyAnalyticsLoadedState(
      this._viewGraphFrontData1, this.count);

  List<ViewsMonthSummary>? get getViewGraphData1 => _viewGraphFrontData1;

  TotalObj? get getCount => count;
}

class IncomeGraphOverAllAnalyticsLoadedState extends IncomeGraphState {
  final IncomeChart? _incomeGraphFrontData;

  final TotalObj? total;

  const IncomeGraphOverAllAnalyticsLoadedState(
      this._incomeGraphFrontData, this.total);

  IncomeChart? get incomeGraphFrontData => _incomeGraphFrontData;

  TotalObj? get getCount => total;
}

class IncomeGraphMonthlyAnalyticsLoadingState extends IncomeGraphState {}

class IncomeGraphOverAllAnalyticsLoadingState extends IncomeGraphState {}

class IncomeGraphAnalyticsErrorState extends IncomeGraphState {}
