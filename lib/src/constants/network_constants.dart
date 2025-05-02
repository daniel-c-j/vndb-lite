// ignore_for_file: constant_identifier_names, non_constant_identifier_names

/// Data container containing network constants.
class NetConsts {
  // [Dio] configuration.
  static const String APPLICATION_JSON = "application/json";
  static const String CONTENT_TYPE = "content-type";
  static const String AUTHORIZATION = "Authorization";
  static const String ACCEPT = "accept";
  static const int API_TIMEOUT = 60000;

  // Used for [VersionCheck].
  static late final String URL_CHECK_VERSION;
  static late final String URL_UPDATE_VERSION;

  // API base url.
  static late final String BASE_URL;

  static const String P1_FIELDS =
      "title, image.url, image.sexual, image.violence, length, rating, "
      "votecount, olang, released, description";

  static const String P2a_FIELDS =
      "aliases, length_minutes, devstatus, developers.name, screenshots.id, "
      "screenshots.sexual, screenshots.violence, tags.id, tags.spoiler, tags.name, tags.rating, platforms, languages";

  static const String P2b_FIELDS = "minage, languages.mtl, languages.lang";

  static const String P3_FIELDS =
      "extlinks.url, relations.id, relations.title, relations.relation, relations.relation_official, "
      "relations.image.url, relations.image.sexual, relations.image.violence, relations.length, relations.votecount, "
      "relations.olang, relations.released, relations.rating, relations.description";

  static const String USER_VNS_FIELDS =
      "id, vote, vn.title, added, started, finished, labels.label";

  /// Lazy Initialization exists for the ease of testing to manipulate certain properties of [NetConsts].
  static void init() {
    BASE_URL = 'https://api.vndb.org';
    
    // TODO INSERT
    URL_CHECK_VERSION = "";
    URL_UPDATE_VERSION = "";
  }
}
