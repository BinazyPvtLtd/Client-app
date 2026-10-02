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
  final String verificationId;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtpViewModel(
        verificationId: verificationId,
      ),
      child: _OtpView(
        phoneNumber: phoneNumber,
      ),
    );
  }
}

class _OtpView extends StatefulWidget {
  final String phoneNumber;

  const _OtpView({
    required this.phoneNumber,
  });

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  late final List<TextEditingController> _controllers;

  late final List<FocusNode> _focusNodes;

  late final List<FocusNode> _keyboardFocusNodes;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      6,
      (_) => TextEditingController(),
    );

    _focusNodes = List.generate(
      6,
      (_) => FocusNode(),
    );

    _keyboardFocusNodes = List.generate(
      6,
      (_) => FocusNode(),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }

    for (final focusNode in _keyboardFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  // =========================================================
  // OTP INPUT
  // =========================================================

  void _onOtpChanged(
    String value,
    int index,
  ) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }

    _updateOtp();
  }

  void _handleKeyEvent(
    int index,
    KeyEvent event,
  ) {
    if (event is KeyDownEvent &&
        event.logicalKey ==
            LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _controllers[index - 1].clear();

      _focusNodes[index - 1].requestFocus();

      _updateOtp();
    }
  }

  void _updateOtp() {
    final otp = _controllers
        .map(
          (controller) => controller.text,
        )
        .join();

    context.read<OtpViewModel>().setOtp(otp);
  }

  // =========================================================
  // VERIFY OTP
  // =========================================================

  void _verifyOtp() {
    FocusScope.of(context).unfocus();

    context.read<OtpViewModel>().verifyOtp(
          context,
          phoneNumber: widget.phoneNumber,
        );
  }

  // =========================================================
  // RESEND OTP
  // =========================================================

  void _resendOtp() {
    context.read<OtpViewModel>().resendOtp(
          context,
          phoneNumber: widget.phoneNumber,
        );
  }

  // =========================================================
  // CHANGE NUMBER
  // =========================================================

  void _changeNumber() {
    Navigator.pop(context);
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (
            context,
            constraints,
          ) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.xxl,
                vertical: AppSpacing.xl,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    // =================================================
                    // TOP SPACE
                    // =================================================

                    SizedBox(
                      height: AppSpacing.huge,
                    ),

                    // =================================================
                    // LOGO
                    // =================================================

                    _buildLogo(),

                    // =================================================
                    // TITLE
                    // =================================================

                    SizedBox(
                      height: AppSpacing.xxxl,
                    ),

                    _buildTitle(),

                    // =================================================
                    // SUBTITLE
                    // =================================================

                    SizedBox(
                      height: AppSpacing.sm,
                    ),

                    _buildSubtitle(),

                    // =================================================
                    // OTP
                    // =================================================

                    SizedBox(
                      height: AppSpacing.xxxl,
                    ),

                    _buildOtpFields(),

                    // =================================================
                    // VERIFY
                    // =================================================

                    SizedBox(
                      height: AppSpacing.xxxl,
                    ),

                    _buildVerifyButton(),

                    // =================================================
                    // RESEND
                    // =================================================

                    SizedBox(
                      height: AppSpacing.xl,
                    ),

                    _buildResend(),

                    // =================================================
                    // CHANGE NUMBER
                    // =================================================

                    SizedBox(
                      height: AppSpacing.lg,
                    ),

                    _buildChangeNumber(),

                    SizedBox(
                      height: AppSpacing.xl,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // =========================================================
  // LOGO
  // =========================================================

  Widget _buildLogo() {
    return SizedBox(
      width: 230,
      height: 150,
      child: Image.asset(
        AppAssets.patgolitoLogo1,
        fit: BoxFit.contain,
      ),
    );
  }

  // =========================================================
  // TITLE
  // =========================================================

  Widget _buildTitle() {
    return Text(
      'Verify your number',
      textAlign: TextAlign.center,
      style: AppTextStyles.loginTitle,
    );
  }

  // =========================================================
  // SUBTITLE
  // =========================================================

  Widget _buildSubtitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyles.loginSubtitle,
        children: [
          const TextSpan(
            text: 'Enter the 6-digit code sent to\n',
          ),
          TextSpan(
            text: widget.phoneNumber,
            style: AppTextStyles.countryCode,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // OTP FIELDS
  // =========================================================

  Widget _buildOtpFields() {
    return LayoutBuilder(
      builder: (
        context,
        constraints,
      ) {
        const double spacing = 12;

        final availableWidth =
            constraints.maxWidth -
            (spacing * 5);

        final fieldWidth =
            (availableWidth / 6).clamp(
          45.0,
          62.0,
        );

        return Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: List.generate(
            6,
            (index) {
              return _buildOtpField(
                index,
                fieldWidth,
              );
            },
          ),
        );
      },
    );
  }

  // =========================================================
  // SINGLE OTP FIELD
  // =========================================================

  Widget _buildOtpField(
  int index,
  double width,
) {
  return SizedBox(
    width: width,
    height: 58, // compact + balanced
    child: KeyboardListener(
      focusNode: _keyboardFocusNodes[index],
      onKeyEvent: (event) {
        _handleKeyEvent(
          index,
          event,
        );
      },
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],

        keyboardType: TextInputType.number,
        textInputAction: index == 5
            ? TextInputAction.done
            : TextInputAction.next,

        textAlign: TextAlign.center,
        maxLength: 1,

        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],

        style: AppTextStyles.heading2.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),

        decoration: InputDecoration(
          counterText: '',

          filled: true,
          fillColor: AppColors.white,

          contentPadding: EdgeInsets.zero,

          // ==========================================
          // NORMAL BORDER
          // ==========================================

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: AppColors.border,
              width: 1.2,
            ),
          ),

          // ==========================================
          // FOCUSED BORDER
          // ==========================================

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 1.8,
            ),
          ),

          // ==========================================
          // DEFAULT BORDER
          // ==========================================

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: AppColors.border,
            ),
          ),
        ),

        onChanged: (value) {
          _onOtpChanged(
            value,
            index,
          );
        },

        onSubmitted: (_) {
          if (index == 5) {
            _verifyOtp();
          }
        },
      ),
    ),
  );
}
  // =========================================================
  // VERIFY BUTTON
  // =========================================================

  Widget _buildVerifyButton() {
    return Consumer<OtpViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton(
            onPressed: viewModel.isLoading
                ? null
                : _verifyOtp,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  AppColors.primary,
              disabledBackgroundColor:
                  AppColors.primary.withValues(
                alpha: 0.6,
              ),
              elevation: 2,
              shadowColor:
                  AppColors.primary.withValues(
                alpha: 0.25,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(18),
              ),
            ),
            child: viewModel.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child:
                        CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    'Verify & Continue',
                    style:
                        AppTextStyles.buttonText,
                  ),
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
      builder: (
        context,
        viewModel,
        child,
      ) {
        return Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Text(
              "Didn't receive the code? ",
              style:
                  AppTextStyles.signupText,
            ),
            GestureDetector(
              onTap: viewModel.canResend
                  ? _resendOtp
                  : null,
              child: Text(
                viewModel.canResend
                    ? 'Resend OTP'
                    : 'Resend in ${viewModel.resendSeconds}s',
                style:
                    AppTextStyles.signupAction,
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // CHANGE MOBILE NUMBER
  // =========================================================

  Widget _buildChangeNumber() {
    return GestureDetector(
      onTap: _changeNumber,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit_outlined,
              size: 22,
              color:
                  AppColors.textSecondary,
            ),
            SizedBox(
              width: AppSpacing.sm,
            ),
            Text(
              'Change mobile number',
              style:
                  AppTextStyles.heading3.copyWith(
                color:
                    AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}