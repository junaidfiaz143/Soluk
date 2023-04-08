import 'dart:convert';

import 'package:app/module/influencer/more/model/promo_code_modal.dart';
import 'package:app/module/influencer/workout/hive/local/my_hive.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'promobloc_state.dart';

class PromoblocCubit extends Cubit<PromoblocState> {
  PromoblocCubit() : super(PromoblocInitial());
  
  Future<void> getPromoCode() async {
    emit(const PromoLoading());
    var data;
    if(MyHive.getAboutInfo()==null){

    }
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetAPI(endPoint: 'api/user/get-promo-code');
      
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    if(apiResponse.status==APIStatus.success){
      var response = jsonDecode(apiResponse.data);
    PromoCodeModal _promoCode =
        PromoCodeModal.fromJson(response);
    if ((_promoCode.responseDetails ?? {}) == {}) {
      print('emptyyyyyyyyyyyy');
      emit(const PromoEmpty());
    } else {
      emit(PromoLoaded(promoCode: _promoCode));
    }}
    else{
      emit(const PromoEmpty());
    }
  }
   Future<void> addPromoCode() async {
emit(const PromoDialogLoading());
    // BotToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
        endPoint: 'api/user/generate-promo-code',
        body: {},
  
       );
    // BotToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
       var response = jsonDecode(apiResponse.data);
        PromoCodeModal _promoCode =
        PromoCodeModal.fromJson(response);
      emit(PromoLoaded(promoCode:_promoCode ));
    
    } else {
      emit(const PromoEmpty());
    }
  }

}
