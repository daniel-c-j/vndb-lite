import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:vndb_lite/src/routing/app_router.dart';

import '../constants/_constants.dart';
import '../util/delay.dart';

/// Simple not found screen used for 404 errors (page not found on web).
class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({super.key, this.redirect = true});

  static const titleKey = Key("NotFoundScreenTitleKey");
  static const messageKey = Key("NotFoundScreenMessageKey");

  final bool redirect;

  @override
  State<NotFoundScreen> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  @override
  void initState() {
    super.initState();

    /// ? After 3 seconds widget is built, user will be redirected to the home page.
    if (widget.redirect) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        delay(true, 3000).then((_) => context.goNamed(AppRoute.home.name));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404 - Page not found!',
              key: NotFoundScreen.titleKey,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            GAP_H8,
            Text(
              'Redirecting to home page...',
              key: NotFoundScreen.messageKey,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
