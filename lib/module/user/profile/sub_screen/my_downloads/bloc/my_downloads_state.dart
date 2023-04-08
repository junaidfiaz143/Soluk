import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';

abstract class MyDownloadState {
  final List<MyInfluencersModel> myInfluencersModel;

  MyDownloadState({this.myInfluencersModel = const []});
}

class MyDownloadLoadingState extends MyDownloadState {
  MyDownloadLoadingState() : super();
}

class MyDownloadEmptyState extends MyDownloadState {
  MyDownloadEmptyState() : super();
}

class MyDownloadDataLoaded extends MyDownloadState {
  MyDownloadDataLoaded(List<MyInfluencersModel> myInfluencersModel)
      : super(myInfluencersModel: myInfluencersModel);
}
