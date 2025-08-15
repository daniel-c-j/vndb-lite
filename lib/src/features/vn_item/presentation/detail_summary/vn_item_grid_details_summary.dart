import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/features/sort_filter/data/languages_data.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_non_summary/vn_record_controller.dart';
import 'package:flutter/material.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_summary/vn_item_detail_summary_x_button.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

class VnItemGridDetailsSummary extends ConsumerStatefulWidget {
  const VnItemGridDetailsSummary({
    super.key,
    required this.p1,
    required this.toggleVnDetailSummary,
    this.labelCode = 'title',
  });

  final VnDataPhase01 p1;

  final String labelCode;

  final VoidCallback toggleVnDetailSummary;

  @override
  ConsumerState<VnItemGridDetailsSummary> createState() => _VnItemGridDetailsSummaryState();
}

class _VnItemGridDetailsSummaryState extends ConsumerState<VnItemGridDetailsSummary>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();

    _offsetAnimation = _animationController
        .drive(CurveTween(curve: Curves.easeInOut))
        .drive(Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  String get _vnLength {
    if (widget.p1.length == 1) return 'Very Short';
    if (widget.p1.length == 2) return 'Short';
    if (widget.p1.length == 3) return 'Medium';
    if (widget.p1.length == 4) return 'Long';
    if (widget.p1.length == 5) return 'Very Long';
    return 'Unknown';
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Widget detailSummary({
    required IconData icon,
    required String title,
    required content,
    bool useHighlight = false,
  }) {
    assert(content is! Widget || content is! String, "Content must be either string or widget.");

    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(icon, size: responsiveUI.own(0.038), color: kColor(context).secondary),
        ShadowText(title),
        (content is String)
            ? ShadowText(
              content,
              fontWeight: (useHighlight) ? FontWeight.bold : null,
              color: (useHighlight) ? kColor(context).secondary : null,
            )
            : content,
      ],
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _animationController.drive(CurveTween(curve: Curves.linear)),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(responsiveUI.own(0.025)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: kColor(context).primary.withOpacity(0.6),
                    spreadRadius: 10,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                  // Title
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: kColor(context).secondary.withOpacity(0.6),
                          offset: const Offset(0, -15),
                          spreadRadius: 25,
                          blurRadius: 35,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: ShadowText(widget.p1.title, fontSize: responsiveUI.own(0.0385)),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              final vnRecord = ref.watch(vnRecordStateProvider(widget.p1.id));

                              if (vnRecord == null) {
                                return const SizedBox.shrink();
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //
                                  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                  // Status (if in collection)
                                  detailSummary(
                                    icon: Icons.library_books,
                                    title: ' Status: ',
                                    content: toBeginningOfSentenceCase<String>(vnRecord.status),
                                    useHighlight: true,
                                  ),
                                  //
                                  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                  // Voted
                                  detailSummary(
                                    icon: Icons.electric_bolt_sharp,
                                    title: ' Voted: ',
                                    content: '${vnRecord.vote}',
                                    useHighlight: true,
                                  ),
                                ],
                              );
                            },
                          ),
                          //
                          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                          // Origin
                          detailSummary(
                            icon: Icons.public,
                            title: ' Origin: ',
                            content: Padding(
                              padding: EdgeInsets.only(left: responsiveUI.own(0.005)),
                              child: Image.asset(
                                LangData.getFlagPath(widget.p1.olang ?? ""),
                                height: responsiveUI.own(0.038),
                                width: responsiveUI.own(0.055),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          //
                          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                          // Rating
                          detailSummary(
                            icon: Icons.star,
                            title: ' Rating: ',
                            content: (widget.p1.rating! / 10).toStringAsFixed(2),
                          ),
                          //
                          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                          // Vote
                          detailSummary(
                            icon: Icons.electric_bolt_sharp,
                            title: ' Vote: ',
                            content: '${widget.p1.votecount}',
                          ),
                          //
                          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                          // Length
                          detailSummary(
                            icon: Icons.timelapse,
                            title: ' Length: ',
                            content: _vnLength,
                          ),
                          //
                          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                          // Release date
                          detailSummary(
                            icon: Icons.calendar_month,
                            title: ' Release Date: ',
                            content: '${widget.p1.released}',
                          ),
                          //
                          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                          // Description
                          ShadowText('\nDescription: \n${widget.p1.description ?? '--'}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //
            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            // X button indicator
            VnItemDetailSummaryXButton(
              vnId: widget.p1.id,
              toggleVnDetailSummary: widget.toggleVnDetailSummary,
              animationController: _animationController,
            ),
            //
            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            //
          ],
        ),
      ),
    );
  }
}
