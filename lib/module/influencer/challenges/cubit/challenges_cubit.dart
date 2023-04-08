import 'dart:async';

import 'package:app/module/influencer/challenges/model/challenge.dart';
import 'package:app/module/influencer/challenges/repo/challenges_repo.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengesCubit extends Cubit<ApiResponseStateX> {
  ChallengesCubit() : super(const ApiInitialState());


}