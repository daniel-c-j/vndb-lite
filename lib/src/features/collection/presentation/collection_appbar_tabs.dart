import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/features/collection/data/collection_status_data.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_content_controller.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';

import '../../../util/context_shortcut.dart';

class CollectionAppBarTabs extends ConsumerWidget implements PreferredSizeWidget {
  const CollectionAppBarTabs({super.key});

  /// Global tab controller to maintain keep-Alive behaviour for the controller.
  static late final TabController? controller;
  static final height = responsiveUI.own(0.1);

  @override
  Size get preferredSize => Size(0, height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsGeneralStateProvider);
    final statusArrangement = settings.collectionStatusTabArrangement;

    return SizedBox(
      height: height,
      child: TabBar(
        dividerHeight: 0,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        controller: controller,
        indicatorPadding: EdgeInsets.only(
          left: responsiveUI.own(0.04),
          right: responsiveUI.own(0.02),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: kColor(context).tertiary,
        labelStyle: const TextStyle(fontWeight: FontWeight.w500),
        tabs: [
          for (String statusCode in statusArrangement)
            Tab(
              key: ValueKey<String>(statusCode),
              height: height,

              child: Padding(
                padding: EdgeInsets.only(bottom: responsiveUI.own(0.01)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: responsiveUI.own(0.01)),
                      child: Image.asset(
                        'assets/images/status/$statusCode.png',
                        width: responsiveUI.own(0.055),
                        height: responsiveUI.own(0.055),
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final vnItemGrids = ref.watch(collectionContentControllerProvider);
                        final notifyCollection = ref.watch(collectionContentNotifierProvider);

                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          if (notifyCollection) {
                            ref.read(collectionContentNotifierProvider.notifier).end();
                          }
                        });

                        return ShadowText(
                          '${toBeginningOfSentenceCase<String>(statusCode)} '
                          '(${(vnItemGrids[statusCode] ?? []).length})',
                          fontSize: responsiveUI.own(0.038),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Init class to exploit [SingleTickerProviderStateMixin] for collectionTabController's vsync.
class CollectionTabConf extends StatefulWidget {
  const CollectionTabConf({super.key});

  @override
  State<CollectionTabConf> createState() => _CollectionTabConfState();
}

class _CollectionTabConfState extends State<CollectionTabConf> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final controller = TabController(length: COLLECTION_STATUS_DATA.length, vsync: this);
    CollectionAppBarTabs.controller = controller;
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
