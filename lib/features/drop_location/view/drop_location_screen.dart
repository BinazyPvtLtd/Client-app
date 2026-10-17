import 'package:client_app/features/drop_location/view/model/address_summary_card.dart';
import 'package:client_app/features/drop_location/view/model/reciever_details_sheet.dart';
import 'package:client_app/features/drop_location/viewmodel/drop_location_viewmodel.dart';
import 'package:client_app/features/home/widgets/patgolito_map.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class DropLocationScreen extends StatefulWidget {
  const DropLocationScreen({
    super.key,
    required this.addressTitle,
    required this.addressSubtitle,
  });

  final String addressTitle;
  final String addressSubtitle;

  @override
  State<DropLocationScreen> createState() => _DropLocationScreenState();
}

class _DropLocationScreenState extends State<DropLocationScreen> {
  late final DropLocationViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = DropLocationViewModel(
      addressTitle: widget.addressTitle,
      addressSubtitle: widget.addressSubtitle,
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            // =========================================
            // REAL MAP - BACKGROUND
            // =========================================
            Positioned.fill(child: _MapSection(viewModel: _viewModel)),

            // =========================================
            // HEADER
            // =========================================
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: AppColors.background,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                  vertical: AppSpacing.xxs,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).maybePop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Drop Location', style: AppTextStyles.heading1),
                  ],
                ),
              ),
            ),

            // =========================================
            // EXPANDABLE RECEIVER DETAILS SHEET
            // =========================================
            DraggableScrollableSheet(
              initialChildSize: 0.43,
              minChildSize: 0.43,
              maxChildSize: 0.72,
              snap: true,
              snapSizes: const [0.43, 0.72],
              builder: (context, scrollController) {
                return _DropDetailsSheet(
                  viewModel: _viewModel,
                  scrollController: scrollController,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DropDetailsSheet extends StatelessWidget {
  const _DropDetailsSheet({
    required this.viewModel,
    required this.scrollController,
  });

  final DropLocationViewModel viewModel;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusExtraLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: AppSpacing.shadowBlur,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.sm),

          // ONLY ONE DRAG HANDLE
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
              ),
            ),
          ),

          // ADDRESS CARD
          AddressSummaryCard(viewModel: viewModel),

          // RECEIVER FORM
          Expanded(
            child: ReceiverDetailsSheet(
              viewModel: viewModel,
              scrollController: scrollController,
            ),
          ),
        ],
      ),
    );
  }
}

class _MapSection extends StatelessWidget {
  const _MapSection({required this.viewModel});

  final DropLocationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          // FULL WIDTH REAL GOOGLE MAP
          const Positioned.fill(child: PatgolitoMap()),

          // CENTER DROP LOCATION PIN
          Center(
            child: IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 36),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.textPrimary.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMedium,
                        ),
                      ),
                      child: Text(
                        'Your goods will be dropped here',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: AppColors.white,
                        size: AppSpacing.iconMedium,
                      ),
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // LOCATE BUTTON
          Positioned(
            right: AppSpacing.lg,
            bottom: AppSpacing.xxl,
            child: _LocateMeButton(viewModel: viewModel),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SEARCH BAR
// =====================================================================

// class _SearchBar extends StatelessWidget {
//   const _SearchBar({required this.viewModel});

//   final DropLocationViewModel viewModel;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 3,
//       borderRadius: BorderRadius.circular(AppSpacing.radiusInput),
//       color: AppColors.surface,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(AppSpacing.radiusInput),
//         onTap: () {
//           viewModel.onChangeAddressPressed(context);
//         },
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: AppSpacing.lg,
//             vertical: AppSpacing.md,
//           ),
//           child: Row(
//             children: [
//               const Icon(
//                 Icons.search_rounded,
//                 size: AppSpacing.iconSmall,
//                 color: AppColors.textTertiary,
//               ),
//               const SizedBox(width: AppSpacing.sm),
//               Text('Search drop location', style: AppTextStyles.inputHint),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// =====================================================================
// LOCATE ME BUTTON
// =====================================================================

class _LocateMeButton extends StatelessWidget {
  const _LocateMeButton({required this.viewModel});

  final DropLocationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      elevation: 3,
      color: AppColors.surface,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: viewModel.onLocateMePressed,
        child: const Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Icon(
            Icons.my_location_rounded,
            color: AppColors.primary,
            size: AppSpacing.iconMedium,
          ),
        ),
      ),
    );
  }
}
