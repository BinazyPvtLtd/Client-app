import 'package:client_app/features/home/view/home_screen.dart';
import 'package:client_app/features/home/widgets/home_bottom_navigation.dart';
import 'package:client_app/features/orders/model/order_model.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../viewmodel/orders_viewmodel.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({
    super.key,
  });

  @override
  State<OrdersScreen> createState() =>
      _OrdersScreenState();
}

class _OrdersScreenState
    extends State<OrdersScreen> {
  late final OrdersViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = OrdersViewModel();
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

      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,

          builder: (
            context,
            _,
          ) {
            return Column(
              children: [
                // =============================================
                // HEADER
                // =============================================

                _buildHeader(),

                // =============================================
                // FILTERS
                // =============================================

                _buildFilters(),

                const SizedBox(
                  height: AppSpacing.xxl,
                ),

                // =============================================
                // ORDERS
                // =============================================

                Expanded(
                  child:
                      _buildOrdersList(),
                ),
              ],
            );
          },
        ),
      ),

      // =====================================================
      // BOTTOM NAVIGATION
      // =====================================================


    );
  }
// =========================================================
// BOTTOM NAVIGATION ACTION
// =========================================================

void _handleBottomNavigation(
  BuildContext context,
  int index,
) {
  switch (index) {
    // =====================================================
    // HOME
    // =====================================================

    case 0:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeView(),
        ),
      );
      break;

    // =====================================================
    // ORDERS
    // =====================================================

    case 1:
      // Already on Orders screen.
      break;

    // =====================================================
    // PAYMENTS
    // =====================================================

    case 2:
      debugPrint('Payments clicked');

      // Later:
      //
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => const PaymentsScreen(),
      //   ),
      // );

      break;

    // =====================================================
    // PROFILE
    // =====================================================

    case 3:
      debugPrint('Profile clicked');

      // Later:
      //
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => const ProfileScreen(),
      //   ),
      // );

      break;
  }
}
  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
      ),

      child: Row(
        children: [
          IconButton(
            onPressed: () {
              _viewModel.openMenu(
                context,
              );
            },

            icon: const Icon(
              Icons.menu_rounded,
              color:
                  AppColors.textPrimary,
              size:
                  AppSpacing.iconLarge,
            ),
          ),

          Expanded(
            child: Text(
              'My Orders',

              textAlign:
                  TextAlign.center,

              style:
                  AppTextStyles.screenTitle,
            ),
          ),

          IconButton(
            onPressed: () {
              _viewModel
                  .openNotifications(
                context,
              );
            },

            icon: const Icon(
              Icons
                  .notifications_none_rounded,

              color:
                  AppColors.textPrimary,

              size:
                  AppSpacing.iconLarge,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // FILTERS
  // =========================================================

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal:
            AppSpacing.screenHorizontal,
      ),

      child: Row(
        children: [
          Expanded(
            child: _OrderFilterChip(
              title: 'Ongoing',

              selected:
                  _viewModel
                          .selectedFilter ==
                      OrderFilter.ongoing,

              onTap: () {
                _viewModel.changeFilter(
                  OrderFilter.ongoing,
                );
              },
            ),
          ),

          const SizedBox(
            width: AppSpacing.md,
          ),

          Expanded(
            child: _OrderFilterChip(
              title: 'Completed',

              selected:
                  _viewModel
                          .selectedFilter ==
                      OrderFilter.completed,

              onTap: () {
                _viewModel.changeFilter(
                  OrderFilter.completed,
                );
              },
            ),
          ),

          const SizedBox(
            width: AppSpacing.md,
          ),

          Expanded(
            child: _OrderFilterChip(
              title: 'Cancelled',

              selected:
                  _viewModel
                          .selectedFilter ==
                      OrderFilter.cancelled,

              onTap: () {
                _viewModel.changeFilter(
                  OrderFilter.cancelled,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // ORDERS LIST
  // =========================================================

  Widget _buildOrdersList() {
    final orders =
        _viewModel.filteredOrders;

    if (orders.isEmpty) {
      return Center(
        child: Text(
          'No orders found.',
          style:
              AppTextStyles.bodyMedium,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        0,
        AppSpacing.screenHorizontal,
        AppSpacing.xxl,
      ),

      itemCount: orders.length,

      separatorBuilder: (
        context,
        index,
      ) {
        return const SizedBox(
          height: AppSpacing.lg,
        );
      },

      itemBuilder: (
        context,
        index,
      ) {
        final order =
            orders[index];

        return _OrderCard(
          order: order,

          onTap: () {
            _viewModel.openOrder(
              context,
              order,
            );
          },
        );
      },
    );
  }

  // =========================================================
  // BOTTOM NAVIGATION
  // =========================================================

  Widget _buildBottomNavigation() {
    return SafeArea(
      top: false,

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),

        decoration: BoxDecoration(
          color: AppColors.background,

          border: const Border(
            top: BorderSide(
              color: AppColors.border,
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

        child: Row(
          children: [
            _BottomNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              selected:
                  _viewModel
                          .selectedBottomNavIndex ==
                      0,
              onTap: () {
                _viewModel
                    .changeBottomNavigation(
                  0,
                );
              },
            ),

            _BottomNavItem(
              icon:
                  Icons.inventory_2_outlined,
              label: 'Orders',
              selected:
                  _viewModel
                          .selectedBottomNavIndex ==
                      1,
              onTap: () {
                _viewModel
                    .changeBottomNavigation(
                  1,
                );
              },
            ),

            _BottomNavItem(
              icon:
                  Icons.local_offer_outlined,
              label: 'Offers',
              selected:
                  _viewModel
                          .selectedBottomNavIndex ==
                      2,
              onTap: () {
                _viewModel
                    .changeBottomNavigation(
                  2,
                );
              },
            ),

            _BottomNavItem(
              icon:
                  Icons.payments_outlined,
              label: 'Payments',
              selected:
                  _viewModel
                          .selectedBottomNavIndex ==
                      3,
              onTap: () {
                _viewModel
                    .changeBottomNavigation(
                  3,
                );
              },
            ),

            _BottomNavItem(
              icon:
                  Icons.person_outline_rounded,
              label: 'Account',
              selected:
                  _viewModel
                          .selectedBottomNavIndex ==
                      4,
              onTap: () {
                _viewModel
                    .changeBottomNavigation(
                  4,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// FILTER CHIP
// =====================================================================

class _OrderFilterChip
    extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _OrderFilterChip({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusCircular,
        ),

        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 180,
          ),

          alignment:
              Alignment.center,

          padding:
              const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),

          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary
                    .withOpacity(
                      AppColors
                          .opacityExtraLight,
                    )
                : AppColors.surface,

            borderRadius:
                BorderRadius.circular(
              AppSpacing
                  .radiusCircular,
            ),
          ),

          child: Text(
            title,

            style:
                AppTextStyles.labelLarge
                    .copyWith(
              color: selected
                  ? AppColors.primary
                  : AppColors
                      .textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// ORDER CARD
// =====================================================================

class _OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;

  const _OrderCard({
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,

      borderRadius:
          BorderRadius.circular(
        AppSpacing.radiusCard,
      ),

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusCard,
        ),

        child: Container(
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
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // =============================================
              // HEADER
              // =============================================

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          order.vehicleName,

                          style: AppTextStyles
                              .heading2,
                        ),

                        const SizedBox(
                          height:
                              AppSpacing.xs,
                        ),

                        Text(
                          'Trip ID: ${order.id} • ${order.dateTime}',

                          style: AppTextStyles
                              .bodyMedium,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    width:
                        AppSpacing.md,
                  ),

                  _OrderStatusBadge(
                    status:
                        order.status,
                  ),
                ],
              ),

              const SizedBox(
                height:
                    AppSpacing.xxl,
              ),

              // =============================================
              // PICKUP + DROP
              // =============================================

              _RouteSection(
                pickup: order.pickup,
                drop: order.drop,
              ),

              const SizedBox(
                height:
                    AppSpacing.xl,
              ),

              const Divider(),

              const SizedBox(
                height:
                    AppSpacing.lg,
              ),

              // =============================================
              // FARE
              // =============================================

              Row(
                children: [
                  Expanded(
                    child: Text(
                      order.status ==
                              OrderStatus
                                  .delivered
                          ? 'Total Fare'
                          : 'Estimated Fare',

                      style:
                          AppTextStyles.bodyLarge,
                    ),
                  ),

                  Text(
                    '₹${order.fare.toInt()}',

                    style: AppTextStyles
                        .reviewPrice,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// STATUS BADGE
// =====================================================================

class _OrderStatusBadge
    extends StatelessWidget {
  final OrderStatus status;

  const _OrderStatusBadge({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final String label;

    switch (status) {
      case OrderStatus.onTheWay:
        label = 'On the way';
        break;

      case OrderStatus.delivered:
        label = 'Delivered';
        break;

      case OrderStatus.cancelled:
        label = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusCircular,
        ),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Text(
        label,

        style:
            AppTextStyles.labelLarge.copyWith(
          color: status ==
                  OrderStatus.cancelled
              ? AppColors.error
              : status ==
                      OrderStatus.delivered
                  ? AppColors
                      .textSecondary
                  : AppColors.primary,
        ),
      ),
    );
  }
}

// =====================================================================
// ROUTE
// =====================================================================

class _RouteSection
    extends StatelessWidget {
  final String pickup;
  final String drop;

  const _RouteSection({
    required this.pickup,
    required this.drop,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RouteRow(
          title: 'PICKUP',
          address: pickup,
          filled: true,
        ),

        Padding(
          padding:
              const EdgeInsets.only(
            left: 10,
          ),

          child: Align(
            alignment:
                Alignment.centerLeft,

            child: Container(
              width: 2,
              height: 28,

              color:
                  AppColors.border,
            ),
          ),
        ),

        _RouteRow(
          title: 'DROP',
          address: drop,
          filled: false,
        ),
      ],
    );
  }
}

// =====================================================================
// ROUTE ROW
// =====================================================================

class _RouteRow extends StatelessWidget {
  final String title;
  final String address;
  final bool filled;

  const _RouteRow({
    required this.title,
    required this.address,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Container(
          width: 20,
          height: 20,

          alignment:
              Alignment.center,

          decoration: BoxDecoration(
            shape: BoxShape.circle,

            color: filled
                ? AppColors.primary
                : AppColors.white,

            border: Border.all(
              color:
                  AppColors.primary,
              width: AppSpacing
                  .borderMedium,
            ),
          ),
        ),

        const SizedBox(
          width: AppSpacing.md,
        ),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                title,

                style:
                    AppTextStyles.labelLarge,
              ),

              const SizedBox(
                height:
                    AppSpacing.sm,
              ),

              Text(
                address,

                style:
                    AppTextStyles.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// BOTTOM NAV ITEM
// =====================================================================

class _BottomNavItem
    extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusCircular,
        ),

        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 180,
          ),

          padding:
              const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
          ),

          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary
                    .withOpacity(
                      AppColors
                          .opacityExtraLight,
                    )
                : AppColors.transparent,

            borderRadius:
                BorderRadius.circular(
              AppSpacing.radiusCircular,
            ),
          ),

          child: Column(
            mainAxisSize:
                MainAxisSize.min,

            children: [
              Icon(
                icon,

                color: selected
                    ? AppColors.primary
                    : AppColors
                        .textSecondary,

                size:
                    AppSpacing.iconMedium,
              ),

              const SizedBox(
                height: AppSpacing.xs,
              ),

              Text(
                label,

                maxLines: 1,

                overflow:
                    TextOverflow.ellipsis,

                style: selected
                    ? AppTextStyles
                        .homeNavLabelSelected
                    : AppTextStyles
                        .homeNavLabelUnselected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}