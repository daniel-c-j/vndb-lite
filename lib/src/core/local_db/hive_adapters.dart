// coverage:ignore-file

import 'package:hive_ce/hive.dart';

import '../../constants/_constants.dart';

part 'hive_adapters.g.dart';

// TODO when using hive.
@GenerateAdapters([
  // AdapterSpec<CipherAction>(),
  // AdapterSpec<CipherAlgorithmType>(),
  // AdapterSpec<CipherAlgorithm>(),
])
class HiveAdapters {}

// TODO when using hive.
extension HiveRegistrar on HiveInterface {
  Future<void> initBoxes() async {
    await Hive.openBox<bool>(DBKeys.BRIGHTNESS_BOX);
    await Hive.openBox<int>(DBKeys.CIPHER_REPO_BOX);
  }
}
