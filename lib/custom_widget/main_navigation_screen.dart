import 'package:client_app/features/account/view/account_screen.dart';
import 'package:client_app/features/home/view/home_screen.dart';
import 'package:client_app/features/home/widgets/home_bottom_navigation.dart';
import 'package:client_app/features/orders/view/orders_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';



class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({
    super.key,
  });

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // =========================================================
  // TAB SCREENS
  // =========================================================

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = const [
      HomeView(),
      OrdersScreen(),
      _PaymentsPlaceholder(),
      AccountScreen(),
    ];
  }

  // =========================================================
  // CHANGE TAB
  // =========================================================

  void _changeTab(int index) {
    if (_selectedIndex == index) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // Only content changes.
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      // Bottom navigation stays fixed.
      bottomNavigationBar: HomeBottomNavigation(
        selectedIndex: _selectedIndex,
        onTap: _changeTab,
      ),
    );
  }
}

// ============================================================
// TEMPORARY PAYMENTS SCREEN
// ============================================================

class _PaymentsPlaceholder extends StatelessWidget {
  const _PaymentsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Text(
            'Payments',
          ),
        ),
      ),
    );
  }
}

// ============================================================
// TEMPORARY PROFILE SCREEN
// ============================================================

