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
  static const String URL_CHECK_VERSION =
      "https://raw.githubusercontent.com/Daniel-C-J/vndb-lite/refs/heads/master/VERSION.json";
  static const String URL_UPDATE_VERSION =
      "https://github.com/Daniel-C-J/vndb-lite/releases/latest";

  // API base url.
  static const String BASE_URL = "https://api.vndb.org";

  static const String P1_FIELDS =
      "title, image.url, image.sexual, image.violence, image.thumbnail, length, rating, "
      "votecount, olang, released, description";

  static const String P2a_FIELDS =
      "aliases, length_minutes, devstatus, developers.name, screenshots.id, "
      "screenshots.sexual, screenshots.violence, tags.id, tags.spoiler, tags.name, tags.rating, platforms, languages";

  static const String P2b_FIELDS = "minage, languages.mtl, languages.lang";

  static const String P3_FIELDS =
      "extlinks.url, relations.id, relations.title, relations.relation, relations.relation_official, "
      "relations.image.url, relations.image.sexual, relations.image.violence, relations.image.thumbnail, "
      "relations.length, relations.votecount, relations.olang, relations.released, relations.rating, "
      "relations.description";

  static const String USER_VNS_FIELDS =
      "id, vote, vn.title, added, started, finished, labels.label, lastmod, notes";
}
