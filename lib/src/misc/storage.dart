import 'package:get_storage/get_storage.dart';

class Storage {
  static GetStorage box = GetStorage();

  static dynamic get(key) {
    return box.read(key);
  }

  static void remove(key) async {
    await box.remove(key);
  }

  static bool hasData(key) {
    return box.hasData(key);
  }

  static void save(key, value) async {
    await box.write(key, value);
  }

  static void clearAll() async {
    await box.erase();
  }
}
