import 'package:client_app/core/theme/app_colors.dart';
import 'package:client_app/core/theme/app_spacing.dart';
import 'package:client_app/core/theme/app_text_styles.dart';
import 'package:client_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';


import '../viewmodel/my_profile_viewmodel.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({
    super.key,
  });

  @override
  State<MyProfileScreen> createState() =>
      _MyProfileScreenState();
}

class _MyProfileScreenState
    extends State<MyProfileScreen> {
  late final MyProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = MyProfileViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

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
          'My Profile',
          style:
              AppTextStyles.screenTitle,
        ),

        centerTitle: false,
      ),

      body: SafeArea(
        top: false,
        child: ListenableBuilder(
          listenable: _viewModel,

          builder: (
            context,
            _,
          ) {
            return Column(
              children: [
                // ==========================================
                // CONTENT
                // ==========================================

                Expanded(
                  child: SingleChildScrollView(
                    physics:
                        const BouncingScrollPhysics(),

                    padding:
                        const EdgeInsets.fromLTRB(
                      AppSpacing
                          .screenHorizontal,
                      AppSpacing.xxl,
                      AppSpacing
                          .screenHorizontal,
                      AppSpacing.xxxl,
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .stretch,

                      children: [
                        // =================================
                        // PROFILE PHOTO
                        // =================================

                        _buildProfilePhoto(),

                        const SizedBox(
                          height:
                              AppSpacing.xxxl,
                        ),

                        // =================================
                        // FORM CARD
                        // =================================

                        _buildProfileForm(),
                      ],
                    ),
                  ),
                ),

                // ==========================================
                // FIXED SAVE BUTTON
                // ==========================================

                _buildBottomAction(),
              ],
            );
          },
        ),
      ),
    );
  }

  // =========================================================
  // PROFILE PHOTO
  // =========================================================

  Widget _buildProfilePhoto() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _viewModel.changePhoto(
              context,
            );
          },

          child: SizedBox(
            width: 132,
            height: 132,

            child: Stack(
              clipBehavior: Clip.none,

              children: [
                // PROFILE IMAGE

                Container(
                  width: 120,
                  height: 120,

                  decoration: BoxDecoration(
                    shape:
                        BoxShape.circle,

                    color:
                        AppColors.surface,

                    border: Border.all(
                      color:
                          AppColors.border,

                      width:
                          AppSpacing
                              .borderMedium,
                    ),
                  ),

                  child: ClipOval(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
                      fit: BoxFit.cover,

                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return const Icon(
                          Icons.person_rounded,
                          size: 56,
                          color: AppColors
                              .textSecondary,
                        );
                      },
                    ),
                  ),
                ),

                // CAMERA BUTTON

                Positioned(
                  right: 4,
                  bottom: 8,

                  child: Container(
                    width: 44,
                    height: 44,

                    decoration:
                        BoxDecoration(
                      shape:
                          BoxShape.circle,

                      color:
                          AppColors.primary,

                      border:
                          Border.all(
                        color:
                            AppColors.white,
                        width: 3,
                      ),
                    ),

                    alignment:
                        Alignment.center,

                    child: const Icon(
                      Icons
                          .photo_camera_outlined,

                      color:
                          AppColors.white,

                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        Text(
          'Tap to change photo',

          style:
              AppTextStyles.bodyMedium
                  .copyWith(
            color:
                AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // =========================================================
  // PROFILE FORM
  // =========================================================

  Widget _buildProfileForm() {
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

        boxShadow: [
          BoxShadow(
            color:
                AppColors.black.withOpacity(
              AppColors.opacityShadow,
            ),
            blurRadius: 14,
            offset:
                const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child: Column(
        children: [
          // =============================================
          // NAME
          // =============================================

          _ProfileField(
            label: 'Full Name',
            controller:
                _viewModel.nameController,

            keyboardType:
                TextInputType.name,

            textInputAction:
                TextInputAction.next,
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          // =============================================
          // MOBILE
          // =============================================

          _VerifiedMobileField(
            mobileNumber:
                _viewModel.mobileNumber,
          ),

          const SizedBox(
            height: AppSpacing.xs,
          ),

          Align(
            alignment:
                Alignment.centerLeft,

            child: Padding(
              padding:
                  const EdgeInsets.only(
                left:
                    AppSpacing.sm,
              ),

              child: Text(
                'Verified mobile number cannot be changed.',

                style:
                    AppTextStyles.bodySmall
                        .copyWith(
                  color:
                      AppColors.textSecondary,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          // =============================================
          // EMAIL
          // =============================================

          _ProfileField(
            label: 'Email Address',
            controller:
                _viewModel.emailController,

            keyboardType:
                TextInputType.emailAddress,

            textInputAction:
                TextInputAction.done,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BOTTOM ACTION
  // =========================================================

  Widget _buildBottomAction() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
      ),

      decoration: BoxDecoration(
        color:
            AppColors.background,

        border: const Border(
          top: BorderSide(
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
          width: double.infinity,
          height:
              AppSpacing.buttonHeight,

          child: ElevatedButton(
            onPressed:
                _viewModel.isSaving
                    ? null
                    : () {
                        _viewModel
                            .saveChanges(
                          context,
                        );
                      },

            child:
                _viewModel.isSaving
                    ? const SizedBox(
                        width: 22,
                        height: 22,

                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                          color:
                              AppColors.white,
                        ),
                      )
                    : Text(
                        'Save Changes',
                        style:
                            AppTextStyles.buttonText,
                      ),
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// EDITABLE PROFILE FIELD
// =====================================================================

class _ProfileField
    extends StatelessWidget {
  final String label;

  final TextEditingController
      controller;

  final TextInputType
      keyboardType;

  final TextInputAction
      textInputAction;

  const _ProfileField({
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      keyboardType:
          keyboardType,

      textInputAction:
          textInputAction,

      style:
          AppTextStyles.bodyLarge.copyWith(
        color:
            AppColors.textPrimary,

        fontWeight:
            AppTypography.medium,
      ),

      decoration: InputDecoration(
        labelText: label,

        labelStyle:
            AppTextStyles.inputLabel,

        floatingLabelStyle:
            AppTextStyles.inputLabel
                .copyWith(
          color:
              AppColors.primary,
        ),

        filled: true,

        fillColor:
            AppColors.background,

        contentPadding:
            const EdgeInsets.symmetric(
          horizontal:
              AppSpacing.lg,
          vertical:
              AppSpacing.lg,
        ),

        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            AppSpacing
                .radiusMedium,
          ),

          borderSide:
              const BorderSide(
            color:
                AppColors.border,
          ),
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            AppSpacing
                .radiusMedium,
          ),

          borderSide:
              const BorderSide(
            color:
                AppColors.border,
          ),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            AppSpacing
                .radiusMedium,
          ),

          borderSide:
              const BorderSide(
            color:
                AppColors.primary,

            width: 1.5,
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// VERIFIED MOBILE FIELD
// =====================================================================

class _VerifiedMobileField
    extends StatelessWidget {
  final String mobileNumber;

  const _VerifiedMobileField({
    required this.mobileNumber,
  });

  @override
  Widget build(BuildContext context) {
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
            AppColors.surface,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusMedium,
        ),

        border: Border.all(
          color:
              AppColors.border,
        ),
      ),

      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  'Mobile Number',

                  style:
                      AppTextStyles.inputLabel
                          .copyWith(
                    color:
                        AppColors.textSecondary,
                  ),
                ),

                const SizedBox(
                  height:
                      AppSpacing.xs,
                ),

                Text(
                  mobileNumber,

                  style:
                      AppTextStyles.bodyLarge
                          .copyWith(
                    color:
                        AppColors.textSecondary,

                    fontWeight:
                        AppTypography.medium,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: AppSpacing.md,
          ),

          const Icon(
            Icons
                .verified_rounded,

            color:
                AppColors.primary,

            size:
                AppSpacing.iconMedium,
          ),
        ],
      ),
    );
  }
}