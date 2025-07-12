// ignore_for_file: constant_identifier_names

/// Language data
class LangData {
  static const Map<String, String> DEFINED_CODES = {
    "ar": "Arabic",
    "bg": "Bulgarian",
    "ca": "Catalan",
    "cs": "Czech",
    "de": "German",
    "el": "Greek",
    "en": "English",
    "es": "Spanish",
    "fi": "Finnish",
    "fr": "French",
    "hr": "Croatian",
    "hu": "Hungarian",
    "id": "Indonesian",
    "it": "Italian",
    "ja": "Japanese",
    "ko": "Korean",
    "ms": "Malay",
    "nl": "Dutch",
    "no": "Norwegian",
    "pl": "Polish",
    "pt-br": "Portuguese (Brazil)",
    "pt-pt": "Portuguese (Portugal)",
    "ro": "Romanian",
    "ru": "Russian",
    "sk": "Slovak",
    "sr": "Serbian",
    "sv": "Swedish",
    "ta": "Tamil",
    "th": "Thai",
    "tr": "Turkish",
    "uk": "Ukrainian",
    "vi": "Vietnamese",
    "zh-Hans": "Simplified Chinese",
    "zh-Hant": "Traditional Chinese",
  };

  static const Map<String, String> DEFINED_CODES_ORIGIN = {
    "ar": "Arabic",
    "de": "German",
    "en": "English",
    "es": "Spanish",
    "fr": "French",
    "id": "Indonesian",
    "ja": "Japanese",
    "ko": "Korean",
    "pt-br": "Portuguese (Brazil)",
    "ru": "Russian",
    "ta": "Tamil",
    "th": "Thai",
    "tr": "Turkish",
    "vi": "Vietnamese",
    "zh-Hans": "Simplified Chinese",
    "zh-Hant": "Traditional Chinese",
  };

  static const String notFoundString = "Others";
  static const String notFoundFlag = "xx";

  static String getFullLanguage(String key) => DEFINED_CODES[key] ?? notFoundString;
  static String getFlagPath(String key) {
    if (DEFINED_CODES[key] != null) {
      return "assets/images/flags/$key.png";
    }
    return "assets/images/flags/$notFoundFlag.png";
  }
}
