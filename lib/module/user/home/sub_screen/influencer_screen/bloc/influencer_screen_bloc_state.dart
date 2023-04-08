import 'package:app/module/influencer/workout/model/get_influencer.dart';
import 'package:app/module/user/models/influencer_follow_status.dart';
import 'package:flutter/material.dart';

@immutable
abstract class InfluencerblocState {
  final GetInfluencerModel? influencerModel;

  const InfluencerblocState({this.influencerModel});
}

class InfluencerblocInitial extends InfluencerblocState {}

class InfluencerDataLoaded extends InfluencerblocState {
  const InfluencerDataLoaded({GetInfluencerModel? influencerModel})
      : super(influencerModel: influencerModel);
}

