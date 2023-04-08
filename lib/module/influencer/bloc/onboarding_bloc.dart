import 'package:app/module/influencer/login/view/pre_registration_screen.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/enums.dart';
import 'package:bloc/bloc.dart';

abstract class OnboardingEvent {
  const OnboardingEvent();
}

class OnboardingScreen1 extends OnboardingEvent {}

class OnboardingScreen2 extends OnboardingEvent {}

class OnboardingScreen3 extends OnboardingEvent {}

class OnboardingBloc extends Bloc<OnboardingEvent, Screens> {
  OnboardingBloc(Screens initialState) : super(initialState) {
    on<OnboardingScreen1>(_setNextScreen1);
    on<OnboardingScreen2>(_setNextScreen2);
    on<OnboardingScreen3>(_navigate);
  }

  _setNextScreen1(OnboardingScreen1 sc1, Emitter<Screens> emit) {
    if (state == Screens.Screen_1) {
      emit(Screens.Screen_2);
    }
  }

  _setNextScreen2(OnboardingScreen2 sc2, Emitter<Screens> emit) {
    if (state == Screens.Screen_2) {
      emit(Screens.Screen_3);
    }
  }

  _navigate(OnboardingScreen3 sc3, Emitter<Screens> emit) {
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(PreRegistrationScreen.id, (_) => false);
  }
}
