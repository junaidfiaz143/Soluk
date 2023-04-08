import 'package:app/utils/enums.dart';
import 'package:bloc/bloc.dart';

abstract class NavEvents {
  const NavEvents();
}

class Dashboard extends NavEvents {}

class Analytics extends NavEvents {}

class More extends NavEvents {}

class WorkPlan extends NavEvents {}

class BottomNavBloc extends Bloc<NavEvents, Action> {
  BottomNavBloc(Action initialState) : super(initialState) {
    on<Dashboard>(_setDashboard);
    on<Analytics>(_setAnalytics);
    on<More>(_setMore);
    on<WorkPlan>(_setWorkPlan);
  }

  void _setDashboard(Dashboard dashboard, Emitter<Action> emit) {
    emit(Action.DASHBOARD);
  }

  void _setAnalytics(Analytics analytics, Emitter<Action> emit) {
    emit(Action.ANALYTICS);
  }

  void _setMore(More more, Emitter<Action> emit) {
    emit(Action.MORE);
  }

  void _setWorkPlan(WorkPlan workPlan, Emitter<Action> emit) {
    emit(Action.WORKPLAN);
  }
}
