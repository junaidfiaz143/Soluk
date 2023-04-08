import 'package:app/module/user/models/my_badges_response.dart';
import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';

abstract class MyBadgesState {
  MyBadgesResponse? myBadgesModelResponse;

  MyBadgesState({this.myBadgesModelResponse});
}

class MyBadgesLoadingState extends MyBadgesState {
  MyBadgesLoadingState() : super();
}

class MyBadgesEmptyState extends MyBadgesState {
  MyBadgesEmptyState() : super();
}

class MyBadgesDataLoaded extends MyBadgesState {
  MyBadgesDataLoaded(MyBadgesResponse myBadgesModelResponse)
      : super(myBadgesModelResponse: myBadgesModelResponse);
}
