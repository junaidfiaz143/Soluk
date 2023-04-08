import 'package:app/module/user/models/my_influencers/my_influencers_response.dart';

import 'my_influencers_provider.dart';

class MyInfluencerRepository {

  MyInfluencersProvider provider = MyInfluencersProvider();

  Future<MyInfluencersResponse?> getMyInfluencerList() async {
    return provider.getMyInfluencerList();
  }
}
