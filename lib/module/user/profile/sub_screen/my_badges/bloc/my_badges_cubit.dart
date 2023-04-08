import 'package:app/module/user/models/my_badges_response.dart';
import 'package:app/module/user/profile/sub_screen/my_badges/data/my_badges_repository.dart';
import 'package:bloc/bloc.dart';

import 'my_badges_state.dart';

class MyBadgesCubit extends Cubit<MyBadgesState> {
  MyBadgesCubit(MyBadgesState initialState) : super(initialState);

  List<int> badgesCountList = [0,0,0,0];
  // '3': 'Silver',
  // '5': 'Bronze',
  // '2': 'Gold',
  // '1': 'Soluk'

  Map<String, int> badgesCount = {
  };
  getUserBadgeCount(MyBadgesResponse response){

      response.responseDetails?.userBadgeDetailCount?.data?.forEach((element) {

        switch(element.badgeTitle!){
          case "Silver":
            badgesCountList[0]=element.badgeCount??0;
            badgesCount['Silver'] = element.badgeCount!;
            break;

          case "Bronze":
            badgesCountList[1]=element.badgeCount??0;
            badgesCount['Bronze'] = element.badgeCount!;
            break;

          case "Gold":
            badgesCountList[2]=element.badgeCount??0;
            badgesCount['Gold'] = element.badgeCount!;
            break;

          case "Soluk":
            badgesCountList[3]=element.badgeCount??0;
            badgesCount['Soluk'] = element.badgeCount!;
            break;

        }

      });

  }

  MyBadgesRepository myBadgesRepository = MyBadgesRepository();
  getBadgesList() async {
    // if(initial)
    emit(MyBadgesLoadingState());
    MyBadgesResponse response = await myBadgesRepository.getMyBadgesList();
    if (response != null) {
      getUserBadgeCount(response);
      emit(MyBadgesDataLoaded(response));
    } else {
      emit(MyBadgesEmptyState());
    }

  }
}
