import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:flutter/material.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/record_selected_controller.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

class MultiSelectionIndicator extends ConsumerStatefulWidget {
  const MultiSelectionIndicator(this.id, {super.key});

  final String id;

  @override
  ConsumerState<MultiSelectionIndicator> createState() => _MultiSelectionIndicatorState();
}

class _MultiSelectionIndicatorState extends ConsumerState<MultiSelectionIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    final isMultiSelection = ref.read(recordSelectedControllerProvider).isNotEmpty;

    _animationController = AnimationController(
      vsync: this,
      duration:
          (mounted && isMultiSelection)
              ? const Duration(milliseconds: 0)
              : const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController.drive(CurveTween(curve: Curves.ease)),
      child: GestureDetector(
        onTap: () {
          final recordSelected = ref.read(recordSelectedControllerProvider);

          // In multiselection.
          if (recordSelected.contains(widget.id)) {
            recordSelected.remove(widget.id);
          } else {
            recordSelected.add(widget.id);
          }

          // In order to refresh appbar
          ref.invalidate(recordSelectedControllerProvider);

          // Turning multiselection mode off if empty
          if (recordSelected.isEmpty) return;
          ref.read(recordSelectedControllerProvider.notifier).record = recordSelected;
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                kColor(context).primary.withOpacity(0.2),
                kColor(context).secondary.withOpacity(0.5),
              ],
            ),
            boxShadow: const [
              BoxShadow(color: Color.fromARGB(50, 0, 0, 0), spreadRadius: 2, blurRadius: 6),
            ],
            border: GradientBoxBorder(
              gradient: RadialGradient(
                colors: [
                  kColor(context).secondary.withOpacity(0.9),
                  kColor(context).secondary.withOpacity(0.6),
                  kColor(context).tertiary.withOpacity(0.4),
                ],
              ),
              width: 2.5,
            ),
          ),
        ),
      ),
    );
  }
}
