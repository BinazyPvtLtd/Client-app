import 'package:client_app/core/theme/app_colors.dart';
import 'package:client_app/core/theme/app_spacing.dart';
import 'package:client_app/core/theme/app_typography.dart';
import 'package:client_app/features/goods_details/viewmodel/goods_details_viewmodel.dart';
import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoodsDetailsScreen extends StatelessWidget {
   final VehicleModel selectedVehicle;
  const GoodsDetailsScreen({
    super.key,required this.selectedVehicle,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GoodsDetailsViewModel( selectedVehicle: selectedVehicle,),
      child:  _GoodsDetailsView(selectedVehicle: selectedVehicle,),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _GoodsDetailsView extends StatelessWidget {
  final VehicleModel selectedVehicle;
  const _GoodsDetailsView({required this.selectedVehicle,});

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                130,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),

                  const SizedBox(height: 20),

                  _buildQuestion(),

                  const SizedBox(height: 20),

                  _buildCategoryGrid(context),

                  const SizedBox(height: 25),

                  _buildDetailsCard(context),

                  const SizedBox(height: 30),

                  _buildPhotosSection(context),

                  const SizedBox(height: 30),

                  _buildRestrictedItemsWarning(),
                ],
              ),
            ),

            _buildBottomButton(context),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: AppColors.textSecondary,
              ),
            ),
          ),

          Text(
            'Goods Details',
            style: TextStyle(
              fontSize: AppTypography.xxlScaled + 2,
              fontWeight: AppTypography.bold,
              color: AppColors.primaryDark,
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
      style: TextStyle(
        fontSize: AppTypography.xxlScaled,
        fontWeight: AppTypography.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  // =========================================================
  // CATEGORY GRID
  // =========================================================

  Widget _buildCategoryGrid(BuildContext context) {
    final viewModel =
        context.watch<GoodsDetailsViewModel>();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      itemCount: viewModel.categories.length,

      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,

        crossAxisSpacing: 8,
        mainAxisSpacing: 8,

        childAspectRatio: 0.92,
      ),

      itemBuilder: (context, index) {
        final isSelected =
            viewModel.selectedCategoryIndex == index;

        return _CategoryCard(
          title: viewModel.categories[index],
          icon: viewModel.categoryIcons[index],
          isSelected: isSelected,
          onTap: () {
            viewModel.selectCategory(index);
          },
        );
      },
    );
  }

  // =========================================================
  // DETAILS CARD
  // =========================================================

  Widget _buildDetailsCard(BuildContext context) {
    final viewModel =
        context.read<GoodsDetailsViewModel>();

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(32),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(
          AppSpacing.radiusLarge,
        ),

        border: Border.all(
          color: AppColors.border,
          width: 1.2,
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(
              AppColors.opacityShadow,
            ),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        children: [
          _DetailsInput(
            label: 'Approximate weight',
            hint: 'e.g. 50 kg',
            controller: viewModel.weightController,
            keyboardType:
                TextInputType.number,
          ),

          const SizedBox(height: 28),

          _DetailsInput(
            label: 'Number of packages',
            hint: 'e.g. 3',
            controller: viewModel.packageController,
            keyboardType:
                TextInputType.number,
          ),

          const SizedBox(height: 28),

          _DetailsInput(
            label: 'Approximate goods value',
            hint: '0',
            controller: viewModel.valueController,
            keyboardType:
                TextInputType.number,
            prefixText: '₹',
          ),
        ],
      ),
    );
  }

  // =========================================================
  // PHOTOS
  // =========================================================

  Widget _buildPhotosSection(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Add photos',
                style: TextStyle(
                  fontSize:
                      AppTypography.xlScaled,
                  fontWeight:
                      AppTypography.bold,
                  color:
                      AppColors.textPrimary,
                ),
              ),
              TextSpan(
                text: '  (Optional)',
                style: TextStyle(
                  fontSize:
                      AppTypography.lgScaled,
                  fontWeight:
                      AppTypography.semiBold,
                  color:
                      AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        GestureDetector(
          onTap: () {
            _showPhotoMessage(context);
          },
          child: Container(
            width: 120,
            height: 120,

            decoration: BoxDecoration(
              color: AppColors.surface,

              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusMedium,
              ),

              border: Border.all(
                color: AppColors.primary
                    .withOpacity(0.4),
                width: 2,
              ),
            ),

            child: const Center(
              child: Icon(
                Icons.add_a_photo_outlined,
                size: 48,
                color: AppColors.primaryDark,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showPhotoMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
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

      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 14,
      ),

      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.07),
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusMedium,
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 24,
            color: AppColors.error.withOpacity(0.55),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              'Do not send restricted items',
              style: TextStyle(
                fontSize: AppTypography.mdScaled,
                fontWeight: AppTypography.semiBold,
                color: AppColors.error.withOpacity(0.55),
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

  Widget _buildBottomButton(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,

      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          18,
          AppSpacing.lg,
          24,
        ),

        decoration: BoxDecoration(
          color: AppColors.surface,

          borderRadius:
              const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),

          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(
                AppColors.opacityShadow,
              ),
              blurRadius: 18,
              offset: const Offset(0, -4),
            ),
          ],
        ),

        child: SizedBox(
          height: 64,

          child: ElevatedButton(
            onPressed: () {
  context
      .read<GoodsDetailsViewModel>()
      .onContinuePressed(
        context,
        selectedVehicle,
      );
},

            style: ElevatedButton.styleFrom(
              backgroundColor:
                  AppColors.primary,

              foregroundColor:
                  AppColors.white,

              elevation: 0,

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  AppSpacing.radiusButton,
                ),
              ),
            ),

            child: Text(
              'Continue',
              style: TextStyle(
                fontSize:
                    AppTypography.xxlScaled,
                fontWeight:
                    AppTypography.bold,
                color:
                    AppColors.white,
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

class _CategoryCard extends StatelessWidget {
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
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 180),

        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.30)
              : AppColors.surface,

          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusMedium,
          ),

          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.border,

            width: isSelected ? 1.5 : 1.2,
          ),

          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: AppColors.black.withOpacity(
                  0.04,
                ),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
          ],
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Icon(
              icon,
              size: 36,
              color: isSelected
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),

            const SizedBox(height: 18),

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize:
                      AppTypography.lgScaled,
                  fontWeight:
                      AppTypography.semiBold,
                  color: isSelected
                      ? AppColors.primaryDark
                      : AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// DETAILS INPUT
// =====================================================================

class _DetailsInput extends StatelessWidget {
  const _DetailsInput({
    required this.label,
    required this.hint,
    required this.controller,
    required this.keyboardType,
    this.prefixText,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,

      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusMedium,
        ),

        border: Border.all(
          color: AppColors.border,
          width: 1.2,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            label,
            style: TextStyle(
              fontSize:
                  AppTypography.lgScaled,
              fontWeight:
                  AppTypography.semiBold,
              color:
                  AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: Row(
              children: [
                if (prefixText != null) ...[
                  Text(
                    prefixText!,
                    style: TextStyle(
                      fontSize:
                          AppTypography.xxlScaled,
                      fontWeight:
                          AppTypography.regular,
                      color:
                          AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(width: 14),
                ],

                Expanded(
                  child: TextField(
                    controller: controller,

                    keyboardType:
                        keyboardType,

                    style: TextStyle(
                      fontSize:
                          AppTypography.xlScaled,
                      fontWeight:
                          AppTypography.regular,
                      color:
                          AppColors.textPrimary,
                    ),

                    decoration:
                        InputDecoration(
                      hintText: hint,

                      hintStyle:
                          TextStyle(
                        fontSize:
                            AppTypography.xlScaled,
                        color:
                            AppColors.textPrimary,
                      ),

                      border:
                          InputBorder.none,

                      contentPadding:
                          EdgeInsets.zero,

                      isDense: true,
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