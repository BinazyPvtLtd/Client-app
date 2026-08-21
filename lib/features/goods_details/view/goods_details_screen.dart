import 'package:client_app/core/theme/app_colors.dart';
import 'package:client_app/core/theme/app_spacing.dart';
import 'package:client_app/core/theme/app_text_styles.dart';
import 'package:client_app/core/theme/app_typography.dart';
import 'package:client_app/features/goods_details/viewmodel/goods_details_viewmodel.dart';
import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoodsDetailsScreen extends StatelessWidget {
  final VehicleModel selectedVehicle;

  const GoodsDetailsScreen({
    super.key,
    required this.selectedVehicle,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GoodsDetailsViewModel(
        selectedVehicle: selectedVehicle,
      ),
      child: _GoodsDetailsView(
        selectedVehicle: selectedVehicle,
      ),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _GoodsDetailsView extends StatelessWidget {
  final VehicleModel selectedVehicle;

  const _GoodsDetailsView({
    required this.selectedVehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Stack(
          children: [
            // =========================================================
            // SCROLLABLE CONTENT
            // =========================================================

            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.sm,
                AppSpacing.screenHorizontal,
                110,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // =================================================
                  // HEADER
                  // =================================================

                  _buildHeader(context),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  // =================================================
                  // QUESTION
                  // =================================================

                  _buildQuestion(),

                  const SizedBox(
                    height: AppSpacing.lg,
                  ),

                  // =================================================
                  // CATEGORY GRID
                  // =================================================

                  _buildCategoryGrid(context),

                  const SizedBox(
                    height: AppSpacing.xxl,
                  ),

                  // =================================================
                  // DETAILS CARD
                  // =================================================

                  _buildDetailsCard(context),

                  const SizedBox(
                    height: AppSpacing.xxl,
                  ),

                  // =================================================
                  // PHOTOS
                  // =================================================

                  _buildPhotosSection(context),

                  const SizedBox(
                    height: AppSpacing.xxl,
                  ),

                  // =================================================
                  // RESTRICTED ITEMS
                  // =================================================

                  _buildRestrictedItemsWarning(),

                  const SizedBox(
                    height: AppSpacing.xxl,
                  ),
                ],
              ),
            ),

            // =========================================================
            // FIXED BOTTOM BUTTON
            // =========================================================

            _buildBottomButton(context),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader(
    BuildContext context,
  ) {
    return SizedBox(
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // BACK BUTTON

          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints:
                  const BoxConstraints(),
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: AppSpacing.iconMedium,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // TITLE

          Text(
            'Goods Details',
            style:
                AppTextStyles.screenTitle.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // QUESTION
  // =========================================================

  Widget _buildQuestion() {
    return Text(
      'What are you sending?',
      style: AppTextStyles.heading1.copyWith(
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  // =========================================================
  // CATEGORY GRID
  // =========================================================

  Widget _buildCategoryGrid(
    BuildContext context,
  ) {
    final viewModel =
        context.watch<GoodsDetailsViewModel>();

    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),

      itemCount:
          viewModel.categories.length,

      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,

        crossAxisSpacing:
            AppSpacing.sm,

        mainAxisSpacing:
            AppSpacing.sm,

        // Compact category cards
        mainAxisExtent: 92,
      ),

      itemBuilder: (
        context,
        index,
      ) {
        final isSelected =
            viewModel.selectedCategoryIndex ==
                index;

        return _CategoryCard(
          title:
              viewModel.categories[index],

          icon:
              viewModel.categoryIcons[index],

          isSelected:
              isSelected,

          onTap: () {
            viewModel.selectCategory(
              index,
            );
          },
        );
      },
    );
  }

  // =========================================================
  // DETAILS CARD
  // =========================================================

  Widget _buildDetailsCard(
    BuildContext context,
  ) {
    final viewModel =
        context.read<GoodsDetailsViewModel>();

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusLarge,
        ),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Column(
        children: [
          // WEIGHT

          _DetailsInput(
            label:
                'Approximate weight',
            hint:
                'e.g. 50 kg',
            controller:
                viewModel.weightController,
            keyboardType:
                TextInputType.number,
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          // PACKAGES

          _DetailsInput(
            label:
                'Number of packages',
            hint:
                'e.g. 3',
            controller:
                viewModel.packageController,
            keyboardType:
                TextInputType.number,
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          // VALUE

          _DetailsInput(
            label:
                'Approximate goods value',
            hint:
                '0',
            controller:
                viewModel.valueController,
            keyboardType:
                TextInputType.number,
            prefixText: '₹',
          ),
        ],
      ),
    );
  }

  // =========================================================
  // PHOTOS SECTION
  // =========================================================

  Widget _buildPhotosSection(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        // TITLE

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Add photos',
                style:
                    AppTextStyles.heading3.copyWith(
                  fontWeight:
                      AppTypography.semiBold,
                  color:
                      AppColors.textPrimary,
                ),
              ),
              TextSpan(
                text:
                    '  (Optional)',
                style:
                    AppTextStyles.bodyMedium.copyWith(
                  color:
                      AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        // PHOTO CARD

        GestureDetector(
          onTap: () {
            _showPhotoMessage(
              context,
            );
          },

          child: Container(
            width: 96,
            height: 96,

            decoration: BoxDecoration(
              color:
                  AppColors.surface,

              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusMedium,
              ),

              border:
                  Border.all(
                color:
                    AppColors.primary.withOpacity(
                  AppColors
                      .opacityLightStrong,
                ),
              ),
            ),

            child:
                const Center(
              child: Icon(
                Icons
                    .add_a_photo_outlined,
                size:
                    AppSpacing.iconLarge,
                color:
                    AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // PHOTO MESSAGE
  // =========================================================

  void _showPhotoMessage(
    BuildContext context,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Photo selection will be added here.',
          ),
        ),
      );
  }

  // =========================================================
  // RESTRICTED ITEMS
  // =========================================================

  Widget _buildRestrictedItemsWarning() {
    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.symmetric(
        horizontal:
            AppSpacing.lg,
        vertical:
            AppSpacing.md,
      ),

      decoration: BoxDecoration(
        color:
            AppColors.error.withOpacity(
          AppColors.opacityExtraLight,
        ),

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusMedium,
        ),

        border:
            Border.all(
          color:
              AppColors.error.withOpacity(
            AppColors.opacityLight,
          ),
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center,

        children: [
          Icon(
            Icons.warning_amber_rounded,

            size:
                AppSpacing.iconSmall,

            color:
                AppColors.error.withOpacity(
              0.65,
            ),
          ),

          const SizedBox(
            width: AppSpacing.md,
          ),

          Expanded(
            child: Text(
              'Do not send restricted items',

              style:
                  AppTextStyles.bodyMedium.copyWith(
                fontWeight:
                    AppTypography.semiBold,

                color:
                    AppColors.error.withOpacity(
                  0.70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BOTTOM BUTTON
  // =========================================================

  Widget _buildBottomButton(
    BuildContext context,
  ) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,

      child: Container(
        padding:
            const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.md,
          AppSpacing.screenHorizontal,
          AppSpacing.lg,
        ),

        decoration:
            BoxDecoration(
          color:
              AppColors.background,

          border: const Border(
            top:
                BorderSide(
              color:
                  AppColors.border,
            ),
          ),

          boxShadow: [
            BoxShadow(
              color:
                  AppColors.black.withOpacity(
                AppColors.opacityShadow,
              ),

              blurRadius:
                  AppSpacing.shadowBlur,

              offset:
                  const Offset(
                0,
                -4,
              ),
            ),
          ],
        ),

        child: SafeArea(
          top: false,

          child: SizedBox(
            width:
                double.infinity,

            height:
                AppSpacing.buttonHeight,

            child:
                ElevatedButton(
              onPressed: () {
                context
                    .read<
                        GoodsDetailsViewModel>()
                    .onContinuePressed(
                  context,
                  selectedVehicle,
                );
              },

              child: Text(
                'Continue',
                style:
                    AppTextStyles.buttonText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// CATEGORY CARD
// =====================================================================

class _CategoryCard
    extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          AppColors.transparent,

      borderRadius:
          BorderRadius.circular(
        AppSpacing.radiusMedium,
      ),

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusMedium,
        ),

        child:
            AnimatedContainer(
          duration:
              const Duration(
            milliseconds: 180,
          ),

          padding:
              const EdgeInsets.symmetric(
            horizontal:
                AppSpacing.xs,
            vertical:
                AppSpacing.sm,
          ),

          decoration:
              BoxDecoration(
            color: isSelected
                ? AppColors.primary
                    .withOpacity(
                    AppColors
                        .opacityExtraLight,
                  )
                : AppColors.surface,

            borderRadius:
                BorderRadius.circular(
              AppSpacing
                  .radiusMedium,
            ),

            border:
                Border.all(
              color:
                  isSelected
                      ? AppColors
                          .primary
                      : AppColors
                          .border,

              width:
                  isSelected
                      ? 1.5
                      : AppSpacing
                          .borderThin,
            ),
          ),

          child:
              Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [
              Icon(
                icon,

                size:
                    AppSpacing.iconMedium,

                color:
                    isSelected
                        ? AppColors.primary
                        : AppColors
                            .textSecondary,
              ),

              const SizedBox(
                height:
                    AppSpacing.sm,
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal:
                      AppSpacing.xs,
                ),

                child: Text(
                  title,

                  textAlign:
                      TextAlign.center,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style:
                      AppTextStyles.labelLarge
                          .copyWith(
                    fontWeight:
                        AppTypography
                            .semiBold,

                    color:
                        isSelected
                            ? AppColors
                                .primary
                            : AppColors
                                .textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// DETAILS INPUT
// =====================================================================

class _DetailsInput
    extends StatelessWidget {
  const _DetailsInput({
    required this.label,
    required this.hint,
    required this.controller,
    required this.keyboardType,
    this.prefixText,
  });

  final String label;
  final String hint;

  final TextEditingController
      controller;

  final TextInputType
      keyboardType;

  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,

      padding:
          const EdgeInsets.symmetric(
        horizontal:
            AppSpacing.md,
        vertical:
            AppSpacing.sm,
      ),

      decoration:
          BoxDecoration(
        color:
            AppColors.background,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusMedium,
        ),

        border:
            Border.all(
          color:
              AppColors.border,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          // ===========================================
          // LABEL
          // ===========================================

          Text(
            label,

            style:
                AppTextStyles.labelMedium.copyWith(
              color:
                  AppColors.textSecondary,

              fontWeight:
                  AppTypography.medium,
            ),
          ),

          const SizedBox(
            height:
                AppSpacing.xs,
          ),

          // ===========================================
          // INPUT
          // ===========================================

          Expanded(
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center,

              children: [
                if (prefixText !=
                    null) ...[
                  Text(
                    prefixText!,

                    style:
                        AppTextStyles.bodyLarge.copyWith(
                      color:
                          AppColors.textPrimary,

                      fontWeight:
                          AppTypography.medium,
                    ),
                  ),

                  const SizedBox(
                    width:
                        AppSpacing.xs,
                  ),
                ],

                Expanded(
                  child:
                      TextField(
                    controller:
                        controller,

                    keyboardType:
                        keyboardType,

                    style:
                        AppTextStyles.bodyLarge.copyWith(
                      color:
                          AppColors.textPrimary,

                      fontWeight:
                          AppTypography.medium,
                    ),

                    decoration:
                        InputDecoration(
                      hintText:
                          hint,

                      hintStyle:
                          AppTextStyles.bodyLarge.copyWith(
                        color:
                            AppColors
                                .textTertiary,
                      ),

                      border:
                          InputBorder.none,

                      enabledBorder:
                          InputBorder.none,

                      focusedBorder:
                          InputBorder.none,

                      disabledBorder:
                          InputBorder.none,

                      contentPadding:
                          EdgeInsets.zero,

                      isCollapsed:
                          true,

                      filled:
                          false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}