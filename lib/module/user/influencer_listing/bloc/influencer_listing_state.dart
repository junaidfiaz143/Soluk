import 'package:app/module/user/models/dashboard/influencer_blog_view_all_model.dart';
import 'package:app/module/user/models/dashboard/influencer_view_all_model.dart';
import 'package:flutter/material.dart';

import '../../models/dashboard/influencer_workput_view_all_model.dart';
import '../../models/dashboard/user_dashboard_model.dart';

@immutable
abstract class InfluenceListingState {
  final InfluencerViewAllModel? influencerViewAllModel;
  final InfluencerBlogsViewAllModel? influencerBlogsViewAllModel;
  final InfluencerWorkoutViewAllModel? influencerWorkoutViewAllModel;

  const InfluenceListingState({this.influencerViewAllModel,this.influencerBlogsViewAllModel,this.influencerWorkoutViewAllModel});
}

class InfluencerListingInitialState extends InfluenceListingState {}

class InfluencerListingEmptyState extends InfluenceListingState {
  const InfluencerListingEmptyState() : super();
}

class InfluencerListingLoadingState extends InfluenceListingState {
  const InfluencerListingLoadingState() : super();
}

class InfluencerListingLoadedState extends InfluenceListingState {
  const InfluencerListingLoadedState(
      {InfluencerViewAllModel? influencerViewAllModel,InfluencerBlogsViewAllModel? influencerBlogsViewAllModel,InfluencerWorkoutViewAllModel? influencerWorkoutViewAllModel})
      : super(influencerViewAllModel: influencerViewAllModel,influencerBlogsViewAllModel: influencerBlogsViewAllModel,influencerWorkoutViewAllModel: influencerWorkoutViewAllModel);
}

class InternetErrorState extends InfluenceListingState {
  final String error;

  InternetErrorState({required this.error});
}
