import 'dart:convert';

import 'package:app/module/influencer/workout/model/tags.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';

class TagsRepo{
  Future<TagsModel> getAllTags({int pageNumber=1}) async {
    ApiResponse apiResponse  = await sl.get<WebServiceImp>().fetchGetAPI(
      endPoint: 'api/user/tags',
      params: {'pageNumber':'$pageNumber','limit':'20'}
    );
    print(apiResponse.data);
    print('tagggggggggggggggggggggg');
    var response = jsonDecode(apiResponse.data);
    print('RES: $response');
    TagsModel _tagsModel = TagsModel.fromJson(response);
    return _tagsModel;
  }
}