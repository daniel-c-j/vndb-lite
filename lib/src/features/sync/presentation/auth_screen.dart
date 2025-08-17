import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vndb_lite/src/common_widgets/custom_dialog.dart';
import 'package:vndb_lite/src/common_widgets/generic_background.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:vndb_lite/src/features/sync/presentation/components/auth_confirm_button.dart';
import 'package:vndb_lite/src/features/sync/presentation/components/auth_token_field.dart';
import 'package:vndb_lite/src/features/sync/presentation/dialog/dont_have_auth_dialog.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

import '../../../common_widgets/custom_button.dart';
import '../../theme/theme_data_provider.dart';

class AuthenticationScreen extends ConsumerStatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  ConsumerState<AuthenticationScreen> createState() {
    return _AuthenticationScreenState();
  }
}

class _AuthenticationScreenState extends ConsumerState<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();

    _offsetAnimation = _animationController
        .drive(CurveTween(curve: Curves.easeInOut))
        .drive(Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _showGuideDialog() async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return CustomDialog(useContentPadding: true, content: const DontHaveAuthTokenDialog());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeStateProvider);

    return SafeArea(
      child: Stack(
        children: [
          //
          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //
          GenericBackground(imagePath: theme.backgroundImgPath),
          //
          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //
          Scaffold(
            backgroundColor: kColor(context).primary.withOpacity(0.2),
            body: Stack(
              children: [
                SlideTransition(
                  position: _offsetAnimation,
                  child: FadeTransition(
                    opacity: _animationController.drive(CurveTween(curve: Curves.linear)),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        top: responsiveUI.own(0.1),
                        bottom: responsiveUI.own(0.1),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).orientation == Orientation.portrait)
                                      ? (MediaQuery.of(context).viewInsets.bottom >
                                              0) // When keyboard opens
                                          ? MediaQuery.sizeOf(context).height * 0.12
                                          : MediaQuery.sizeOf(context).height * 0.3
                                      : MediaQuery.sizeOf(context).height * 0.1,
                            ),
                            //
                            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            // Title
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: responsiveUI.own(0.008),
                                horizontal: responsiveUI.own(0.015),
                              ),
                              child: ShadowText(
                                'User Authentication',
                                color: kColor(context).secondary,
                                fontSize: responsiveUI.own(0.05),
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Color.alphaBlend(
                                      Colors.black.withOpacity(0.5),
                                      kColor(context).primary,
                                    ),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                            //
                            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            // Sub-text
                            SizedBox(
                              width: responsiveUI.own(0.75),
                              child: ShadowText(
                                "In order to synchronize your local data with your VNDB account, VNDB requires "
                                "you an authentication token as a representation of your VNDB account. Please "
                                "enter your authentication token to proceed.",
                                align: TextAlign.center,
                                fontSize: responsiveUI.own(0.03),
                                color: kColor(context).tertiary,
                                shadows: [Shadow(color: kColor(context).secondary, blurRadius: 10)],
                              ),
                            ),

                            //
                            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            // Authenticate token field
                            SizedBox(height: responsiveUI.own(0.1)),
                            const AuthenticationField(),
                            //
                            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            // Confirm button
                            SizedBox(height: responsiveUI.own(0.03)),
                            const AuthConfirmButton(),
                            //
                            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            // Don't have an account widget
                            SizedBox(height: responsiveUI.own(0.03)),
                            CustomButton(
                              msg: 'Tutorial',
                              borderRadius: BorderRadius.circular(20),
                              padding: EdgeInsets.symmetric(
                                horizontal: responsiveUI.own(0.035),
                                vertical: responsiveUI.own(0.02),
                              ),
                              buttonColor: Colors.transparent,
                              onTap: () async {
                                await _showGuideDialog();
                              },
                              child: ShadowText(
                                "I don't have any authentication token...",
                                fontSize: responsiveUI.own(0.032),
                                color: kColor(context).secondary,
                                shadows: const [
                                  Shadow(color: Color.fromARGB(150, 0, 0, 0), blurRadius: 1),
                                ],
                                forceShadow: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //
                // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                // Back button
                CustomButton(
                  onTap: context.pop,
                  margin: EdgeInsets.symmetric(
                    horizontal: responsiveUI.own(0.05),
                    vertical: responsiveUI.own(0.11),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: responsiveUI.own(0.02),
                    horizontal: responsiveUI.own(0.035),
                  ),
                  gradientColor: [
                    kColor(context).primary.withOpacity(0.85),
                    kColor(context).secondary.withOpacity(0.65),
                  ],
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        size: responsiveUI.own(0.04),
                        color: kColor(context).tertiary,
                      ),
                      const ShadowText('Back'),
                    ],
                  ),
                ),
                //
                // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                //
              ],
            ),
          ),
        ],
      ),
    );
  }
}
