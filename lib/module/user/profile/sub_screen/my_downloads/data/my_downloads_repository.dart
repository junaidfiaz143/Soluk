import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';
import 'package:app/module/user/profile/sub_screen/my_downloads/data/my_downloads_provider.dart';

class MyDownloadRepository {
  Future<List<MyInfluencersModel>> getAllInfluencers() async {
    MyDownloadProvider myInfluencersProvider = MyDownloadProvider();
    return myInfluencersProvider.getInfluencersList();
  }
}
