import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/text_extensions.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('404 - Page not found!', key: NotFoundScreen.titleKey).wSize(20).bold,
              GAP_H8,
              const Text('Redirecting to home page...', key: NotFoundScreen.messageKey).wSize(14),
            ],
          ),
        ),
      ),
    );
  }
}
