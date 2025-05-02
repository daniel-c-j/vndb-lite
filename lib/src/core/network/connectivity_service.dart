import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_service.g.dart';

// TODO ref.watch() this in every class that need to call remote.
// TODO watchout for keepAlive:true

/// Since golden test does not like internetConnection listening for its status, that's why this exists.
@visibleForTesting
bool canListenToNetworkStatusChange = true;

/// Watching this will cause the widget to rebuild based on the internet connectivity status.
@Riverpod(keepAlive: true)
class ConnectivityNotifier extends _$ConnectivityNotifier {
  @override
  bool build() {
    ref.onDispose(() {
      _subscription?.cancel();
    });

    return false;
  }

  final _internetConnectionChecker = InternetConnection();
  StreamSubscription<InternetStatus>? _subscription;

  ConnectivityNotifier() {
    if (!canListenToNetworkStatusChange) return;
    // Continuously listen for internet connection changes.
    _subscription = _internetConnectionChecker.onStatusChange.listen(
      (InternetStatus status) {
        // Updates state to true when the condition is true, vice-versa.
        state = status == InternetStatus.connected;
      },
      onError: (error) {
        state = false;
      },
    );
  }
}
