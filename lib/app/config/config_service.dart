import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ConfigService extends GetxService {
  static const _themeKey = 'isDarkMode';
  static const _langKey = 'languageCode';

  final _box = GetStorage();

  Future<ConfigService> init() async {
    await GetStorage.init();
    return this;
  }

  /// Theme
  bool get isDarkMode => _box.read(_themeKey) ?? false;
  void saveTheme(bool isDark) => _box.write(_themeKey, isDark);

  /// Language
  String get languageCode => _box.read(_langKey) ?? 'en';
  void saveLanguage(String code) => _box.write(_langKey, code);
}
