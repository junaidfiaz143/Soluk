import 'package:app/module/influencer/bloc/language_bloc.dart';
import 'package:app/module/influencer/challenges/bloc/challenge_bloc.dart';
import 'package:app/module/influencer/challenges/model/challenge.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/enums.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future init() async {
  GetIt.I.registerLazySingleton(() => AccessDataMembers());
  GetIt.I.registerLazySingleton(() => WebServiceImp());
  GetIt.I.registerLazySingleton(() => ChallengeBloc(GetAllChallenges()));
  // GetIt.I.registerLazySingleton(() => SuggestionBloc(SuggestionModel()));
  GetIt.I.registerLazySingleton(() => LanguageBloc(Language.ENGLISH));
}
