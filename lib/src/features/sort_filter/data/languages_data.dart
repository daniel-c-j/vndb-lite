// ignore_for_file: constant_identifier_names

/// Language data
class LangData {
  static const Map<String, String> DEFINED_CODES = {
    'ar': 'Arabic',
    'no': 'Norwegian',
    'bg': 'Bulgarian',
    'ta': 'Tamil',
    'cs': 'Czech',
    'es': 'Spanish',
    'ja': 'Japanese',
    'hu': 'Hungarian',
    'en': 'English',
    'sk': 'Slovak',
    'ko': 'Korean',
    'de': 'German',
    'id': 'Indonesian',
    'fr': 'French',
    'ca': 'Catalan',
    'tr': 'Turkish',
    'it': 'Italian',
    'ru': 'Russian',
    'ms': 'Malay',
    'uk': 'Ukrainian',
    'sr': 'Serbian',
    'el': 'Greek',
    'nl': 'Dutch',
    'th': 'Thai',
    'hr': 'Croatian',
    'vi': 'Vietnamese',
    'sv': 'Swedish',
    'ro': 'Romanian',
    'fi': 'Finnish',
    'pl': 'Polish',
    'pt-pt': 'Portuguese (Portugal)',
    'pt-br': 'Portuguese (Brazil)',
    'zh-Hans': 'Simplified Chinese',
    'zh-Hant': 'Traditional Chinese',
  };

  static const Map<String, String> DEFINED_CODES_ORIGIN = {
    'es': 'Spanish',
    'ja': 'Japanese',
    'en': 'English',
    'ko': 'Korean',
    'de': 'German',
    'id': 'Indonesian',
    'fr': 'French',
    'tr': 'Turkish',
    'ru': 'Russian',
    'th': 'Thai',
    'vi': 'Vietnamese',
    'pt-br': 'Portuguese (Brazil)',
    'zh-Hans': 'Simplified Chinese',
    'zh-Hant': 'Traditional Chinese',
  };

  static const String notFoundString = "Others";
  static const String notFoundFlag = "xx";

  static String getFullLanguage(String key) => DEFINED_CODES[key] ?? notFoundString;
  static String getFlagPath(String key) {
    try {
      return "assets/images/flags/$key.png";
    } catch (e) {
      return "assets/images/flags/$notFoundFlag.png";
    }
  }
}
