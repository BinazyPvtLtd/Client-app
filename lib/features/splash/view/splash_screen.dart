import 'package:client_app/core/constant/app_assets.dart';
import 'package:client_app/features/auth/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../viewmodel/splash_viewmodel.dart';
import 'widgets/animated_patgolito_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  // =========================================================
  // ANIMATIONS
  // =========================================================

  late final AnimationController _logoController;

  late final AnimationController _contentController;

  late final Animation<double> _logoScale;

  late final Animation<double> _logoFade;

  late final Animation<double> _contentFade;

  late final Animation<Offset> _contentSlide;

  @override
  void initState() {
    super.initState();

    // =======================================================
    // LOGO CONTROLLER
    // =======================================================

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 900,
      ),
    );

    _logoScale = Tween<double>(
      begin: 0.55,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.elasticOut,
      ),
    );

    _logoFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOut,
      ),
    );

    // =======================================================
    // CONTENT CONTROLLER
    // =======================================================

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ),
    );

    _contentFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: Curves.easeOut,
      ),
    );

    _contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: Curves.easeOutCubic,
      ),
    );

    // =======================================================
    // START
    // =======================================================

    _startAnimations();

    // =======================================================
    // INITIALIZE VIEWMODEL
    // =======================================================

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (!mounted) return;

        context.read<SplashViewModel>().initialize(
          onComplete: _goToNextScreen,
        );
      },
    );
  }

  // =========================================================
  // START ANIMATIONS
  // =========================================================

  Future<void> _startAnimations() async {
    await _logoController.forward();

    if (!mounted) return;

    await Future.delayed(
      const Duration(milliseconds: 100),
    );

    if (!mounted) return;

    _contentController.forward();
  }

  // =========================================================
  // NAVIGATION
  // =========================================================

  void _goToNextScreen() {
  if (!mounted) return;

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => const LoginScreen(),
    ),
  );
}
  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _logoController.dispose();
    _contentController.dispose();

    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // =================================================
              // LOGO
              // =================================================

              FadeTransition(
                opacity: _logoFade,
                child: ScaleTransition(
                  scale: _logoScale,
                  child: _buildLogo(),
                ),
              ),

              SizedBox(
                height: AppSpacing.xl,
              ),

              // =================================================
              // PATGOLITO + TAGLINE
              // =================================================

              FadeTransition(
                opacity: _contentFade,
                child: SlideTransition(
                  position: _contentSlide,
                  child: Column(
                    children: [
                      const AnimatedPatgolitoText(),

                      const SizedBox(
                        height: AppSpacing.sm,
                      ),

                      Text(
                        'Move Anything. Anywhere.',
                        style: AppTextStyles.splashTagline,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // LOGO
  // =========================================================

Widget _buildLogo() {
  return SizedBox(
    width: 170,
    height: 170,
    child: Image.asset(
      AppAssets.patgolitoLogo,
      width: 170,
      height: 170,
      fit: BoxFit.contain,
    ),
  );
}
}