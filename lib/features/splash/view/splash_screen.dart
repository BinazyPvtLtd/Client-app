import 'package:client_app/features/auth/view/login_screen.dart';
import 'package:client_app/features/splash/view/widgets/animated_patgolito_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../viewmodel/splash_viewmodel.dart';

class SplashScreen
    extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // =========================================================
  // ENTRANCE
  // =========================================================

  late final AnimationController
      _entranceController;

  late final Animation<double>
      _fadeAnimation;

  late final Animation<double>
      _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // =======================================================
    // SMOOTH SCREEN ENTRANCE
    // =======================================================

    _entranceController =
        AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 650,
      ),
    );

    _fadeAnimation =
        CurvedAnimation(
      parent:
          _entranceController,
      curve:
          Curves.easeOutCubic,
    );

    _scaleAnimation =
        Tween<double>(
      begin: 0.96,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent:
            _entranceController,
        curve:
            Curves.easeOutCubic,
      ),
    );

    _entranceController.forward();

    // =======================================================
    // SPLASH TIMER
    // =======================================================

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) {
        if (!mounted) {
          return;
        }

        context
            .read<SplashViewModel>()
            .initialize(
          onComplete:
              _goToNextScreen,
        );
      },
    );
  }

  // =========================================================
  // NAVIGATION
  // =========================================================

  void _goToNextScreen() {
    if (!mounted) {
      return;
    }

    Navigator.of(context)
        .pushReplacement(
      PageRouteBuilder(
        transitionDuration:
            const Duration(
          milliseconds: 450,
        ),

        pageBuilder: (
          context,
          animation,
          secondaryAnimation,
        ) {
          return const LoginScreen();
        },

        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve:
                  Curves.easeOut,
            ),
            child: child,
          );
        },
      ),
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _entranceController.dispose();

    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          AppColors.primary,

      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity:
                _fadeAnimation,

            child: ScaleTransition(
              scale:
                  _scaleAnimation,

              child: Column(
                mainAxisSize:
                    MainAxisSize.min,

                children: [
                  // =====================================
                  // ROUTE + TRUCK + PATGOLITO
                  // =====================================

                  const AnimatedPatgolitoLogo(),

                  const SizedBox(
                    height:
                        AppSpacing.md,
                  ),

                  // =====================================
                  // TAGLINE
                  // =====================================

                  Text(
                    'Move Anything. Anywhere.',

                    textAlign:
                        TextAlign.center,

                    style:
                        AppTextStyles
                            .splashTagline,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}