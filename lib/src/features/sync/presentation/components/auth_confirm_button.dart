import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/common_widgets/custom_dialog_button.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/sync/presentation/auth_screen_controller.dart';
import 'package:vndb_lite/src/features/sync/presentation/components/auth_confirm_button_state.dart';
import 'package:vndb_lite/src/features/sync/presentation/components/auth_token_field_controller.dart';
import 'package:vndb_lite/src/features/sync/presentation/dialog/sync_dialog.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

class AuthConfirmButton extends ConsumerStatefulWidget {
  const AuthConfirmButton({super.key});

  @override
  ConsumerState<AuthConfirmButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends ConsumerState<AuthConfirmButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..forward();

    _offsetAnimation = _animationController
        .drive(CurveTween(curve: Curves.ease))
        .drive(Tween<Offset>(begin: const Offset(0, -1.5), end: const Offset(0, 0)));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _onTap(String token) async {
    ref.read(authButtonStateProvider.notifier).state = ButtonState.loading;

    try {
      final response = await ref.read(authScreenControllerProvider.notifier).authenticate(token);

      // Notify change when success.
      if (response.data['permissions'].contains('listread') &&
          response.data['permissions'].contains('listwrite')) {
        ref.invalidate(authScreenControllerProvider);
        ref
            .read(authScreenControllerProvider.notifier)
            .userIdentityFromResponse(response.data, token);
        ref.read(authButtonStateProvider.notifier).state = ButtonState.active;

        ref.read(showAuthTokenFieldStateProvider.notifier).show = false;
        ref.invalidate(authScreenControllerProvider);

        await showSyncDialog();
        return;
      }

      ref.invalidate(authTokenFieldServerErrorStateProvider);
      ref.read(authTokenFieldServerErrorStateProvider.notifier).error =
          'Invalid authorization given. Please ensure the authentication token '
          'grant both read and write permissions.';

      ref.read(authButtonStateProvider.notifier).state = ButtonState.inactive;
      return;
      //
    } catch (err) {
      //
      if (err is DioException) {
        if (err.type == DioExceptionType.badResponse) {
          ref.invalidate(authTokenFieldServerErrorStateProvider);
          ref.read(authTokenFieldServerErrorStateProvider.notifier).error =
              'Invalid authentication token';

          ref.read(authButtonStateProvider.notifier).state = ButtonState.inactive;
          return;
        }
      }
    }
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  @override
  Widget build(BuildContext context) {
    final userSuccessfullyAuthed = ref.watch(authScreenControllerProvider) != null;
    final buttonState = ref.watch(authButtonStateProvider);
    final showAuthField = ref.watch(showAuthTokenFieldStateProvider);
    final tokenFieldValue = ref.watch(authTokenFieldStateProvider);

    final button = Opacity(
      opacity: (buttonState == ButtonState.inactive) ? 0.4 : 1,
      child: CustomDialogButton(
        text: (userSuccessfullyAuthed) ? "Change" : "Confirm",
        textColor: kColor(context).primary,
        textShadow: const [Shadow(color: Color.fromARGB(120, 0, 0, 0), blurRadius: 1)],
        color: kColor(context).tertiary,
        padding: EdgeInsets.symmetric(
          horizontal: responsiveUI.own(0.045),
          vertical: responsiveUI.own(0.02),
        ),
        onPressed: () async {
          if (buttonState == ButtonState.active) {
            await _onTap(tokenFieldValue);
          }
        },
        additionalWidget:
            (buttonState == ButtonState.loading)
                ? SizedBox(
                  width: responsiveUI.own(0.05),
                  height: responsiveUI.own(0.05),
                  child: const Center(child: CircularProgressIndicator()),
                )
                : null,
      ),
    );

    if (userSuccessfullyAuthed && !showAuthField) {
      return const SizedBox.shrink();
    }

    // If user is authenticated and show auth field is true.
    if (userSuccessfullyAuthed && showAuthField) {
      return SlideTransition(position: _offsetAnimation, child: button);
    }

    return button;
  }
}
