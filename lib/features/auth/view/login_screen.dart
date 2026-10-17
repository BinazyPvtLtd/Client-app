import 'package:client_app/features/auth/view/widgets/animated_delivery_scene.dart';
import 'package:client_app/features/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/constant/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final width = constraints.maxWidth;
            final compact = height < 700;
            final horizontal = AppSpacing.authHorizontalPadding(width);
            final sectionGap = AppSpacing.authSectionGap(height);

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: height),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontal),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: AppSpacing.authTopGap(height)),
                      SizedBox(
                        height: AppSpacing.authLogoHeight(height),
                        width: double.infinity,
                        child: Image.asset(
                          AppAssets.patgolitoLogo1,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: compact ? AppSpacing.xs : AppSpacing.sm),
                      Text(
                        'Move goods with ease',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.loginTitle,
                      ),
                      SizedBox(height: compact ? AppSpacing.xs : AppSpacing.sm),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 350),
                        child: Text(
                          'Fast, reliable transportation at your fingertips.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.loginSubtitle,
                        ),
                      ),
                      SizedBox(height: sectionGap),
                      SizedBox(
                        height: AppSpacing.authTruckHeight(height),
                        width: double.infinity,
                        child: AnimatedDeliveryScene(
                          height: AppSpacing.authTruckHeight(height),
                        ),
                      ),
                      SizedBox(height: sectionGap),
                      const _PhoneInput(),
                      SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
                      const _ContinueButton(),
                      SizedBox(
                        height: compact ? AppSpacing.lg : AppSpacing.xxl,
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 340),
                        child: Text.rich(
                          TextSpan(
                            style: AppTextStyles.termsText,
                            children: [
                              const TextSpan(
                                text:
                                    "By continuing, you agree to Patgolito's ",
                              ),
                              TextSpan(
                                text: 'Terms & ',
                                style: AppTextStyles.termsAction,
                              ),
                              TextSpan(
                                text: 'Privacy Policy.',
                                style: AppTextStyles.termsAction,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: compact ? AppSpacing.md : AppSpacing.xl),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PhoneInput extends StatelessWidget {
  const _PhoneInput();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginViewModel>();

    return Container(
      height: AppSpacing.inputHeight,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.authPhoneRadius),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.lg,
              right: AppSpacing.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('+91', style: AppTextStyles.countryCode),
                const SizedBox(width: AppSpacing.xs),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: AppSpacing.iconSmall,
                  color: AppColors.textPrimary,
                ),
              ],
            ),
          ),
          Container(width: 1, height: 28, color: AppColors.border),
          Expanded(
            child: TextField(
              controller: viewModel.phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              maxLength: 10,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: viewModel.onPhoneChanged,
              style: AppTextStyles.phoneInput,
              textAlignVertical: TextAlignVertical.center,
              decoration: const InputDecoration(
                counterText: '',
                hintText: '10-digit number',
                filled: false,
                isDense: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
              ),
              onSubmitted: (_) => viewModel.continueLogin(context),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, _) {
        return SizedBox(
          width: double.infinity,
          height: AppSpacing.buttonHeight,
          child: ElevatedButton(
            onPressed: viewModel.isLoading
                ? null
                : () => viewModel.continueLogin(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
              ),
            ),
            child: viewModel.isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.3,
                      color: AppColors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Continue', style: AppTextStyles.buttonText),
                      const SizedBox(width: AppSpacing.sm),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: AppSpacing.authArrowIcon,
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
