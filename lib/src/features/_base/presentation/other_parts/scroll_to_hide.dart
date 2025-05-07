import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final showBottomNavBarProvider = StateProvider<bool>((ref) => true);

/// A widget that hides its child when the user scrolls down and shows it again when the user scrolls up.
/// This behavior is commonly used to hide elements like a bottom navigation bar to provide a more immersive user experience.
class ScrollToHide extends ConsumerWidget {
  /// Creates a `ScrollToHide`
  ///
  /// The [child], [scrollController], and [height] parameters are required.
  /// The [duration] parameter is optional and defaults to 300 milliseconds.
  ///
  /// The [child] is the widget that you want to hide/show based on the scroll direction.
  ///
  /// The [scrollController] is the `ScrollController` that is connected to the scrollable widget in your app.
  /// This is used to track the scroll position and determine whether to hide or show the child
  ///
  /// The [height] is the initial height of the child  When the widget is hidden, its height will be animated to 0.
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
  /// This is used to track the scroll position and determine whether to hide or show the child
  final ScrollController scrollController;

  /// The duration of the animation when the child widget is hidden or shown.
  final Duration duration;

  /// The initial height of the child  When the widget is hidden, its height will be animated to 0.
  final double? height;

  /// The initial width of the child widget, its width will be animated to 0 .by providing width you want the hide direction to be horizontal.
  final Axis hideDirection;

  /// The initial width of the child widget, its width will be animated to 0 .by providing width you want the hide direction to be horizontal.
  final double? width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isShown = ref.watch(showBottomNavBarProvider);

    if (hideDirection == Axis.horizontal) {
      return AnimatedSize(
        duration: duration,
        curve: Curves.linear,
        child: Container(
          height: height,
          width: isShown ? width : 0,
          clipBehavior: Clip.none,
          child: child,
        ),
      );
    }

    return AnimatedContainer(
      duration: duration,
      height: (isShown) ? height : 0,
      width: width,
      curve: Curves.linear,
      clipBehavior: Clip.none,
      child: Wrap(children: [child]),
    );
  }
}
