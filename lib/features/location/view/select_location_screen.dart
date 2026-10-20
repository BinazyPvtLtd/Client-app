import 'package:client_app/features/location/view/models/dashed_vertical_line.dart';
import 'package:client_app/features/location/view/models/saved_address_tile.dart';
import 'package:client_app/features/location/viewmodel/select_location_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  late final SelectLocationViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SelectLocationViewModel();
    _viewModel.loadCurrentPickupLocation();
    _viewModel.loadSavedAddresses();
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
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    AppSpacing.lg,
                    AppSpacing.screenHorizontal,
                    0,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text('Set trip route', style: AppTextStyles.heading1),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenHorizontal,
                  ),
                  child: _PickupDropCard(viewModel: _viewModel),
                ),
                const SizedBox(height: AppSpacing.lg),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenHorizontal,
                  ),
                  child: _QuickActionsRow(viewModel: _viewModel),
                ),
                const SizedBox(height: AppSpacing.sm),
                const Divider(height: 1),
                Expanded(
                  child: _viewModel.filteredAddresses.isEmpty
                      ? Center(
                          child: Text(
                            'No matching addresses',
                            style: AppTextStyles.bodyMedium,
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.only(top: AppSpacing.sm),
                          itemCount: _viewModel.filteredAddresses.length,
                          separatorBuilder: (context, index) => const Divider(
                            height: 1,
                            indent: AppSpacing.screenHorizontal,
                            endIndent: AppSpacing.screenHorizontal,
                          ),
                          itemBuilder: (context, index) {
                            final address = _viewModel.filteredAddresses[index];
                            return SavedAddressTile(
                              address: address,
                              onTap: () =>
                                  _viewModel.selectSavedAddress(address),
                            );
                          },
                        ),
                ),
                if (_viewModel.dropSearchError != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenHorizontal,
                      vertical: AppSpacing.sm,
                    ),
                    child: Text(
                      _viewModel.dropSearchError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                _ContinueButton(viewModel: _viewModel),
              ],
            );
          },
        ),
      ),
    );
  }
}

// =====================================================================
// PICKUP / DROP CARD
// =====================================================================

class _PickupDropCard extends StatelessWidget {
  const _PickupDropCard({required this.viewModel});

  final SelectLocationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(AppColors.opacityShadow),
            blurRadius: AppSpacing.shadowBlur,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ===================================================
          // PICKUP ROW
          // ===================================================
          InkWell(
            onTap: () => viewModel.onPickupTapped(context),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // color: AppColors.success,
                    color: Color.fromARGB(255, 222, 13, 13),
                  ),
                  child: const Icon(
                    Icons.arrow_upward_rounded,
                    size: AppSpacing.iconSmall,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${viewModel.pickupName} · ${viewModel.pickupPhone}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.heading3,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            if (viewModel.isLoadingPickup) ...[
                              const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.xs),
                            ],
                            Expanded(
                              child: Text(
                                viewModel.pickupAddress,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
          ),

          // ===================================================
          // CONNECTOR
          // ===================================================
          Padding(
            padding: const EdgeInsets.only(left: 13, top: AppSpacing.xs),
            child: Row(children: const [DashedVerticalLine()]),
          ),

          // ===================================================
          // DROP ROW
          // ===================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Drop location indicator
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 17, 189, 25),
                ),
                child: const Icon(
                  Icons.arrow_downward_rounded,
                  size: AppSpacing.iconSmall,
                  color: AppColors.white,
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              // Wider drop location field
              Expanded(
                child: Container(
                  height: AppSpacing.inputHeight,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusInput),
                    border: Border.all(color: AppColors.primary, width: 1.5),
                  ),
                  child: Center(
                    child: TextField(
                      controller: viewModel.dropController,
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      scrollPhysics: const ClampingScrollPhysics(),
                      style: AppTextStyles.bodyLarge,
                      decoration: InputDecoration(
                        hintText: 'Where is your drop?',
                        hintStyle: AppTextStyles.inputHint,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.md,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                      ),
                    ),
                  ),
                ),
              ),

              // Small spacing, moves + icon to the right
              const SizedBox(width: AppSpacing.sm),

              // Smaller add-stop button
              InkWell(
                borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
                onTap: () {
                  // TODO: allow adding an extra drop stop.
                },
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    size: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// QUICK ACTIONS
// =====================================================================

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow({required this.viewModel});

  final SelectLocationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => viewModel.onSelectOnMapPressed(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: AppSpacing.iconSmall,
                    // color: AppColors.primary,
                    color: Color.fromARGB(255, 17, 189, 25),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Select on map',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(width: 1, height: AppSpacing.xl, color: AppColors.border),
        Expanded(
          child: InkWell(
            onTap: () => viewModel.onSavedAddressesPressed(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border_rounded,
                    size: AppSpacing.iconSmall,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Saved Addresses',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// CONTINUE BUTTON
// =====================================================================

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.viewModel});

  final SelectLocationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final enabled = viewModel.canContinue;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: AppSpacing.buttonHeight,
        child: ElevatedButton(
          onPressed: enabled
              ? () => viewModel.onContinuePressed(context)
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            disabledBackgroundColor: AppColors.border,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
            ),
            elevation: 0,
          ),
          child: viewModel.isResolvingDrop
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue',
                      style: AppTextStyles.buttonText.copyWith(
                        color: enabled
                            ? AppColors.white
                            : AppColors.textTertiary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Icon(
                      Icons.arrow_forward,
                      size: AppSpacing.iconSmall,
                      color: enabled ? AppColors.white : AppColors.textTertiary,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
