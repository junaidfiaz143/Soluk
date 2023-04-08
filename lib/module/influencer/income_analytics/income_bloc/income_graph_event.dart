import 'package:equatable/equatable.dart';

abstract class IncomeGraphEvent extends Equatable {
  const IncomeGraphEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class IncomeGraphMonthlyLoadingEvent extends IncomeGraphEvent {}

class IncomeGraphOverAllLoadingEvent extends IncomeGraphEvent {}

class IncomeGraphMonthlyLoadedEvent extends IncomeGraphEvent {}

class IncomeGraphOverAllLoadedEvent extends IncomeGraphEvent {}

class IncomeGraphMonthlyErrorEvent extends IncomeGraphEvent {}

class IncomeGraphOverAllErrorEvent extends IncomeGraphEvent {}
