import 'dart:async';

import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout/model/get_influencer.dart';
import 'package:app/module/influencer/workout/model/tags.dart';
import 'package:app/module/influencer/workout/repo/get_infuencer_repo.dart';
import 'package:app/module/influencer/workout/repo/get_tags.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'aboutmebloc_state.dart';

class AboutmeblocCubit extends Cubit<AboutmeblocState> {
  AboutmeblocCubit() : super(AboutmeblocInitial());
  GetInfluencerRepo getInfluencerRepo = GetInfluencerRepo();
  final StreamController<ProgressFile> progressCont =
      StreamController<ProgressFile>.broadcast();

  Stream<ProgressFile> get progressStream => progressCont.stream;

  StreamSink<ProgressFile> get _progressSink => progressCont.sink;

  getInfluencerData() async {
    GetInfluencerModel? _influencerModel =
        await getInfluencerRepo.getInfluencerInfo();
    emit(InfluencerDataLoaded(influencerModel: _influencerModel));
  }

  Future<bool> addInfluencerData(BuildContext context, Map<String, String> body,
      List<String> fields, List<String> paths) async {
    ApiResponse apiResponse =
        await sl.get<WebServiceImp>().postdioVideosPictures(
            onUploadProgress: (p) {
              if (p.done == p.total) {
                _progressSink.add(ProgressFile(done: 0, total: 0));
              } else {
                _progressSink.add(p);
              }
            },
            endPoint: 'api/influencer/info',
            body: body,
            fileKeyword: fields,
            files: paths);
    print(apiResponse.data);
    print(apiResponse.status);
    if (apiResponse.status == APIStatus.success) {
      showSnackBar(context, 'About me Updated', backgroundColor: Colors.black);
      return true;
    } else {
      showSnackBar(context, 'Some Error Occured',
          backgroundColor: Colors.black);
      return false;
    }
  }
}
