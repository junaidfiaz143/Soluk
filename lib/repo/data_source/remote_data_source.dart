import 'package:app/res/constants.dart';
import 'package:app/utils/enums.dart';
import 'package:flutter/material.dart';

import 'local_store.dart';

class ApiResponse<T> {
  int? statusCode;
  T? data;
  APIStatus status;
  String? errorMessage;

  ApiResponse(
      {required this.statusCode, this.data, this.status = APIStatus.loading, this.errorMessage});
  ApiResponse.failure(
      {this.statusCode, this.data, this.status = APIStatus.error, this.errorMessage});
  ApiResponse.success({this.statusCode = 200, this.data, this.status = APIStatus.success});
}

@immutable
abstract class ApiResponseStateX {
  const ApiResponseStateX();
}

class ApiInitialState extends ApiResponseStateX {
  const ApiInitialState();
}

class ApiLoadingState extends ApiResponseStateX {
  const ApiLoadingState();
}

class ApiLoadedState<T> extends ApiResponseStateX {
  final T data;
  const ApiLoadedState(this.data);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiLoadedState<T> && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

class ApiErrorState extends ApiResponseStateX {
  final String message;
  const ApiErrorState(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class AccessDataMembers with ChangeNotifier {
  String? _token;
  String get token => _token!;
  
  setToken(String authToken) {
    print('saving token');
    print(authToken);
    LocalStore.saveData(LSKeyAuthToken, authToken);
    _token = authToken;
    notifyListeners();
  }
}
