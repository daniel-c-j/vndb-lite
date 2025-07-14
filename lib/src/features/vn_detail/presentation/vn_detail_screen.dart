import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/common_widgets/generic_background.dart';
import 'package:vndb_lite/src/common_widgets/generic_image_error.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/collection_selection/application/collection_selection_remote_service.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/fab/vn_detail_fab.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/fab/vn_detail_fab_state.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';
import 'package:vndb_lite/src/features/vn/data/local_vn_repo.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/features/vn_detail/presentation/components/vn_detail_appbar.dart';
import 'package:vndb_lite/src/features/vn_detail/presentation/vn_detail_entrance.dart';
import 'package:vndb_lite/src/util/check_media_cache.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/custom_cache_manager.dart';

class VnDetailScreen extends ConsumerStatefulWidget {
  const VnDetailScreen({super.key, required this.p1});

  final VnDataPhase01 p1;

  @override
  ConsumerState<VnDetailScreen> createState() {
    return _VnDetailScreenState();
  }
}

class _VnDetailScreenState extends ConsumerState<VnDetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final String _vnId;

  @override
  void initState() {
    super.initState();
    _vnId = widget.p1.id;

    // Animation for background image.
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //
  // TODO remove this all in controller?
  bool get _vnHasCover {
    return widget.p1.image?.thumbnail != null && widget.p1.image?.thumbnail != null;
  }

  bool get _coverNeedCensor {
    if (!_vnHasCover) return false;

    final settings = ref.read(settingsGeneralStateProvider);

    if (settings.showCoverCensor) {
      if (_vnMatchCensorRequirement) return true;
    }

    return false;
  }

  bool get _vnMatchCensorRequirement {
    return (widget.p1.image!.sexual ?? 0) >= 1 || (widget.p1.image!.violence ?? 0) >= 1;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    final localVnRepo = ref.read(localVnRepoProvider);

    // This removes all corresponded vn detail data, to be redownloaded.
    await localVnRepo.removeVnContent(phase: 2, vnId: _vnId);
    await localVnRepo.removeVnContent(phase: 3, vnId: _vnId);
    await localVnRepo.refresh();

    // Set providers back to its default state.
    ref.invalidate(vnDetailFabStateProvider(widget.p1.id));
    ref.invalidate(fetchAndSaveP2DataProvider(widget.p1.id));
    ref.invalidate(getP2Provider(widget.p1.id));
    ref.invalidate(localVnRepoProvider);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Widget _imgCover({required bool isCensor}) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.85),
      child: CachedNetworkImage(
        imageUrl: (_vnHasCover) ? widget.p1.image!.thumbnail! : '',
        fit: BoxFit.cover,
        width: MediaQuery.sizeOf(context).width,
        placeholder:
            (context, str) =>
                SizedBox(width: responsiveUI.own(0.25), height: responsiveUI.own(0.4)),
        errorWidget: (context, url, error) => const GenericErrorImage(),
        cacheKey: "BG-${widget.p1.id}",
        cacheManager: (!App.isInSearchScreen) ? CustomCacheManager() : null,
        // High quality to make the pixels smooth when censor mode is on.
        filterQuality: (isCensor) ? FilterQuality.high : FilterQuality.medium,
        maxHeightDiskCache: (isCensor) ? 35 : 1400,
        maxWidthDiskCache: (isCensor) ? 35 : 1400,
      ),
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: kColor(context).primary.withOpacity(0.3),
        body: Stack(
          children: [
            GenericBackground(
              useGradientOverlay: true,
              imageWidget: FadeTransition(
                opacity: _animationController.drive(CurveTween(curve: Curves.ease)),
                child: ShaderMask(
                  blendMode: BlendMode.dstIn,
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(140, 0, 0, 0),
                        Color.fromARGB(70, 0, 0, 0),
                        Colors.transparent,
                      ],
                    ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  child: _imgCover(isCensor: _coverNeedCensor),
                ),
              ),
            ),
            NestedScrollView(
              headerSliverBuilder: (_, bool inBoxScrolled) {
                return [VnDetailAppBar(vnId: _vnId)];
              },
              //
              // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              // Double scaffold to prevent snackbar ui conflicting with floating action button
              body: Scaffold(
                backgroundColor: Colors.transparent,
                floatingActionButton: VnDetailFab(p1: widget.p1),
                body: RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: kColor(context).tertiary,
                  backgroundColor: kColor(context).primary.withOpacity(0.75),
                  displacement: responsiveUI.own(0.02),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: responsiveUI.own(0.03),
                      bottom: responsiveUI.own(0.24),
                    ),
                    child: VnDetailsEntrance(p1: widget.p1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
