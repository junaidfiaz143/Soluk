import 'package:app/module/influencer/workout/hive/classes/about.dart';
import 'package:app/res/constants.dart';
import 'package:hive/hive.dart';

class MyHive {
  static const String _aboutMeDb = 'plan';

  static late Box _ins;

  Box get ins => _ins;

  static init() async {
    // Hive.registerAdapter(AboutMeInfoAdapter());
    _ins = await Hive.openBox('workoutplan');
    await Hive.openBox(LSKeyGroceryBox);
  }

  deleteBox() async {
    await _ins.delete('workoutplan');
  }

  static setAboutInfo({required String? aboutMeInfo}) {
    _ins.put(_aboutMeDb, aboutMeInfo);
  }

  static getAboutInfo() {
    return _ins.get(_aboutMeDb, defaultValue: null);
  }
}
