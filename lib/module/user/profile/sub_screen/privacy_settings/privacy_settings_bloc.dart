import 'dart:async';
import 'dart:convert';

import 'package:app/module/user/profile/sub_screen/privacy_settings/PrivacySettingsModel.dart';
import 'package:bloc/bloc.dart';

import '../../../../../repo/data_source/remote_data_source.dart';
import '../../../../../repo/repository/web_service.dart';
import '../../../../../utils/dependency_injection.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/soluk_toast.dart';

class PrivacySettingsBloc extends Cubit {
  final StreamController<ResponseDetails> privacySettingsController =
      StreamController<ResponseDetails>.broadcast();

  PrivacySettingsBloc(initialState) : super(initialState);

  Stream<ResponseDetails> get privacySettingsStream =>
      privacySettingsController.stream;

  StreamSink<ResponseDetails> get _privacySettingsSink =>
      privacySettingsController.sink;

  getPrivacySettings() async {
    SolukToast.showLoading();
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .callPutAPI(endPoint: 'api/user-setting', body: {});
    SolukToast.closeAllLoading();

    var response = jsonDecode(apiResponse.data);
    PrivacySettingsModel privacySettingsModel =
        PrivacySettingsModel.fromJson(response);

    if (apiResponse.status == APIStatus.success) {
      _privacySettingsSink.add(privacySettingsModel.responseDetails!);
    }
  }
  updatePrivacySettings({required Map<String, dynamic> body}) async {
    SolukToast.showLoading();
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .callPutAPI(endPoint: 'api/user-setting', body: body);
    SolukToast.closeAllLoading();

    // var response = jsonDecode(apiResponse.data);
    // PrivacySettingsModel privacySettingsModel =
    //     PrivacySettingsModel.fromJson(response);

    /*if (apiResponse.status == APIStatus.success) {
      _privacySettingsSink.add(privacySettingsModel.responseDetails!);
    }*/
  }
}
