import 'package:mvvmapp/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyLang = "appLanguage";

class AppPreferences {
  final SharedPreferences sharedPreferences;
  AppPreferences(this.sharedPreferences);

  Future<String> getAppLanguage() async {
    return sharedPreferences.getString(prefsKeyLang) ??
        LanguageType.english.getValue();
  }
}
