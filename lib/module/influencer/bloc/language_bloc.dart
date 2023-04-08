import 'package:app/utils/enums.dart';
import 'package:bloc/bloc.dart';

import '../../../repo/data_source/local_store.dart';
import '../../../res/constants.dart';

abstract class LanguageEvent {
  const LanguageEvent();
}

class English extends LanguageEvent {}

class Arabic extends LanguageEvent {}

class LanguageBloc extends Bloc<LanguageEvent, Language> {

  static Future<String> getSelectedLanguage() async {
    return await LocalStore.getData(PREFS_LANG) == 'en' ||
            await LocalStore.getData(PREFS_LANG) == null
        ? Future.value('en')
        : Future.value('ar');
  }

  LanguageBloc(Language initialState) : super(initialState) {
    on<English>(_setEnglish);
    on<Arabic>(_setArabic);
  }

  _setEnglish(English english, Emitter<Language> lang) {
    if (state == Language.ARABIC) {
      lang(Language.ENGLISH);
    }
  }

  _setArabic(Arabic arabic, Emitter<Language> lang) {
    if (state == Language.ENGLISH) {
      lang(Language.ARABIC);
    }
  }
}
