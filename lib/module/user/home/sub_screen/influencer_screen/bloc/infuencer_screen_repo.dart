import 'dart:convert';

import 'package:app/module/influencer/workout/model/get_influencer.dart';
import 'package:app/module/user/models/influencer_follow_status.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:http/http.dart' as http;

class InfluencerScreenRepo {
  Future<dynamic> getInfluencerInfo(String toUser) async {
    try {
      ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
          endPoint: 'api/influencer/get-info', params: {'userId': toUser});
      if (apiResponse.status == APIStatus.success) {
        var response = jsonDecode(apiResponse.data);
        print(apiResponse.statusCode);
        print(apiResponse.data);
        print(apiResponse.status);
        GetInfluencerModel _getInfluencerModel =
            GetInfluencerModel.fromJson(response);
        return _getInfluencerModel;
      } else if (apiResponse.statusCode == 15) {
        return GetInfluencerModel(
            responseCode: 15.toString(),
            responseDescription: "Dear customer, Infuencer info is not found");
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> getInfluencerFollow(String influencerId) async {
    try {
      ApiResponse apiResponse = (await sl.get<WebServiceImp>().callPostAPI(
        endPoint: 'api/user/influencer/followType/follow/$influencerId',
        body: {},
      ));

      if (apiResponse.status == APIStatus.success) {
        var response = jsonDecode(apiResponse.data);
        print(apiResponse.statusCode);
        print(apiResponse.data);
        print(apiResponse.status);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getInfluencerUnfollow(String influencerId) async {
    try {
      ApiResponse apiResponse = (await sl.get<WebServiceImp>().callPostAPI(
        endPoint: 'api/user/influencer/followType/unfollow/$influencerId',
        body: {},
      ));
      if (apiResponse.status == APIStatus.success) {
        var response = jsonDecode(apiResponse.data);
        print(apiResponse.statusCode);
        print(apiResponse.data);
        print(apiResponse.status);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> getInfluencerFollowStatus(String influencerId) async {
    final queryParameters = json.encode({
      "influencerId": influencerId,
      "load": ["isFollow"]
    });

    try {
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPIWithBody(
              endPoint: 'api/influencers', body: queryParameters);
      if (apiResponse.status == APIStatus.success) {
        var response = jsonDecode(apiResponse.data);
        print(apiResponse.statusCode);
        print(apiResponse.data);
        print(apiResponse.status);
        InfluencerFollowStatus _getInfluencerModel =
            InfluencerFollowStatus.fromJson(response);
        return _getInfluencerModel;
      } else if (apiResponse.statusCode == 15) {
        return GetInfluencerModel(responseCode: 15.toString());
      } else {
        return null;
      }
    } catch (e) {
      print("ERROR:$e");
      return null;
    }
  }

  Future<bool> rateInfluencerWorkout(int influencerId, double inflRating,
      int workId, double workRating) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${sl.get<AccessDataMembers>().token}',
        'Content-Type': 'application/json'
      };
      var request =
          http.Request('POST', Uri.parse('https://soluk.app/api/rating'));
      request.body = json.encode({
        "influencer": {
          "rated_to": 61,
          "ratingValue": 4,
          "rating_type": "influencer"
        },
        "workout": {"rated_to": 49, "ratingValue": 4, "rating_type": "workout"}
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await http.Response.fromStream(response);
        var jsonRes = jsonDecode(res.body);
        if (jsonRes["status"] == "success") {
          return true;
        }
      }
      return false;
    } catch (e) {
      print("ERROR:$e");

      return false;
    }
  }
}

class WorkoutRatingModel {
  Influencer? influencer;
  Influencer? workout;

  WorkoutRatingModel({this.influencer, this.workout});

  WorkoutRatingModel.fromJson(Map<String, dynamic> json) {
    influencer = json['influencer'] != null
        ? new Influencer.fromJson(json['influencer'])
        : null;
    workout = json['workout'] != null
        ? new Influencer.fromJson(json['workout'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.influencer != null) {
      data['influencer'] = this.influencer!.toJson();
    }
    if (this.workout != null) {
      data['workout'] = this.workout!.toJson();
    }
    return data;
  }
}

class Influencer {
  int? ratedTo;
  double? ratingValue;
  String? ratingType;

  Influencer({this.ratedTo, this.ratingValue, this.ratingType});

  Influencer.fromJson(Map<String, dynamic> json) {
    ratedTo = json['rated_to'];
    ratingValue = json['ratingValue'];
    ratingType = json['rating_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rated_to'] = this.ratedTo;
    data['ratingValue'] = this.ratingValue;
    data['rating_type'] = this.ratingType;
    return data;
  }
}
