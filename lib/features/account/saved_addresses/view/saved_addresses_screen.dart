import 'package:client_app/core/theme/app_colors.dart';
import 'package:client_app/core/theme/app_spacing.dart';
import 'package:client_app/core/theme/app_text_styles.dart';
import 'package:client_app/features/account/saved_addresses/model/saved_address_model.dart';
import 'package:flutter/material.dart';


import '../viewmodel/saved_addresses_viewmodel.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({
    super.key,
  });

  @override
  State<SavedAddressesScreen> createState() =>
      _SavedAddressesScreenState();
}

class _SavedAddressesScreenState
    extends State<SavedAddressesScreen> {
  late final SavedAddressesViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel =
        SavedAddressesViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();

    super.dispose();
  }

  // =========================================================
  // SCREEN
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor:
            AppColors.background,

        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back_rounded,
            color:
                AppColors.textPrimary,
            size:
                AppSpacing.iconMedium,
          ),
        ),

        title: Text(
          'Saved Addresses',
          style:
              AppTextStyles.screenTitle,
        ),

        centerTitle: false,
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: ListenableBuilder(
        listenable: _viewModel,

        builder: (
          context,
          _,
        ) {
          return Column(
            children: [
              // =============================================
              // ADDRESS LIST
              // =============================================

              Expanded(
                child:
                    _viewModel.addresses.isEmpty
                        ? _buildEmptyState()
                        : ListView.separated(
                            physics:
                                const BouncingScrollPhysics(),

                            padding:
                                const EdgeInsets.fromLTRB(
                              AppSpacing
                                  .screenHorizontal,
                              AppSpacing.xl,
                              AppSpacing
                                  .screenHorizontal,
                              AppSpacing.xxl,
                            ),

                            itemCount:
                                _viewModel
                                    .addresses
                                    .length,

                            separatorBuilder:
                                (
                              context,
                              index,
                            ) {
                              return const SizedBox(
                                height:
                                    AppSpacing.lg,
                              );
                            },

                            itemBuilder:
                                (
                              context,
                              index,
                            ) {
                              final address =
                                  _viewModel
                                      .addresses[index];

                              return _AddressCard(
                                address:
                                    address,

                                onEdit: () {
                                  _viewModel
                                      .editAddress(
                                    context,
                                    address,
                                  );
                                },

                                onDelete:
                                    () {
                                  _viewModel
                                      .deleteAddress(
                                    context,
                                    address,
                                  );
                                },
                              );
                            },
                          ),
              ),

              // =============================================
              // ADD ADDRESS BUTTON
              // =============================================

              _buildBottomAction(),
            ],
          );
        },
      ),

      // IMPORTANT:
      // Don't add HomeBottomNavigation here.
    );
  }

  // =========================================================
  // ADD ADDRESS BUTTON
  // =========================================================

  Widget _buildBottomAction() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
        AppSpacing.screenHorizontal,
        AppSpacing.xl,
      ),

      decoration: BoxDecoration(
        color: AppColors.background,

        border: const Border(
          top: BorderSide(
            color: AppColors.border,
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

            offset: const Offset(
              0,
              -4,
            ),
          ),
        ],
      ),

      child: SafeArea(
        top: false,

        child: SizedBox(
          width: double.infinity,
          height:
              AppSpacing.buttonHeight,

          child: ElevatedButton.icon(
            onPressed: () {
              _viewModel
                  .addNewAddress(
                context,
              );
            },

            icon: const Icon(
              Icons.add_rounded,
              color: AppColors.white,
              size:
                  AppSpacing.iconMedium,
            ),

            label: Text(
              'Add New Address',

              style:
                  AppTextStyles.buttonText,
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // EMPTY STATE
  // =========================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.xxxl,
        ),

        child: Column(
          mainAxisSize:
              MainAxisSize.min,

          children: [
            Container(
              width: 72,
              height: 72,

              alignment:
                  Alignment.center,

              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color:
                    AppColors.surface,
              ),

              child: const Icon(
                Icons
                    .location_off_outlined,

                color:
                    AppColors.textSecondary,

                size:
                    AppSpacing.iconLarge,
              ),
            ),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            Text(
              'No saved addresses',
              style:
                  AppTextStyles.heading2,
            ),

            const SizedBox(
              height: AppSpacing.sm,
            ),

            Text(
              'Save your frequently used addresses for faster bookings.',
              textAlign:
                  TextAlign.center,

              style:
                  AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// ADDRESS CARD
// =====================================================================

class _AddressCard
    extends StatelessWidget {
  final SavedAddressModel address;

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AddressCard({
    required this.address,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusCard,
        ),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // =============================================
          // ICON
          // =============================================

          _AddressIcon(
            icon: address.icon,

            highlight:
                address.id == 'home',
          ),

          const SizedBox(
            width: AppSpacing.lg,
          ),

          // =============================================
          // ADDRESS
          // =============================================

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                // =========================================
                // TITLE + ACTIONS
                // =========================================

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        address.title,

                        style: AppTextStyles
                            .heading3,
                      ),
                    ),

                    IconButton(
                      tooltip:
                          'Edit address',

                      onPressed: onEdit,

                      icon: const Icon(
                        Icons
                            .edit_outlined,

                        color: AppColors
                            .textSecondary,

                        size: AppSpacing
                            .iconSmall,
                      ),
                    ),

                    IconButton(
                      tooltip:
                          'Delete address',

                      onPressed: onDelete,

                      icon: const Icon(
                        Icons
                            .delete_outline_rounded,

                        color: AppColors
                            .textSecondary,

                        size: AppSpacing
                            .iconSmall,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: AppSpacing.sm,
                ),

                // =========================================
                // FULL ADDRESS
                // =========================================

                Text(
                  address.address,

                  style:
                      AppTextStyles.bodyLarge
                          .copyWith(
                    color:
                        AppColors.textSecondary,

                    height: 1.5,
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

// =====================================================================
// ADDRESS ICON
// =====================================================================

class _AddressIcon
    extends StatelessWidget {
  final IconData icon;
  final bool highlight;

  const _AddressIcon({
    required this.icon,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,

      alignment: Alignment.center,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        color: highlight
            ? AppColors.primary.withOpacity(
                AppColors.opacityExtraLight,
              )
            : AppColors.surface,
      ),

      child: Icon(
        icon,

        color: AppColors.textPrimary,

        size: AppSpacing.iconMedium,
      ),
    );
  }
}