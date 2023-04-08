import 'dart:async';
import 'dart:convert';

import 'package:app/module/influencer/login/repo/login_repository.dart';
import 'package:app/module/user/profile/sub_screen/edit_profile/bloc/edit_profile_state.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../repo/data_source/remote_data_source.dart';
import '../../../../../../repo/repository/web_service.dart';
import '../../../../../../res/globals.dart';
import '../../../../../../utils/dependency_injection.dart';
import '../../../../community/firebase_utils/chat_firebase_utils.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(EditProfileState initialState) : super(initialState);

  final StreamController<ProgressFile> progressCont =
      StreamController<ProgressFile>.broadcast();

  Stream<ProgressFile> get progressStream => progressCont.stream;

  StreamSink<ProgressFile> get _progressSink => progressCont.sink;

  getData({required String userId, bool? fromUpdate = false}) async {
    emit(EditProfileLoadingState());

    final queryParameters = json.encode({
      'roleId': 2,
      'load': [
        "clientInfo",
      ]
    });

    ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPIWithBody(
        endPoint: 'api/users/$userId', body: queryParameters);
    var response = jsonDecode(apiResponse.data);

    solukLog(logMsg: queryParameters, logDetail: "query");
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);

    // solukLog(logMsg: response["responseDetails"]);
    if ((response["responseDetails"]["data"] ?? []).isEmpty) {
      emit(EditProfileEmptyState());
    } else {
      fromUpdate == true
          ? emit(EditProfileUpdatedState())
          : emit(EditProfileDataLoaded(response["responseDetails"]["data"][0]));
    }
  }

  updateData(
      {required String userId,
      required String? fullname,
      required String? path,
      required String? instagram,
      required String? snapchat}) async {
    emit(EditProfileLoadingState());

    try {
      final Map<String, String> queryParameters = {
        'fullname': fullname ?? '',
        'snapchat': snapchat ?? '',
        'instagram': instagram ?? ''
      };
      List<String> fields = [];
      List<String> paths = [];
      if (path != null) {
        fields.add('imageURL');
        paths.add(path);
      }

      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .postVideosPictures(
              endPoint: 'api/user/update',
              body: queryParameters,
              fileKeyword: fields,
              files: paths);

      // ApiResponse apiResponse = await sl
      //     .get<WebServiceImp>()
      //     .callPostAPI(endPoint: 'api/user/update', body: queryParameters);

      var response = jsonDecode(apiResponse.data);

      solukLog(logMsg: queryParameters, logDetail: "query");
      print(apiResponse.statusCode);
      print(apiResponse.data);
      print(apiResponse.status);

      // solukLog(logMsg: response["responseDetails"]);
      if (response["status"] == "success") {
        if (response['responseDetails']['imageUrl'] != null)
          ChatFirebaseUtils.instance
              .updateUserProfile(response['responseDetails']['imageUrl']);
        LoginRepository.getUserType(updateKeys: true);
        getData(userId: userId, fromUpdate: true);
      }
    } catch (e) {
      SolukToast.closeAllLoading();
      SolukToast.showToast(e.toString());
      // emit(EditProfileEmptyState());
    }
  }
}
