import 'dart:async';

import 'package:app/res/constants.dart';
import 'package:bloc/bloc.dart';

import '../../../../../repo/data_source/local_store.dart';


class CommonBloc extends Cubit {
  String? userId = null;
  String? userType = INFLUENCER;


  final StreamController<String> userTypeController =
      StreamController<String>.broadcast();

  CommonBloc(initialState) : super(initialState);

  Stream<String> get userTypeStream => userTypeController.stream;

  StreamSink<String> get _userTypeSink => userTypeController.sink;

  getUserType() async {
    _userTypeSink.add(await LocalStore.getData(PREFS_USERTYPE));
  }

}
