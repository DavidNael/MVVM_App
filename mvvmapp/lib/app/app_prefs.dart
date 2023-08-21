import 'package:mvvmapp/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyLang = "appLanguage";
const String prefsKeyShowOnboarding = "showOnboarding";
const String prefsKeyIsLoggedIn = "isLoggedIn";

class AppPreferences {
  final SharedPreferences sharedPreferences;
  AppPreferences(this.sharedPreferences);

  Future<String> getAppLanguage() async {
    return sharedPreferences.getString(prefsKeyLang) ??
        LanguageType.english.getValue();
  }

  Future<bool> setAppLanguage(String lang) async {
    return await sharedPreferences.setString(prefsKeyLang, lang);
  }

  Future<bool> getShowOnboarding() async {
    return sharedPreferences.getBool(prefsKeyShowOnboarding) ?? true;
  }

  Future<bool> setShowOnboarding(bool show) async {
    return await sharedPreferences.setBool(prefsKeyShowOnboarding, show);
  }

  Future<bool> getIsLoggedIn() async {
    return sharedPreferences.getBool(prefsKeyIsLoggedIn) ?? false;
  }

  Future<bool> setIsLoggedIn(bool isLoggedIn) async {
    return await sharedPreferences.setBool(prefsKeyIsLoggedIn, isLoggedIn);
  }
}
