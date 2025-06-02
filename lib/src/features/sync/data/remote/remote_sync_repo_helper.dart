import 'package:vndb_lite/src/features/collection/domain/record.dart';

// TODO create class for this?

//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// This file contains helper functions for the remoteSyncRepo class

/// Returns true if records are comparable, returns false if both records are equal -- Simply
/// means just pick one operation either ifLocal or ifRemote as there are no changes and both should
/// do fine.
Future<bool> compareNewerRecords(
  VnRecord localRecord,
  Map<String, dynamic> cloudRecord, {
  required Future<void> Function() ifLocal,
  required Future<void> Function() ifRemote,
}) async {
  final int localLastMod =
      int.tryParse(localRecord.lastmod ?? 'f') ?? (DateTime.now().millisecondsSinceEpoch ~/ 1000);
  if (localLastMod > (cloudRecord['lastmod'] ?? 0)) {
    await ifLocal();
    return true;
  }

  if (localLastMod < (cloudRecord['lastmod'] ?? 0)) {
    await ifRemote();
    return true;
  }

  await ifRemote();
  return false;
}

int getVnCloudVote(Map<String, dynamic> cloudRecord) {
  if (cloudRecord['vote'] != null && cloudRecord['vote'] != 0) {
    return (cloudRecord['vote'] / 10).toInt();
  }
  return 0;
}

String getVnCloudDate(String whatDate, Map<String, dynamic> cloudRecord) {
  if (whatDate == 'added') {
    return "${DateTime.fromMillisecondsSinceEpoch((cloudRecord[whatDate] ?? 0) * 1000)}";
  }

  // Will return string of null to be easily comparable.
  if (cloudRecord[whatDate] == null ||
      cloudRecord[whatDate] == 'null' ||
      cloudRecord[whatDate]?.contains('1970-01-01')) {
    return 'null';
  }

  return cloudRecord[whatDate].toString().substring(0, 10);
}

bool localVnHasVote(VnRecord localRecord) {
  return localRecord.vote != 0;
}

String getLocalVnDate(String whatDate, Map<String, dynamic> localRecord) {
  // 1970-01-01 is just a placeholder.
  if (localRecord[whatDate].contains("null") || localRecord[whatDate] == null) return '1970-01-01';
  return localRecord[whatDate].substring(0, 10);
}


//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//


