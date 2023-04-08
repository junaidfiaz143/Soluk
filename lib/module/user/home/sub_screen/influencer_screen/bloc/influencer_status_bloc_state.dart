import 'package:app/module/user/models/influencer_follow_status.dart';
import 'package:flutter/material.dart';

@immutable
abstract class InfluencerStatusBlocState {
  final bool? isFollowed;
  const InfluencerStatusBlocState({this.isFollowed});
}

class InfluencerStatusBlocInitial extends InfluencerStatusBlocState {}


class InfluencerStatusLoaded extends InfluencerStatusBlocState {
  const InfluencerStatusLoaded({bool? status})
      : super(isFollowed: status);
}
