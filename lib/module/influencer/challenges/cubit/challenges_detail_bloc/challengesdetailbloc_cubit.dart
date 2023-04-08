import 'dart:convert';

import 'package:app/module/influencer/challenges/model/challenges_details_modals.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'challengesdetailbloc_state.dart';

class ChallengesdetailblocCubit extends Cubit<ChallengesdetailblocState> {
  ChallengesdetailblocCubit() : super(ChallengesdetailblocInitial());
 
  Future<void> getChallengeData(int challengeId,{bool initial = true,}) async {
    print('//////////////////');
    emit(const ChallengesDetailsLoading());
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetBody(endPoint: 'api/user/challenges', body: {
      "challengeId": challengeId,
      "load": [
        {"participants": "count"},
        {"comments": "count"}
      ]
    });
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    ChallengesDetailsModal _blogDetailData =
        ChallengesDetailsModal.fromJson(response);
    emit(ChallengesDetailsLoaded(challengesModal: _blogDetailData));
  }
}
