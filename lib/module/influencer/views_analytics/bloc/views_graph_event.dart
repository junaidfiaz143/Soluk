part of 'views_graph_bloc.dart';

abstract class ViewsGraphEvent extends Equatable {
  const ViewsGraphEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ViewsGraphMonthlyLoadingEvent extends ViewsGraphEvent {}

class ViewsGraphOverAllLoadingEvent extends ViewsGraphEvent {}

class ViewsGraphMonthlyLoadedEvent extends ViewsGraphEvent {}

class ViewsGraphOverAllLoadedEvent extends ViewsGraphEvent {}

class ViewsGraphMonthlyErrorEvent extends ViewsGraphEvent {}

class ViewsGraphOverAllErrorEvent extends ViewsGraphEvent {}
