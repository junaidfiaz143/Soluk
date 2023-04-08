import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';
import 'package:app/module/user/profile/sub_screen/my_badges/data/my_badges_provider.dart';
import 'package:app/module/user/profile/sub_screen/my_challenges/data/my_challenges_provider.dart';

class MyBadgesRepository {
  MyBadgesProvider myBadgesProvider = MyBadgesProvider();

  Future<dynamic> getMyBadgesList() async {
    return myBadgesProvider.getMyBadgesList();
  }
}
