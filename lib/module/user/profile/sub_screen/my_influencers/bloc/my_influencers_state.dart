import 'package:app/module/user/models/my_influencers/my_influencers_response.dart';

abstract class MyInfluencersState {
  final MyInfluencersResponse? myInfluencersModel;

  MyInfluencersState({this.myInfluencersModel});
}

class MyInfluencersLoadingState extends MyInfluencersState {
  MyInfluencersLoadingState() : super();
}

class MyInfluencersEmptyState extends MyInfluencersState {

  MyInfluencersEmptyState() : super();
}

class MyInfluencersDataLoaded extends MyInfluencersState {
  MyInfluencersDataLoaded(MyInfluencersResponse myInfluencersModel)
      : super(myInfluencersModel: myInfluencersModel);
}
