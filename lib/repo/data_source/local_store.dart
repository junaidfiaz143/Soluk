import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStore {
  static String boxName = 'salok';
  // static String directoryKey = 'saluk';

  static var _box;
  static Future<void> init() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocDirectory.path);
    _box = await Hive.openBox(boxName);
  }

  static Future<bool> saveData(String key, dynamic value) async {
    try {
      if (Hive.isBoxOpen(boxName) == false) {
        await init();
      }
      await _box.put(key, json.encode(value));
      return true;
    } catch (exception) {
      log("Error while saving data from Hive DB.");
      return false;
    }
  }

  static Future getData(String key) async {
    try {
      if (Hive.isBoxOpen(boxName) == false) {
        await init();
      }
      if (key == 'fcm') {
        try {
          await init();
        } catch (ex) {
          log('exception while closing, and initiating Hive when key was "fcm"');
        }
      }
      String? data = _box.get(key);
      if (data == null) {
        return null;
      }
      return json.decode(data);
    } catch (exception) {
      log("Error while fetching data from Hive DB.");
      return null;
    }
  }

  static Future<bool> removeData(String key) async {
    try {
      if (Hive.isBoxOpen(boxName) == false) {
        await init();
      }

      await _box.delete(key);
      return true;
    } catch (exception) {
      log("Error while removing data from Hive DB.");
      return false;
    }
  }

  static Future<bool> deleteData() async {
    try {
      if (Hive.isBoxOpen(boxName) == false) {
        await init();
      }

      await _box.deleteFromDisk();
      return true;
    } catch (exception) {
      log("Error while removing data from Hive DB.");
      return false;
    }
  }

  static Future<bool> isKeyExist(String key) async {
    try {
      if (Hive.isBoxOpen(boxName) == false) {
        await init();
      }
      await _box.containsKey(key);
      return true;
    } catch (exception) {
      log("Error while checking data from Hive DB.");
      return false;
    }
  }
}
