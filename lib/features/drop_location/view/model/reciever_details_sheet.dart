import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../viewmodel/drop_location_viewmodel.dart';

class ReceiverDetailsSheet extends StatelessWidget {
  const ReceiverDetailsSheet({
    super.key,
    required this.viewModel,
    required this.scrollController,
  });

  final DropLocationViewModel viewModel;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return SingleChildScrollView(
          controller: scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.md,
            AppSpacing.screenHorizontal,
            AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FieldLabel('House / Apartment / Shop (optional)'),
              const SizedBox(height: AppSpacing.sm),

              _RoundedField(
                controller: viewModel.houseController,
                hintText: 'Flat no., Floor, Building name',
              ),

              const SizedBox(height: AppSpacing.lg),

              const _FieldLabel("Receiver's Name"),
              const SizedBox(height: AppSpacing.sm),

              _RoundedField(
                controller: viewModel.nameController,
                hintText: 'Enter name',
              ),

              const SizedBox(height: AppSpacing.lg),

              const _FieldLabel("Receiver's Mobile number"),
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
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusButton,
                      ),
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
        );
      },
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
  const _RoundedField({required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
            child: Center(
              child: TextField(
                controller: viewModel.phoneController,
                keyboardType: TextInputType.phone,
                textAlignVertical: TextAlignVertical.center,
                maxLength: 10,
                style: AppTextStyles.bodyLarge,
                decoration: InputDecoration(
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  counterText: '',
                  hintText: 'Enter 10-digit mobile number',
                  hintStyle: AppTextStyles.inputHint,
                ),
              ),
            ),
          ),

          // Expanded(
          //   child: TextField(
          //     controller: viewModel.phoneController,
          //     keyboardType: TextInputType.phone,
          //     maxLength: 10,
          //     style: AppTextStyles.bodyLarge,
          //     decoration: InputDecoration(
          //       filled: false,
          //       border: InputBorder.none,
          //       isCollapsed: true,
          //       counterText: '',
          //       hintText: 'Enter 10-digit mobile number',
          //       hintStyle: AppTextStyles.inputHint,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
