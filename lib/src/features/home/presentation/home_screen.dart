import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/home/data/preview_sections_data.dart';
import 'package:vndb_lite/src/features/home/presentation/section/section_content.dart';
import 'package:vndb_lite/src/features/home/presentation/section/section_header.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsGeneralStateProvider);

    return Padding(
      padding: EdgeInsets.only(left: responsiveUI.own(0.045), right: responsiveUI.own(0.045)),
      child: Column(
        children: [
          for (HomeSectionsCode sectionCode in settings.homeSectionsArrangement)
            Column(
              mainAxisSize: MainAxisSize.min,
              key: ValueKey(sectionCode),
              children: [
                HomeSectionHeader(sectionData: sectionCode),
                HomeSectionContent(sectionData: sectionCode, maxItem: settings.maxPreviewItem),
                SizedBox(height: responsiveUI.own(0.04)),
              ],
            ),
        ],
      ),
    );
  }
}
