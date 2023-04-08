import 'dart:convert';

import 'package:app/module/influencer/workout/model/social_links_modal.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sociallinksbloc_state.dart';

class SociallinksblocCubit extends Cubit<SociallinksblocState> {
  SociallinksblocCubit() : super(SociallinksblocInitial());

  // Future<SocialLinksModal>
  getSocialLinks() async {
    emit(const SocialLinksLoading());
    ApiResponse? apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetAPI(endPoint: 'api/user/get-social-link');
    if (apiResponse == null) {
      print('//////////////');
    }
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    SocialLinksModal _socialLinks = SocialLinksModal.fromJson(response);
    if (_socialLinks.responseDetails?.isEmptyOrNull() == true) {
      emit(const SocialLinksEmpty());
    } else {
      emit(SociallinksLoaded(socialLinks: _socialLinks));
    }
  }

  Future<bool> addSocialLinks(
      {String fb = '',
      String yout = '',
      String insta = '',
      String snapchat = ''}) async {
    // emit(const SocialLinksLoading());
    try {
      SolukToast.showLoading();
      print(yout);
      print('>>>>>>>>>>>');
      ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
          endPoint: 'api/user/update-social-link',
          body: {
            "instagram": insta,
            "youtube": yout,
            "facebook": fb,
            "snapchat": snapchat
          });
      SolukToast.closeAllLoading();
      print(apiResponse.statusCode);

      print(apiResponse.status == APIStatus.success);
      if (apiResponse.status == APIStatus.success) {
        getSocialLinks();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(';;;;');
      print(e);
      return false;
    }
    // var response = jsonDecode(apiResponse.data);
    // print(apiResponse.statusCode);
    // print(apiResponse.data);
    // print(apiResponse.status);
    // SocialLinksModal _socialLinks = SocialLinksModal.fromJson(response);
    // if ((_socialLinks.responseDetails?.facebook) == null ||
    //     (_socialLinks.responseDetails?.instagram) == null ||
    //     (_socialLinks.responseDetails?.youtube) == null) {
    //   emit(const SocialLinksEmpty());
    // } else {
    //   emit(SociallinksLoaded(socialLinks: _socialLinks));
    // }
  }
}
