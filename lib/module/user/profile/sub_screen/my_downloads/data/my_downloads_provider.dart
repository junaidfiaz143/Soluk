import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MyDownloadProvider {
  Future<List<MyInfluencersModel>> getInfluencersList() async {
    List<MyInfluencersModel> myList = [];
    final directory = (await getApplicationDocumentsDirectory()).path;

    final file = Directory("$directory/").listSync();
    if (file.length > 0) {
      for (var f in file) {
        if (f.path.toString().split("/").last.contains("download_")) {
          myList.add(MyInfluencersModel(f.path));
        }
      }
    } else {
      myList.add(MyInfluencersModel("Umair Mustafa"));
      myList.add(MyInfluencersModel("Ali"));
      myList.add(MyInfluencersModel("Anthony"));
      myList.add(MyInfluencersModel("Bill"));
    }
    return myList;
  }
}
