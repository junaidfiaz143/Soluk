// @dart=2.9

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;

class RestApiHelper {
  final timeout = 120;
  final dio = new Dio.Dio();

  Future<Dio.Response> get(url, {Map<String, String> headers, Map<String, dynamic> body}) async {
    String params = "?";
    body?.forEach((key, value) {
      params += "$key=$value&";
    });
    if (params == "?") {
      params = "";
    }
    url = "$url$params";
    print("GET | $url |$params");

    dio.options.headers = headers;
    final response = await dio.get(
      url,
      options: Dio.Options(
        headers: headers,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );
    return response;

    // return _client
    //     .get(url, headers: headers)
    //     .timeout(Duration(seconds: timeout));
  }

  Future<Dio.Response> post(
    url, {
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) async {
    print("POST | $url | $body");

    // dio.options.headers = headers;
    final response = await dio.post(
      url,
      options: Dio.Options(
        contentType: 'application/x-www-form-urlencoded',
        headers: headers,
        validateStatus: (status) {
          return status < 500;
        },
      ),
      // data: json.encode(body),
      data: body,
    );
    print("Response : ${response.data}");
    return response;

    // return _client
    //     .post(
    //       url,
    //       headers: headers,
    //       body: json.encode(body),
    //     )
    //     .timeout(Duration(seconds: timeout));
  }

  Future<Dio.Response> put(
    url, {
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) async {
    final data = json.encode(body);
    print("PUT | $url | $body");

    final response = await dio.patch(
      url,
      options: Dio.Options(
        headers: headers,
        validateStatus: (status) {
          return status < 500;
        },
      ),
      data: jsonEncode(body),
    );
    return response;

    // return _client
    //     .put(url,
    //         headers: headers, body: data, encoding: Encoding.getByName("utf-8"))
    //     .timeout(Duration(seconds: timeout));
  }

  Future<Dio.Response> delete(
    url, {
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) async {
    final data = json.encode(body);
    print("DELETE | $url | $body");

    final response = await dio.delete(
      url,
      options: Dio.Options(
          headers: headers,
          validateStatus: (status) {
            return status < 500;
          }),
      data: jsonEncode(body),
    );
    return response;

    // return _client
    //     .put(url,
    //         headers: headers, body: data, encoding: Encoding.getByName("utf-8"))
    //     .timeout(Duration(seconds: timeout));
  }
}
