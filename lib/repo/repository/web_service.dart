import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app/module/influencer/bloc/language_bloc.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/repo/data_source/local_store.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/res/constants.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as parser;

abstract class _WebService {
  Future<ApiResponse> fetchGetAPI({
    required String endPoint,
    bool isAuthTokenRequired = true,
  });

  Future<ApiResponse> fetchGetAPIWithBody({
    required String endPoint,
    bool isAuthTokenRequired = true,
    String body,
  });

  Future<ApiResponse> callPostAPI({
    required String endPoint,
    required Map<String, dynamic> body,
    bool isAuthTokenRequired = true,
  });

  Future<ApiResponse> callPutAPI({
    required String endPoint,
    required Map<String, dynamic> body,
    bool isAuthTokenRequired = true,
  });

  Future<ApiResponse> addVideoPicture({
    required String endPoint,
    required Map<String, dynamic> body,
    required List<File> files,
    required String fileKeyword,
  });

  Future<ApiResponse> postdioVideosPictures({
    required String endPoint,
    required Function(ProgressFile) onUploadProgress,
    required Map<String, String> body,
    required List<String> files,
    required List<String> fileKeyword,
  });

  Future<ApiResponse> postVideosPictures({
    required String endPoint,
    required Map<String, String> body,
    required List<String> files,
    required List<String> fileKeyword,
  });

  Future logout(BuildContext context);

  Future<ApiResponse> delete({required String endPoint});

  Future<ApiResponse> loginAPI({
    required Map<String, dynamic> body,
  });

  Future<ApiResponse> getUserTypeApi();
}

class WebServiceImp implements _WebService {
  final Dio dio = new Dio();

  @override
  Future<ApiResponse> fetchGetAPI(
      {required String endPoint,
      Map<String, dynamic> params = const {},
      bool isAuthTokenRequired = true}) async {
    String? token;

    if (isAuthTokenRequired) {
      token = sl.get<AccessDataMembers>().token;
    }

    // var dioResponse = await Dio().get("https://" + BASE_URL + "/" + endPoint,
    //     queryParameters: params,
    //     options: Options(headers: {
    //       'Content-Type': 'application/json',
    //       'Accept': 'application/json',
    //       'Authorization': 'Bearer $token',
    //       'X-localization': await LanguageBloc.getSelectedLanguage()
    //     }));

    // solukLog(
    //     logMsg: dioResponse.data.toString(),
    //     logDetail: "webservice",
    //     type: solukLogTypeWarning);

    // var requestNew = http.Request('GET',
    //     Uri.parse('https://soluk.app/api/user/workout/week/day/exercise'));
    // requestNew.body = json.encode(params).toString();

    // var headers = {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer $token',
    //   'X-localization': await LanguageBloc.getSelectedLanguage()
    // };
    // requestNew.headers.addAll(headers);

    // final responseNEW = await requestNew.send();
    // var responseStream = await http.Response.fromStream(responseNEW);
    // final result = jsonDecode(responseStream.body) as Map<String, dynamic>;

    // print("oppo");
    // if (responseNEW.statusCode == 200) {
    //   print(result);
    //   // print(await responseNEW.stream.bytesToString());
    // } else {
    //   print(responseNEW.reasonPhrase);
    // }

    Uri uri = Uri.https(BASE_URL, endPoint, params);
    final response = !isAuthTokenRequired
        ? await http.get(uri, headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          })
        : await http.get(uri, headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'X-localization': await LanguageBloc.getSelectedLanguage()
          });

    var res = jsonDecode(response.body);
    print('GET body  ${response.body}');
    print('GET url  $uri');
    print('GET status code ${response.statusCode}');
    print('GET response $res');
    print('GET status code ${response.statusCode}');
    print('/////////////////////');
    if (res != null &&
        res['responseDetails'] != '' &&
        res["responseCode"] != null &&
        res["responseCode"] == SUCCESS) {
      return ApiResponse.success(
          status: APIStatus.success,
          statusCode: int.tryParse(SUCCESS),
          data: response.body);
    }
    return ApiResponse.failure(
      status: APIStatus.error,
      data: res['responseDescription'],
      statusCode: int.tryParse(res["responseCode"] ?? '0'),
    );
  }

  @override
  Future<ApiResponse> fetchGetAPIWithBody(
      {required String endPoint,
      bool isAuthTokenRequired = true,
      String? body}) async {
    String? token;

    if (isAuthTokenRequired) {
      token = sl.get<AccessDataMembers>().token;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'X-localization': await LanguageBloc.getSelectedLanguage()
    };

    print("http url -> $endPoint");
    print("http request body -> $body");

    var request = http.Request('GET', Uri.parse('https://soluk.app/$endPoint'));
    request.body = body!;
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var mResponse = await response.stream.bytesToString();
      print("http request body -> $mResponse");
      var res = jsonDecode(mResponse);

      if (res != null &&
          res['responseDetails'] != '' &&
          res["responseCode"] != null &&
          res["responseCode"] == SUCCESS) {
        return ApiResponse.success(
            status: APIStatus.success,
            statusCode: int.tryParse(SUCCESS),
            data: mResponse);
      } else {
        return ApiResponse.failure(
          status: APIStatus.error,
          data: res['responseDescription'],
          statusCode: int.tryParse(res["responseCode"] ?? '0'),
        );
      }
    }
    return ApiResponse.failure(
      status: APIStatus.error,
      data: "Something went wrong",
      statusCode: int.tryParse("1"),
    );
  }

  @override
  Future<ApiResponse> callPostAPI({
    required String endPoint,
    required Map<String, dynamic> body,
    bool isAuthTokenRequired = true,
  }) async {
    String? token;
    if (isAuthTokenRequired) {
      token = sl.get<AccessDataMembers>().token;
    }
    Uri uri = Uri.https(BASE_URL, endPoint);
    final response = isAuthTokenRequired
        ? await http.post(
            uri,
            headers: {
              'Authorization': 'Bearer $token',
              'X-localization': await LanguageBloc.getSelectedLanguage()
            },
            body: body,
          )
        : await http.post(
            uri,
            body: body,
          );
    log('API RESPONSE :: ${response.body}');
    var res = jsonDecode(response.body);

    if (res != null &&
        (res["responseCode"] != null && res["responseCode"] == SUCCESS)) {
      return ApiResponse.success(
          status: APIStatus.success,
          statusCode: int.tryParse(SUCCESS),
          data: response.body);
    }
    return ApiResponse.failure(
        status: APIStatus.error,
        data: res['responseDescription'],
        statusCode: int.tryParse(res["responseCode"]) ?? 404);
  }

  @override
  Future<ApiResponse> callPutAPI({
    required String endPoint,
    required Map<String, dynamic> body,
    bool isAuthTokenRequired = true,
  }) async {
    String? token;
    if (isAuthTokenRequired) {
      token = sl.get<AccessDataMembers>().token;
    }
    Uri uri = Uri.https(BASE_URL, endPoint);
    log('API Url  :: $uri');
    log('API body :: $body');

    final response = isAuthTokenRequired
        ? await http.put(
            uri,
            headers: {
              'Authorization': 'Bearer $token',
              'X-localization': await LanguageBloc.getSelectedLanguage()
            },
            body: body,
          )
        : await http.put(
            uri,
            body: body,
          );
    log('API RESPONSE :: ${response.body}');
    var res = jsonDecode(response.body);

    if (res != null &&
        (res["responseCode"] != null && res["responseCode"] == SUCCESS)) {
      return ApiResponse.success(
          status: APIStatus.success,
          statusCode: int.tryParse(SUCCESS),
          data: response.body);
    }
    return ApiResponse.failure(
        status: APIStatus.error,
        data: res['responseDescription'],
        statusCode: int.tryParse(res["responseCode"]) ?? 404);
  }

  @override
  Future<ApiResponse> addVideoPicture({
    required String endPoint,
    required Map<String, dynamic> body,
    required List<File> files,
    required String fileKeyword,
  }) async {
    String? token = sl.get<AccessDataMembers>().token;
    Uri uri = Uri.https(BASE_URL, endPoint);
    var request = http.MultipartRequest("POST", uri);
    for (var file in files) {
      String fileName = file.path.split("/").last;
      request.files.add(
        await http.MultipartFile.fromPath(
          fileKeyword,
          file.path,
          filename: fileName,
          contentType: parser.MediaType('application', 'json'),
        ),
      );
    }
    for (var element in body.entries) {
      if (!element.key.contains(fileKeyword)) {
        request.fields[element.key] = element.value;
      }
    }
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token",
      'X-localization': await LanguageBloc.getSelectedLanguage()
    };
    request.headers.addAll(headers);
    var response = await request.send();

    var res = await http.Response.fromStream(response);
    var _res = jsonDecode(res.body);
    if (_res != null &&
        _res["responseCode"] != null &&
        _res["responseCode"] == SUCCESS) {
      return ApiResponse.success(
          status: APIStatus.success,
          statusCode: int.tryParse(SUCCESS),
          data: res.body);
    }
    return ApiResponse.failure(
        status: APIStatus.error,
        statusCode: int.tryParse(_res["responseCode"]));
  }

  @override
  Future<ApiResponse> delete({required String endPoint}) async {
    String? token = sl.get<AccessDataMembers>().token;
    Uri uri = Uri.https(BASE_URL, endPoint);
    var request = http.Request('DELETE', uri);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    request.headers.addAll(headers);
    var response = await request.send();
    var res = await http.Response.fromStream(response);
    var _res = jsonDecode(res.body);
    if (_res != null &&
        _res["responseCode"] != null &&
        _res["responseCode"] == SUCCESS) {
      return ApiResponse.success(
          status: APIStatus.success,
          statusCode: int.tryParse(SUCCESS),
          data: res.body);
    }
    return ApiResponse.failure(
        status: APIStatus.error,
        statusCode: int.tryParse(_res["responseCode"]),
        errorMessage: _res["responseDescription"]);
  }

  @override
  Future<ApiResponse> fetchGetBody({
    required String endPoint,
    required Map<String, dynamic> body,
    Map<String, dynamic> params = const {},
  }) async {
    String? token = sl.get<AccessDataMembers>().token;
    Uri uri = Uri.https(BASE_URL, endPoint, params);
    var request = http.Request('GET', uri);
    print("body: $body");
    request.body = json.encode(body);

    // var request = http.MultipartRequest("POST", uri);
    // body.forEach((key, value) {
    //   request.fields[key] = value;
    // });
    // print(request.fields);
    // for (var i = 0; i < files.length; i++) {
    //   print('iteration $i');
    //   String fileName = files[i].split("/").last;
    //   request.files.add(
    //     await http.MultipartFile.fromPath(
    //       fileKeyword[i],
    //       files[i],
    //       filename: fileName,
    //       // contentType: parser.MediaType('application', 'json'),
    //     ),
    //   );
    // }
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    request.headers.addAll(headers);
    print("request :${request}");
    var response = await request.send();
    var res = await http.Response.fromStream(response);
    var _res = jsonDecode(res.body);
    print("get response $_res");
    print('?????????????????Ddddddddd');
    if (_res != null &&
        _res["responseCode"] != null &&
        _res["responseCode"] == SUCCESS) {
      return ApiResponse.success(
          status: APIStatus.success,
          statusCode: int.tryParse(SUCCESS),
          data: res.body);
    }
    return ApiResponse.failure(
        status: APIStatus.error,
        statusCode: int.tryParse(
          _res["responseCode"],
        ),
        errorMessage: _res["responseDescription"]);
  }

  @override
  Future<ApiResponse> postVideosPictures({
    required String endPoint,
    required Map<String, dynamic> body,
    required List<String> files,
    required List<String> fileKeyword,
  }) async {
    String? token = sl.get<AccessDataMembers>().token;
    Uri uri = Uri.https(BASE_URL, endPoint);
    var request = http.MultipartRequest("POST", uri);
    body.forEach((key, value) {
      request.fields[key] = value;
    });

    print(request.fields);
    for (var i = 0; i < files.length; i++) {
      print('iteration $i');
      String fileName = files[i].split("/").last;
      request.files.add(
        await http.MultipartFile.fromPath(
          fileKeyword[i],
          files[i],
          filename: fileName,
          // contentType: parser.MediaType('application', 'json'),
        ),
      );
    }
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    request.headers.addAll(headers);
    print("URL : ${uri}");
    print("body : ${request.fields}");
    var response = await request.send();
    var res = await http.Response.fromStream(response);
    var _res = jsonDecode(res.body);
    print(_res);
    print('?????????????????Ddddddddd');
    if (_res != null &&
        _res["responseCode"] != null &&
        _res["responseCode"] == SUCCESS) {
      return ApiResponse.success(
          status: APIStatus.success,
          statusCode: int.tryParse(SUCCESS),
          data: res.body);
    }
    return ApiResponse.failure(
        status: APIStatus.error,
        statusCode: int.tryParse(_res["responseCode"] ?? '00'));
  }

  Future<ApiResponse> postdioVideosPictures({
    required String endPoint,
    required Function(ProgressFile) onUploadProgress,
    required Map<String, String> body,
    required List<String> files,
    required List<String> fileKeyword,
  }) async {
    Map<String, dynamic> bodyy = {};
    bodyy.addAll(body);
    for (var i = 0; i < files.length; i++) {
      print('iteration $i');
      String fileName = files[i].split("/").last;
      try {
        bodyy.addAll({
          '${fileKeyword[i]}': await MultipartFile.fromFile(
            files[i],
            filename: fileName,
          )
        });
      } catch (e) {
        print(e.toString());
      }
    }
    print(bodyy);
    var formData = FormData.fromMap(bodyy);
    String? token = sl.get<AccessDataMembers>().token;
    print(token);
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      print('BASE URL ::::::::   https://$BASE_URL/$endPoint');
      var response = await dio.post('https://$BASE_URL/$endPoint',
          data: formData,
          options: Options(headers: headers),
          onSendProgress: (i, j) =>
              onUploadProgress(ProgressFile(done: i, total: j)));
      print(response.data);
      //  var _res = jsonDecode(res.body);
      var _res = response.data;
      print(_res);
      print('?????????????????Ddddddddd');
      if (_res != null &&
          _res["responseCode"] != null &&
          _res["responseCode"] == SUCCESS) {
        return ApiResponse.success(
            status: APIStatus.success,
            statusCode: int.tryParse(SUCCESS),
            data: _res);
      } else {
        return ApiResponse.failure(
            status: APIStatus.error,
            statusCode: int.tryParse(_res["responseCode"] ?? '00'));
      }
    } catch (e) {
      print(e);
      return ApiResponse.failure(
          status: APIStatus.error,
          statusCode: int.tryParse('00'),
          errorMessage: e.toString());
    }
    // return ApiResponse.failure(
    //     status: APIStatus.error, statusCode: int.tryParse('00'));
  }

  @override
  Future logout(BuildContext context) async {
    showSnackBar(context, "Unauthorized User");
    LocalStore.removeData(LSKeyAuthToken);
    LocalStore.removeData(LSKeySelectedLanguage);
    // await callPostAPI(
    //   endPoint: "api/logout",
    //   body: {},
    // );
    Phoenix.rebirth(context);
  }

  @override
  Future<ApiResponse> loginAPI({required Map<String, dynamic> body}) async {
    Uri uri = Uri.https(BASE_URL, "api/login");

    final response = await http.post(
      uri,
      body: body,
    );
    print("uri : ${uri}");
    return ApiResponse.success(
        status: APIStatus.success,
        statusCode: int.tryParse(SUCCESS),
        data: response.body);
  }

  @override
  Future<ApiResponse> getUserTypeApi() async {
    String? token = sl.get<AccessDataMembers>().token;
    Uri uri = Uri.https(BASE_URL, "api/user/userType");
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'X-localization': await LanguageBloc.getSelectedLanguage()
      },
    );
    print('tokennnnnnnn: $token');
    print(response.body);
    print(response.statusCode);
    return ApiResponse.success(
        status: APIStatus.success,
        statusCode: int.tryParse(SUCCESS),
        data: response.body);
  }

  static Future<dynamic> apiGet(String endPoint) async {
    dynamic response;
    Dio dio = Dio();
    //FormData formData;
    print('In web service class>>>>>>');

    String? token = sl.get<AccessDataMembers>().token;
    Uri uri = Uri.https(BASE_URL, endPoint);
    print("URL :::: $BASE_URL+$endPoint");
    print('url: $uri');
    //print(params.toJson());
    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["Content-Type"] = 'application/json';
      dio.options.headers["Authorization"] = 'Bearer $token';
      //formData = FormData.fromMap(params);

      response = await dio
          .getUri(
        uri,
      )
          .timeout(const Duration(seconds: 35), onTimeout: () {
        return response('Connection Timeout');
      });
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // LoginResponse().message = e.response.data(1);
        print(e.response!.data);
        print(e.response!.headers);
        print('>>>>>>>>>>>>>>>>response code: ${e.response!.statusCode}');
        return e;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e);
        return e;
      }
    }
    if (response != null) {
      print('response: $response');

      return response;
    } else {
      return response;
    }
  }

  static Future<dynamic> apiGetFullUrl(String url) async {
    dynamic response;
    Dio dio = Dio();
    //FormData formData;
    print('In web service class>>>>>>');

    String? token = sl.get<AccessDataMembers>().token;
    print('url: $url');
    //print(params.toJson());
    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["Content-Type"] = 'application/json';
      dio.options.headers["Authorization"] = 'Bearer $token';
      //formData = FormData.fromMap(params);

      response = await dio
          .get(
        url,
      )
          .timeout(const Duration(seconds: 35), onTimeout: () {
        return response('Connection Timeout');
      });
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // LoginResponse().message = e.response.data(1);
        print(e.response!.data);
        print(e.response!.headers);
        print('>>>>>>>>>>>>>>>>response code: ${e.response!.statusCode}');
        return e;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e);
        return e;
      }
    }
    if (response != null) {
      return response;
    } else {
      return response;
    }
  }

  static Future addWorkoutPlanMultipartPostApi(
      String endPoint, var params, var image) async {
    String? token = sl.get<AccessDataMembers>().token;

    dynamic response;
    Dio dio = Dio();
    FormData formData;
    Uri uri = Uri.https(BASE_URL, endPoint);
    print('url: $uri');
    print('>>>>>>>params: ${jsonEncode(params)}');
    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["Content-Type"] = 'application/json';
      dio.options.headers["Authorization"] = 'Bearer $token';

      // dio.options.connectTimeout = 50000;

      print('>>>>>>>>>>12');
      formData = FormData.fromMap(params);
      print('>>>>>>>>>>13');

      if (image != null) {
        formData.files.add(
          MapEntry(
              "imageVideoURL",
              await MultipartFile.fromFile(image.path,
                  filename: image.path.split('/').last)),
        );
      }
      print('>>>>>>>>>>14');
      response =
          await dio.postUri(uri, data: formData, onSendProgress: (sent, total) {
        log("progress : $sent $total");
      }).timeout(const Duration(seconds: 100), onTimeout: () {
        return response('Connection Timeout');
      });

      return response;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print('>>>>>>>>>>>>>>>>response code: ${e.response!.statusCode}');
        return e.response;
      }
    }
    if (response != null) {
      print('upload image response: $response');
      return response;
    } else {
      return response;
    }
  }

  static Future<ApiResponse> postDataMultiPart(var params,
      {String? endPoint, var image}) async {
    String? token = sl.get<AccessDataMembers>().token;

    Response response;
    var options = BaseOptions(
      connectTimeout: 5000,
      validateStatus: (status) => true,
    );
    Dio dio = Dio(options);
    FormData formData;
    Uri uri = Uri.https(BASE_URL, endPoint!);
    print('url: $uri');
    print('>>>>>>>params: ${jsonEncode(params!)}');
    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["Content-Type"] = 'application/json';
      dio.options.headers["Authorization"] = 'Bearer $token';

      formData = FormData.fromMap(params);
      if (image != null) {
        formData.files.add(
          MapEntry(
              "imageVideoURL",
              await MultipartFile.fromFile(image.path,
                  filename: image.path.split('/').last)),
        );
      }
      response =
          await dio.postUri(uri, data: formData, onSendProgress: (sent, total) {
        log("progress : $sent $total");
      });
      final _res = jsonDecode(response.toString());

      if (_res != null &&
          _res["responseCode"] != null &&
          _res["responseCode"] == SUCCESS) {
        return ApiResponse.success(
            status: APIStatus.success,
            statusCode: int.tryParse(SUCCESS),
            data: response.data);
      }
      return ApiResponse.failure(
          status: APIStatus.error,
          statusCode: int.tryParse(
            _res["responseCode"],
          ),
          errorMessage: _res["responseDescription"]);
    } on DioError catch (e) {
      return ApiResponse.failure(
          status: APIStatus.error, statusCode: e.response!.statusCode!);
    }
  }

  static Future<ApiResponse> postData({var body, String? endPoint}) async {
    String? token = sl.get<AccessDataMembers>().token;

    Response response;
    var options = BaseOptions(
      connectTimeout: 5000,
      validateStatus: (status) => true,
    );
    Dio dio = Dio(options);
    Uri uri = Uri.https(BASE_URL, endPoint!);
    print('url: $uri');
    print('>>>>>>>params: ${jsonEncode(body!)}');
    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["Content-Type"] = 'application/json';
      dio.options.headers["Authorization"] = 'Bearer $token';

      // dio.options.connectTimeout = 50000;

      response =
          await dio.postUri(uri, data: body, onSendProgress: (sent, total) {
        log("progress : $sent $total");
      });
      print('>>>>>>>>>>14 :${response.data}');
      final _res = jsonDecode(response.toString());
      print('res :${_res}');
      if (_res != null &&
          _res["responseCode"] != null &&
          _res["responseCode"] == SUCCESS) {
        return ApiResponse.success(
            status: APIStatus.success,
            statusCode: int.tryParse(SUCCESS),
            data: response.data);
      }
      return ApiResponse.failure(
          status: APIStatus.error,
          statusCode: int.tryParse(
            _res["responseCode"],
          ),
          errorMessage: _res["responseDescription"]);
    } on DioError catch (e) {
      print("exception: ${e.toString()}");
      return ApiResponse.failure(
          status: APIStatus.error, statusCode: e.response!.statusCode!);
    }
  }

  static Future<ApiResponse> updateData({var body, String? endPoint}) async {
    String? token = sl.get<AccessDataMembers>().token;

    Response response;
    var options = BaseOptions(
      connectTimeout: 5000,
      validateStatus: (status) => true,
    );
    Dio dio = Dio(options);
    Uri uri = Uri.https(BASE_URL, endPoint!);
    print('url: $uri');
    print('>>>>>>>params: ${jsonEncode(body!)}');
    try {
      dio.options.headers["Accept"] = 'application/json';
      dio.options.headers["Content-Type"] = 'application/json';
      dio.options.headers["Authorization"] = 'Bearer $token';

      // dio.options.connectTimeout = 50000;

      response =
          await dio.putUri(uri, data: body, onSendProgress: (sent, total) {
        log("progress : $sent $total");
      });
      print('>>>>>>>>>>14 :${response.data}');
      final _res = jsonDecode(response.toString());
      print('res :${_res}');
      if (_res != null &&
          _res["responseCode"] != null &&
          _res["responseCode"] == SUCCESS) {
        return ApiResponse.success(
            status: APIStatus.success,
            statusCode: int.tryParse(SUCCESS),
            data: response.data);
      }
      return ApiResponse.failure(
          status: APIStatus.error,
          statusCode: int.tryParse(
            _res["responseCode"],
          ),
          errorMessage: _res["responseDescription"]);
    } on DioError catch (e) {
      print("exception: ${e.toString()}");
      return ApiResponse.failure(
          status: APIStatus.error, statusCode: e.response!.statusCode!);
    }
  }
}

class ProgressFile {
  int done;
  int total;

  ProgressFile({required this.done, required this.total});
}
