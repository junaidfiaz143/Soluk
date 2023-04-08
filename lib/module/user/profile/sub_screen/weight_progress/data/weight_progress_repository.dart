import 'package:app/module/user/profile/sub_screen/weight_progress/data/weight_progress_provider.dart';

class WeightProgressRepository {
  Future<dynamic> getWeightProgress() async {
    WeightProgressProvider weightProgressProvider = WeightProgressProvider();
    return weightProgressProvider.getWeightProgressList();
  }
  Future<bool> deleteWeightProgress(String id) async {
    WeightProgressProvider weightProgressProvider = WeightProgressProvider();
    return weightProgressProvider.deleteWeightProgress(id);
  }
}
