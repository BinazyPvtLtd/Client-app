import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../viewmodel/drop_location_viewmodel.dart';

class ReceiverDetailsSheet extends StatelessWidget {
  const ReceiverDetailsSheet({super.key, required this.viewModel});

  final DropLocationViewModel viewModel;

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
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.lg,
                AppSpacing.screenHorizontal,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FieldLabel('House / Apartment / Shop (optional)'),
                  const SizedBox(height: AppSpacing.sm),
                  _RoundedField(
                    controller: viewModel.houseController,
                    hintText: 'Flat no., Floor, Building name',
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _FieldLabel("Receiver's Name"),
                  const SizedBox(height: AppSpacing.sm),
                  _RoundedField(
                    controller: viewModel.nameController,
                    hintText: 'Enter name',
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _FieldLabel("Receiver's Mobile number"),
                  const SizedBox(height: AppSpacing.sm),
                  _PhoneField(viewModel: viewModel),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: viewModel.useMyMobileNumber,
                          onChanged: viewModel.toggleUseMyMobileNumber,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      GestureDetector(
                        onTap: () => viewModel.toggleUseMyMobileNumber(
                          !viewModel.useMyMobileNumber,
                        ),
                        child: Text(
                          'Use my mobile number',
                          style: AppTextStyles.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    width: double.infinity,
                    height: AppSpacing.buttonHeight,
                    child: ElevatedButton(
                      onPressed: viewModel.canConfirm
                          ? () => viewModel.onConfirmPressed(context)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        disabledBackgroundColor: AppColors.border,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusButton),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Confirm and Proceed',
                        style: AppTextStyles.buttonText.copyWith(
                          color: viewModel.canConfirm
                              ? AppColors.white
                              : AppColors.textTertiary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyles.inputLabel);
  }
}

class _RoundedField extends StatelessWidget {
  const _RoundedField({
    required this.controller,
    required this.hintText,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: AppTextStyles.bodyLarge,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({required this.viewModel});

  final DropLocationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.inputHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusInput),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Text('+91', style: AppTextStyles.countryCode),
          const SizedBox(width: AppSpacing.sm),
          Container(width: 1, height: 20, color: AppColors.border),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: TextField(
              controller: viewModel.phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              style: AppTextStyles.bodyLarge,
              decoration: InputDecoration(
                filled: false,
                border: InputBorder.none,
                isCollapsed: true,
                counterText: '',
                hintText: 'Enter 10-digit mobile number',
                hintStyle: AppTextStyles.inputHint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}