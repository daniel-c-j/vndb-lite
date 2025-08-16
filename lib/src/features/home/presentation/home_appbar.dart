import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/buttons/refresh_button.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/buttons/sync_button.dart';
import 'package:vndb_lite/src/features/sync/presentation/auth_screen_controller.dart';

class HomeBarActions extends StatelessWidget {
  const HomeBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        Consumer(
          builder: (context, ref, child) {
            final isUserAuthed = ref.watch(authScreenControllerProvider) != null;

            if (isUserAuthed) return const AppBarSyncButton();
            return const SizedBox.shrink();
          },
        ),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        const AppBarRefreshButton(),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
      ],
    );
  }
}
