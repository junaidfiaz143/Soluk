import 'dart:async';
import 'dart:convert';

import 'package:app/module/influencer/more/model/bank_info_model.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../repo/data_source/remote_data_source.dart';
import '../../../../../../repo/repository/web_service.dart';
import '../../../../../../res/globals.dart';
import '../../../../../../utils/dependency_injection.dart';
import 'bank_info_state.dart';

class BankInfoCubit extends Cubit<BankInfoState> {
  BankInfoCubit(BankInfoState initialState) : super(initialState);

  final StreamController<ProgressFile> progressCont =
      StreamController<ProgressFile>.broadcast();

  Stream<ProgressFile> get progressStream => progressCont.stream;

  StreamSink<ProgressFile> get _progressSink => progressCont.sink;

  getData({required String userId, bool? fromUpdate = false}) async {
    emit(BankInfoLoadingState());
    SolukToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
        endPoint: 'api/influencer/get-info', params: {'userId': userId});

    var response = jsonDecode(apiResponse.data);

    print(apiResponse.data);
    print(apiResponse.status);
    if (apiResponse.status == APIStatus.success) {
      BankInfoModel bankInfoModel = BankInfoModel.fromJson(response);

      if (bankInfoModel.responseDetails == null) {
        emit(BankInfoEmptyState());
      } else {
        fromUpdate == true
            ? emit(BankInfoUpdatedState())
            : emit(BankInfoDataLoaded(bankInfoModel));
      }
    }
  }

  updateData(
      {required String beneName,
      required String? bankName,
      required String? bankAddress,
      required String? accountNumber,
      required String? iban,
      required String? bic,
      required String? swift}) async {
    emit(BankInfoLoadingState());
    SolukToast.showLoading();

    try {
      final Map<String, String> queryParameters = {
        "beneficiary_name": "$beneName",
        "bank_name": "$bankName",
        "bank_address": "$bankAddress",
        "bank_account_number": "$accountNumber",
        "bank_account_IBAN": "$iban",
        "BIC": "$bic",
        "swift": "$swift"
      };

      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .callPostAPI(endPoint: 'api/bank-info', body: queryParameters);

      var response = jsonDecode(apiResponse.data);

      solukLog(logMsg: queryParameters, logDetail: "query");
      print(apiResponse.statusCode);
      print(apiResponse.data);
      print(apiResponse.status);

      if (response["status"] == "success") {
        emit(BankInfoUpdatedState());
      }
    } catch (e) {
      SolukToast.closeAllLoading();
      SolukToast.showToast(e.toString());
      // emit(EditProfileEmptyState());
    }
  }
}
