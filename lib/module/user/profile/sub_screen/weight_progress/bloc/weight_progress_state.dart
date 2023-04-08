import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';
import 'package:app/module/user/models/my_workout_response.dart';
import 'package:app/module/user/models/weight_progress_response.dart';

abstract class WeightProgressState {
  final WeightProgressResponse? weightProgressResponse;

  WeightProgressState({this.weightProgressResponse});
}

class WeightProgressLoadingState extends WeightProgressState {
  WeightProgressLoadingState() : super();
}

class WeightProgressEmptyState extends WeightProgressState {
  WeightProgressEmptyState() : super();
}

class WeightProgressDataLoaded extends WeightProgressState {
  WeightProgressDataLoaded(WeightProgressResponse weightProgressResponse)
      : super(weightProgressResponse: weightProgressResponse);
}
