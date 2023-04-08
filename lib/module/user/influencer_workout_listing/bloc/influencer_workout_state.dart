import 'package:flutter/material.dart';

import '../../models/dashboard/tag_search_influencer_model.dart';
import '../../models/dashboard/user_dashboard_model.dart';

@immutable
abstract class InfluencerWorkoutState {
  final TagSearchInfluencerModel? tagSearchInfluencerModel;

  const InfluencerWorkoutState({this.tagSearchInfluencerModel});
}

class InfluencerWorkoutInitialState extends InfluencerWorkoutState {}

class InfluencerWorkoutEmptyState extends InfluencerWorkoutState {
  const InfluencerWorkoutEmptyState() : super();
}

class InfluencerWorkoutLoadingState extends InfluencerWorkoutState {
  const InfluencerWorkoutLoadingState() : super();
}

class InfluencerWorkoutLoadedState extends InfluencerWorkoutState {
  const InfluencerWorkoutLoadedState(
      {TagSearchInfluencerModel? tagSearchInfluencerModel})
      : super(tagSearchInfluencerModel: tagSearchInfluencerModel);
}

class InternetErrorState extends InfluencerWorkoutState {
  final String error;

  InternetErrorState({required this.error});
}
