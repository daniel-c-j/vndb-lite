import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vndb_lite/src/features/_base/presentation/main_outer_layout.dart';
import 'package:vndb_lite/src/features/_base/presentation/other_parts/main_inner_layout.dart';
import 'package:vndb_lite/src/features/search/presentation/search_result.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/debouncer.dart';
import 'package:vndb_lite/src/util/delay.dart';

/// A widget that hides its child when the user scrolls down and shows it again when the user scrolls up.
/// This behavior is commonly used to hide elements like a bottom navigation bar to provide a more immersive user experience.
class ScrollToHide extends StatefulWidget {
  /// Creates a `ScrollToHide` widget.
  ///
  /// The [child], [scrollController], and [height] parameters are required.
  /// The [duration] parameter is optional and defaults to 300 milliseconds.
  ///
  /// The [child] is the widget that you want to hide/show based on the scroll direction.
  ///
  /// The [scrollController] is the `ScrollController` that is connected to the scrollable widget in your app.
  /// This is used to track the scroll position and determine whether to hide or show the child widget.
  ///
  /// The [height] is the initial height of the child widget. When the widget is hidden, its height will be animated to 0.
  const ScrollToHide({
    super.key,
    required this.child,
    required this.scrollController,
    this.duration = const Duration(milliseconds: 300),
    required this.hideDirection,
    this.width,
    this.height,
  });

  /// The widget that you want to hide/show based on the scroll direction.
  final Widget child;

  /// The `ScrollController` that is connected to the scrollable widget in your app.
  /// This is used to track the scroll position and determine whether to hide or show the child widget.
  final ScrollController scrollController;

  /// The duration of the animation when the child widget is hidden or shown.
  final Duration duration;

  /// The initial height of the child widget. When the widget is hidden, its height will be animated to 0.
  final double? height;

  /// The initial width of the child widget, its width will be animated to 0 .by providing width you want the hide direction to be horizontal.
  final Axis hideDirection;

  /// The initial width of the child widget, its width will be animated to 0 .by providing width you want the hide direction to be horizontal.
  final double? width;

  @override
  State<ScrollToHide> createState() => _ScrollToHideState();
}

class _ScrollToHideState extends State<ScrollToHide> {
  bool isShown = true;
  final _debouncer = Debouncer();

  @override
  void initState() {
    widget.scrollController.addListener(listen);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(listen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hideDirection == Axis.horizontal) {
      return AnimatedSize(
        duration: widget.duration,
        curve: Curves.linear,
        child: ClipRect(
          clipBehavior: Clip.none,
          child: SizedBox(
            height: widget.height,
            width: (isShown) ? widget.width : 0,
            child: widget.child,
          ),
        ),
      );
    }

    return AnimatedContainer(
      duration: widget.duration,
      height: (isShown) ? widget.height : 0,
      width: widget.width,
      curve: Curves.linear,
      clipBehavior: Clip.none,
      child: Wrap(children: [widget.child]),
    );
  }

  /// Shows the child widget if it is currently hidden.
  void show() {
    if (!isShown && mounted) {
      setState(() => isShown = true);
    }
  }

  /// Hides the child widget if it is currently shown.
  void hide() {
    if (isShown && mounted) {
      setState(() => isShown = false);
    }
  }

  void listen() async {
    final direction = widget.scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) hide();

    _debouncer.call(() async {
      await delay(true, 300);
      return show();
    });
  }
}
