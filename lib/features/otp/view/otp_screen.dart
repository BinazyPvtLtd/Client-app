import 'package:client_app/core/constant/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../viewmodel/otp_viewmodel.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtpViewModel(),
      child: _OtpView(
        phoneNumber: phoneNumber,
      ),
    );
  }
}

class _OtpView extends StatefulWidget {
  final String phoneNumber;

  const _OtpView({required this.phoneNumber});

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(6, (_) => TextEditingController());

    _focusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final node in _focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  // =========================================================
  // OTP INPUT
  // =========================================================

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }

    final otp = _controllers.map((controller) => controller.text).join();

    context.read<OtpViewModel>().setOtp(otp);
  }

  // =========================================================
  // VERIFY OTP
  // =========================================================

  void _verifyOtp() {
    final viewModel = context.read<OtpViewModel>();

    if (viewModel.isLoading || viewModel.otp.length != 6) {
      return;
    }

    FocusScope.of(context).unfocus();

    viewModel.verifyOtp(context, phoneNumber: widget.phoneNumber);
  }

  // =========================================================
  // RESEND OTP
  // =========================================================

  void _resendOtp() {
    final viewModel = context.read<OtpViewModel>();

    if (viewModel.isLoading || !viewModel.canResend) {
      return;
    }

    FocusScope.of(context).unfocus();

    for (final controller in _controllers) {
      controller.clear();
    }

    viewModel.setOtp('');

    viewModel.resendOtp(context, phoneNumber: widget.phoneNumber);
  }

  // =========================================================
  // CHANGE NUMBER
  // =========================================================

  void _changeNumber() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  // =========================================================
  // MAIN SCREEN - FIXED LAYOUT
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    final horizontalPadding = screenWidth < 360 ? 16.0 : 24.0;
    final compact = screenHeight < 700;

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: compact ? 28 : 48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: compact ? 95 : 110,
                  width: double.infinity,
                  child: Image.asset(
                    AppAssets.patgolitoLogo1,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  'Verify your number',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.loginTitle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Enter the 6-digit code sent to',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.loginSubtitle.copyWith(fontSize: 14),
                ),

                const SizedBox(height: 4),

                Text(
                  widget.phoneNumber,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.countryCode.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 32),

                _buildOtpFields(),

                const SizedBox(height: 32),

                _buildVerifyButton(),

                const SizedBox(height: 20),

                _buildResend(),

                const SizedBox(height: 12),

                _buildChangeNumber(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // RESPONSIVE OTP BOXES
  // =========================================================

  Widget _buildOtpFields() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 8.0;
        final available = constraints.maxWidth;

        final fieldWidth = ((available - gap * 5) / 6)
            .clamp(0.0, 48.0)
            .toDouble();

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            return Padding(
              padding: EdgeInsets.only(right: index == 5 ? 0 : gap),
              child: _buildOtpField(index, fieldWidth),
            );
          }),
        );
      },
    );
  }
  // =========================================================
  // SINGLE OTP BOX
  // =========================================================

  Widget _buildOtpField(int index, double width) {
    return SizedBox(
      width: width,
      height: 54,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textInputAction: index == 5
            ? TextInputAction.done
            : TextInputAction.next,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        maxLength: 1,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        style: AppTextStyles.otpDigit.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: '',
          isDense: false,
          filled: true,
          fillColor: AppColors.white,
          contentPadding: EdgeInsets.zero,
          constraints: const BoxConstraints(minHeight: 54, maxHeight: 54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
        onChanged: (value) {
          _onOtpChanged(value, index);
        },
        onSubmitted: (_) {
          if (index == 5) _verifyOtp();
        },
      ),
    );
  }
  // =========================================================
  // VERIFY BUTTON
  // =========================================================

  Widget _buildVerifyButton() {
    return Consumer<OtpViewModel>(
      builder: (context, viewModel, child) {
        final canVerify = viewModel.otp.length == 6 && !viewModel.isLoading;

        return SizedBox(
          width: double.infinity,
          height: AppSpacing.buttonHeight,
          child: ElevatedButton(
            onPressed: canVerify ? _verifyOtp : null,

            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              disabledBackgroundColor: AppColors.primary.withValues(
                alpha: 0.65,
              ),
              disabledForegroundColor: AppColors.white,
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
                      strokeWidth: 2,
                      color: AppColors.white,
                    ),
                  )
                : Text('Verify & Continue', style: AppTextStyles.buttonText),
          ),
        );
      },
    );
  }

  // =========================================================
  // RESEND OTP
  // =========================================================

  Widget _buildResend() {
    return Consumer<OtpViewModel>(
      builder: (context, viewModel, child) {
        final canResend = viewModel.canResend && !viewModel.isLoading;

        return Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          runSpacing: 4,
          children: [
            Text("Didn't receive the code?", style: AppTextStyles.signupText),

            GestureDetector(
              onTap: canResend ? _resendOtp : null,
              child: Text(
                viewModel.canResend
                    ? 'Resend OTP'
                    : 'Resend in ${viewModel.resendSeconds}s',
                style: AppTextStyles.signupAction.copyWith(
                  color: canResend
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // CHANGE NUMBER
  // =========================================================

  Widget _buildChangeNumber() {
    return TextButton.icon(
      onPressed: _changeNumber,

      icon: const Icon(
        Icons.edit_outlined,
        size: 18,
        color: AppColors.textSecondary,
      ),

      label: Text(
        'Change mobile number',
        style: AppTextStyles.labelLarge.copyWith(
          fontSize: 13,
          color: AppColors.textSecondary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
