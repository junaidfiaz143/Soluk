import 'dart:convert';

import 'package:app/module/influencer/challenges/model/badges_modal.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'badgesbloc_state.dart';

class BadgesblocCubit extends Cubit<BadgesblocState> {
  BadgesblocCubit() : super(BadgesblocInitial());
  Future<void> getBadgesData({bool initial = true}) async {
    emit(const BadgesblocLoading());
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetAPI(endPoint: 'api/user/workout-prerequisites');
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    BadgesModal badges = BadgesModal.fromJson(response);
    emit(BadgesblocLoaded(badges: badges));
  }
}
