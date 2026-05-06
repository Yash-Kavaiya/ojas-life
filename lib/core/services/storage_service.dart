import 'package:hive_flutter/hive_flutter.dart';

abstract final class HiveBoxes {
  static const prefs = 'prefs';
  static const foodDiary = 'food_diary';
  static const journal = 'journal';
  static const streaks = 'streaks';
  static const bookmarks = 'bookmarks';
  static const downloads = 'downloads';
}

class StorageService {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox<dynamic>(HiveBoxes.prefs),
      Hive.openBox<dynamic>(HiveBoxes.foodDiary),
      Hive.openBox<dynamic>(HiveBoxes.journal),
      Hive.openBox<dynamic>(HiveBoxes.streaks),
      Hive.openBox<dynamic>(HiveBoxes.bookmarks),
      Hive.openBox<dynamic>(HiveBoxes.downloads),
    ]);
  }

  static Box<dynamic> get prefs => Hive.box<dynamic>(HiveBoxes.prefs);
  static Box<dynamic> get foodDiary => Hive.box<dynamic>(HiveBoxes.foodDiary);
  static Box<dynamic> get journal => Hive.box<dynamic>(HiveBoxes.journal);
  static Box<dynamic> get streaks => Hive.box<dynamic>(HiveBoxes.streaks);
  static Box<dynamic> get bookmarks => Hive.box<dynamic>(HiveBoxes.bookmarks);
  static Box<dynamic> get downloads => Hive.box<dynamic>(HiveBoxes.downloads);
}
