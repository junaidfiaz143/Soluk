import 'package:equatable/equatable.dart';

abstract class DashboardGraphEvent extends Equatable {
  const DashboardGraphEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DashboardGraphLoadedEvent extends DashboardGraphEvent {}
