part of 'views_graph_bloc.dart';

abstract class ViewsGraphState extends Equatable {
  const ViewsGraphState();

  @override
  List<Object> get props => [];
}

class ViewsGraphMonthlyAnalyticsLoadedState extends ViewsGraphState {
  final List<ViewsMonthSummary>? _viewGraphFrontData1;
  final String count;

  const ViewsGraphMonthlyAnalyticsLoadedState(
      this._viewGraphFrontData1, this.count);

  List<ViewsMonthSummary>? get getViewGraphData1 => _viewGraphFrontData1;

  String get getCount => count;
}

class ViewsGraphOverAllAnalyticsLoadedState extends ViewsGraphState {
  final List<ChartData>? _viewGraphFrontData1;
  final List<ChartData>? _viewGraphFrontData2;
  final String count;

  const ViewsGraphOverAllAnalyticsLoadedState(
      this._viewGraphFrontData1, this._viewGraphFrontData2, this.count);

  List<ChartData>? get getViewGraphData1 => _viewGraphFrontData1;

  List<ChartData>? get getViewGraphData2 => _viewGraphFrontData2;

  String get getCount => count;
}

class ViewsGraphMonthlyAnalyticsLoadingState extends ViewsGraphState {}

class ViewsGraphOverAllAnalyticsLoadingState extends ViewsGraphState {}

class ViewsGraphAnalyticsErrorState extends ViewsGraphState {}
