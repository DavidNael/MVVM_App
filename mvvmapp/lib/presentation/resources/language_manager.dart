enum LanguageType {
  english,
  arabic,
}

const String arabicCode = "ar";
const String englishCode = "en";

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return englishCode;
      case LanguageType.arabic:
        return arabicCode;
      default:
        return englishCode;
    }
  }
}
