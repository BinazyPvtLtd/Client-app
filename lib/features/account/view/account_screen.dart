import 'package:client_app/features/auth/services/logout_service.dart';
import 'package:client_app/features/auth/view/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../viewmodel/account_viewmodel.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    super.key,
  });

  @override
  State<AccountScreen> createState() =>
      _AccountScreenState();
}

class _AccountScreenState
    extends State<AccountScreen> {
  late final AccountViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = AccountViewModel();
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
          builder: (
            context,
            _,
          ) {
            return SingleChildScrollView(
              physics:
                  const BouncingScrollPhysics(),

              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.lg,
                AppSpacing.screenHorizontal,
                AppSpacing.xxxl,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,

                children: [
                  // =========================================
                  // HEADER
                  // =========================================

                  _buildHeader(),

                  const SizedBox(
                    height: AppSpacing.xxxl,
                  ),

                  // =========================================
                  // USER CARD
                  // =========================================

                  _buildUserCard(),

                  const SizedBox(
                    height: AppSpacing.xxxl,
                  ),

                  // =========================================
                  // MENU
                  // =========================================

                  _buildMenuCard(),

                  const SizedBox(
                    height: AppSpacing.xxl,
                  ),

                  ListTile(
  leading: const Icon(
    Icons.logout,
    color: Colors.red,
  ),
  title: const Text(
    'Logout',
    style: TextStyle(
      color: Colors.red,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  ),
  trailing: const Icon(
    Icons.arrow_forward_ios,
    size: 16,
    color: Colors.red,
  ),
  onTap: () async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true || !context.mounted) {
      return;
    }

    try {
      // Call logout API and clear saved token.
      await LogoutService().logout();

      if (!context.mounted) return;

      // Navigate to Login Screen.
      Navigator.of(context, rootNavigator: true)
          .pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
        (route) => false,
      );
    } catch (error) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed: $error'),
        ),
      );
    }
  },
),
                ],
              ),
            );
          },
        ),
      ),

      // IMPORTANT:
      // NO bottomNavigationBar here.
      // MainNavigationScreen handles it.
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            _viewModel.openMenu(
              context,
            );
          },

          icon: const Icon(
            Icons.menu_rounded,
            color: AppColors.textPrimary,
            size: AppSpacing.iconLarge,
          ),
        ),

        const SizedBox(
          width: AppSpacing.md,
        ),

        Expanded(
          child: Text(
            'Account',
            style: AppTextStyles.screenTitle,
          ),
        ),

        // =========================================
        // SMALL PROFILE AVATAR
        // =========================================

        // Container(
        //   width: 54,
        //   height: 54,

        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,

        //     color: AppColors.surface,

        //     border: Border.all(
        //       color: AppColors.border,
        //     ),
        //   ),

        //   child: const Icon(
        //     Icons.person_rounded,
        //     color: AppColors.textSecondary,
        //     size: AppSpacing.iconLarge,
        //   ),
        // ),
      ],
    );
  }

  // =========================================================
  // USER CARD
  // =========================================================

  Widget _buildUserCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(
          AppSpacing.radiusCard,
        ),

        // border: Border.all(
        //   color: AppColors.border,
        // ),
      ),

      child: Row(
        children: [
          // =========================================
          // BIG AVATAR
          // =========================================

          Container(
            width: 82,
            height: 82,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: AppColors.surface,

              border: Border.all(
                color: AppColors.border,
              ),
            ),

            child: const Icon(
              Icons.person_rounded,
              color: AppColors.textSecondary,
              size: AppSpacing.iconExtraLarge,
            ),
          ),

          const SizedBox(
            width: AppSpacing.xl,
          ),

          // =========================================
          // USER DETAILS
          // =========================================

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  _viewModel.userName,

                  style:
                      AppTextStyles.heading1,
                ),

                const SizedBox(
                  height: AppSpacing.sm,
                ),

                Text(
                  _viewModel.phoneNumber,

                  style:
                      AppTextStyles.bodyLarge
                          .copyWith(
                    color:
                        AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // MENU CARD
  // =========================================================

  Widget _buildMenuCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(
          AppSpacing.radiusCard,
        ),

        // border: Border.all(
        //   color: AppColors.border,
        // ),
      ),

      child: Column(
        children: [
          _AccountMenuItem(
            icon: Icons.person_outline_rounded,
            title: 'My Profile',
            onTap: () {
              _viewModel.openMyProfile(
                context,
              );
            },
          ),

          const Divider(
            height: 1,
          ),

          _AccountMenuItem(
            icon: Icons.location_on_outlined,
            title: 'Saved Addresses',
            onTap: () {
              _viewModel.openSavedAddresses(
                context,
              );
            },
          ),

          const Divider(
            height: 1,
          ),

          // _AccountMenuItem(
          //   icon: Icons.payments_outlined,
          //   title: 'Payment Methods',
          //   onTap: () {
          //     _viewModel.openPaymentMethods(
          //       context,
          //     );
          //   },
          // ),

          // const Divider(
          //   height: 1,
          // ),

          // _AccountMenuItem(
          //   icon: Icons.local_shipping_outlined,
          //   title: 'Orders',
          //   onTap: () {
          //     _viewModel.openOrders(
          //       context,
          //     );
          //   },
          // ),

          // const Divider(
          //   height: 1,
          // ),

          // _AccountMenuItem(
          //   icon: Icons.notifications_none_rounded,
          //   title: 'Notifications',
          //   onTap: () {
          //     _viewModel.openNotifications(
          //       context,
          //     );
          //   },
          // ),
          
          // const Divider(
          //   height: 1,
          // ),

          _AccountMenuItem(
            icon: Icons.support_agent_rounded,
            title: 'Help & Support',
            onTap: () {
              _viewModel.openHelpSupport(
                context,
              );
            },
          ),

          const Divider(
            height: 1,
          ),
          _AccountMenuItem(
            icon: Icons.description_outlined,
            title: 'Terms & Privacy',
            onTap: () {
              _viewModel.openTermsPrivacy(
                context,
              );
            },
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// ACCOUNT MENU ITEM
// =====================================================================

class _AccountMenuItem
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _AccountMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,

      child: InkWell(
        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.xl,
          ),

          child: Row(
            children: [
              Icon(
                icon,

                color:
                    AppColors.textSecondary,

                size:
                    AppSpacing.iconMedium,
              ),

              const SizedBox(
                width: AppSpacing.xl,
              ),

              Expanded(
                child: Text(
                  title,

                  style:
                      AppTextStyles.heading3,
                ),
              ),

              const Icon(
                Icons.chevron_right_rounded,

                color:
                    AppColors.textTertiary,

                size:
                    AppSpacing.iconMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}