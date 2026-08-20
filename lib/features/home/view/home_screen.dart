// import 'package:client_app/features/home/viewmodel/home_viewmodel.dart';
// import 'package:flutter/material.dart';

// import '../../../../core/constant/app_assets.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_spacing.dart';
// import '../../../../core/theme/app_text_styles.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({
//     super.key,
//   });

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   // =========================================================
//   // BUILD
//   // =========================================================

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);

//     return Scaffold(
//       backgroundColor: AppColors.background,

//       // =====================================================
//       // BODY
//       // =====================================================

//       // body: SafeArea(
//       //   bottom: false,
//       //   child: CustomScrollView(
//       //     physics: const BouncingScrollPhysics(),
//       //     slivers: [
//       //       SliverPadding(
//       //         padding: EdgeInsets.fromLTRB(
//       //           _horizontalPadding(size.width),
//       //           AppSpacing.lg,
//       //           _horizontalPadding(size.width),
//       //           AppSpacing.bottomNavigationSpace,
//       //         ),
//       //         sliver: SliverList(
//       //           delegate: SliverChildListDelegate(
//       //             [
//       //               _buildHeader(),

//       //               SizedBox(
//       //                 height: _sectionSpacing(size.height),
//       //               ),

//       //               _buildGreeting(),

//       //               const SizedBox(
//       //                 height: AppSpacing.xxxl,
//       //               ),

//       //               _buildServiceGrid(
//       //                 size.width,
//       //               ),

//       //               const SizedBox(
//       //                 height: AppSpacing.xxxl,
//       //               ),

//       //               _buildRewardsCard(),

//       //               const SizedBox(
//       //                 height: AppSpacing.huge,
//       //               ),

//       //               _buildAnnouncementsHeader(),

//       //               const SizedBox(
//       //                 height: AppSpacing.lg,
//       //               ),

//       //               _buildAnnouncements(),
//       //             ],
//       //           ),
//       //         ),
//       //       ),
//       //     ],
//       //   ),
//       // ),

//   body: SafeArea(
//   bottom: false,
//   child: CustomScrollView(
//     physics: const ClampingScrollPhysics(),
//     slivers: [
//       SliverPadding(
//         padding: EdgeInsets.fromLTRB(
//           _horizontalPadding(size.width),
//           AppSpacing.lg,
//           _horizontalPadding(size.width),
//           AppSpacing.bottomNavigationSpace,
//         ),
//         sliver: SliverList(
//           delegate: SliverChildListDelegate(
//             [
//               _buildHeader(),

//               SizedBox(
//                 height: _sectionSpacing(size.height),
//               ),

//               _buildGreeting(),

//               const SizedBox(
//                 height: AppSpacing.xxxl,
//               ),

//               _buildServiceGrid(
//                 size.width,
//               ),

//               const SizedBox(
//                 height: AppSpacing.xxxl,
//               ),

//               _buildRewardsCard(),

//               const SizedBox(
//                 height: AppSpacing.huge,
//               ),

//               _buildAnnouncementsHeader(),

//               const SizedBox(
//                 height: AppSpacing.lg,
//               ),

//               _buildAnnouncements(),
//             ],
//           ),
//         ),
//       ),
//     ],
//   ),
// ),

//       // =====================================================
//       // BOTTOM NAVIGATION
//       // =====================================================

//       bottomNavigationBar: _buildBottomNavigation(),
//     );
//   }

//   // =========================================================
//   // RESPONSIVE PADDING
//   // =========================================================

//   double _horizontalPadding(double width) {
//     if (width < 360) {
//       return AppSpacing.lg;
//     }

//     if (width < 600) {
//       return AppSpacing.xxl;
//     }

//     return AppSpacing.huge;
//   }

//   // =========================================================
//   // SECTION SPACING
//   // =========================================================

//   double _sectionSpacing(double height) {
//     if (height < 700) {
//       return AppSpacing.lg;
//     }

//     if (height < 850) {
//       return AppSpacing.xxl;
//     }

//     return AppSpacing.xxxl;
//   }

//   // =========================================================
//   // HEADER
//   // =========================================================

//   Widget _buildHeader() {
//     return Row(
//       children: [
//         // ===================================================
//         // PROFILE
//         // ===================================================

//         Container(
//           width: AppSpacing.profileAvatarSize,
//           height: AppSpacing.profileAvatarSize,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: AppColors.primary.withValues(
//               alpha: AppColors.opacityLight,
//             ),
//             border: Border.all(
//               color: AppColors.primary.withValues(
//                 alpha: AppColors.opacityMedium,
//               ),
//               width: AppSpacing.borderMedium,
//             ),
//           ),
//           child: ClipOval(
//             child: Image.asset(
//               AppAssets.patgolitoLogo,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),

//         const SizedBox(
//           width: AppSpacing.lg,
//         ),

//         // ===================================================
//         // APP NAME
//         // ===================================================

//         Expanded(
//           child: Text(
//             'Patgolito',
//             style: AppTextStyles.homeAppName,
//           ),
//         ),

//         // ===================================================
//         // NOTIFICATION
//         // ===================================================

//         Material(
//           color: AppColors.transparent,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(
//               AppSpacing.radiusCircular,
//             ),
//             onTap: () {
//               // TODO: Open notifications.
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(
//                 AppSpacing.sm,
//               ),
//               child: Icon(
//                 Icons.notifications_none_rounded,
//                 size: AppSpacing.iconLarge,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // =========================================================
//   // GREETING
//   // =========================================================

//   Widget _buildGreeting() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Hi, Hasan 👋',
//           style: AppTextStyles.homeGreeting,
//         ),

//         const SizedBox(
//           height: AppSpacing.sm,
//         ),

//         Text(
//           'What are you moving today?',
//           style: AppTextStyles.homeSubtitle,
//         ),
//       ],
//     );
//   }

//   // =========================================================
//   // SERVICE GRID
//   // =========================================================

//   Widget _buildServiceGrid(
//   double screenWidth,
// ) {
//   final horizontalPadding =
//       _horizontalPadding(screenWidth);

//   const spacing = AppSpacing.lg;

//   final availableWidth =
//       screenWidth - (horizontalPadding * 2);

//   final cardWidth =
//       (availableWidth - spacing) / 2;

//   return GridView.count(
//     crossAxisCount: 2,
//     crossAxisSpacing: spacing,
//     mainAxisSpacing: spacing,
//     childAspectRatio:
//         cardWidth / AppSpacing.serviceCardHeight,
//     shrinkWrap: true,
//     physics: const NeverScrollableScrollPhysics(),
//     children: [
//       _ServiceCard(
//         title: 'Truck',
//         description:
//             'Mini trucks, pickups\n& commercial\nvehicles',
//         imagePath: AppAssets.homeTruck,
//         onTap: () => HomeViewModel().onServiceSelected(context, 'Truck'),
//       ),

//       _ServiceCard(
//         title: '2 Wheeler',
//         description:
//             'Fast delivery for\nsmall packages',
//         imagePath: AppAssets.homeTwoWheeler,
//         onTap: () => HomeViewModel().onServiceSelected(context, '2 Wheeler'),
//       ),

//       _ServiceCard(
//         title: 'Packers & Movers',
//         description:
//             'Move your home or\noffice',
//         imagePath: AppAssets.homePackersMovers,
//         onTap: () {
//           // TODO: Packers & Movers.
//         },
//       ),

//       _ServiceCard(
//         title: 'More Services',
//         description:
//             'Intercity, Courier &\nmore',
//         imagePath: AppAssets.homeTruck,
//         onTap: () {
//           // TODO: More services.
//         },
//       ),
//     ],
//   );
// }

//   // =========================================================
//   // REWARDS
//   // =========================================================

//   Widget _buildRewardsCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(
//         horizontal: AppSpacing.xl,
//         vertical: AppSpacing.xl,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.primary.withValues(
//           alpha: AppColors.opacityExtraLight,
//         ),
//         borderRadius: BorderRadius.circular(
//           AppSpacing.radiusCard,
//         ),
//         border: Border.all(
//           color: AppColors.primary.withValues(
//             alpha: AppColors.opacityMediumStrong,
//           ),
//           width: AppSpacing.borderThin,
//         ),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Patgolito Rewards',
//                   style: AppTextStyles.homeRewardTitle,
//                 ),

//                 const SizedBox(
//                   height: AppSpacing.xs,
//                 ),

//                 Text(
//                   'Earn rewards on every completed trip',
//                   style:
//                       AppTextStyles.homeRewardSubtitle,
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(
//             width: AppSpacing.md,
//           ),

//           Container(
//             width: AppSpacing.rewardLogoSize,
//             height: AppSpacing.rewardLogoSize,
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(
//                 AppSpacing.radiusMedium,
//               ),
//             ),
//             padding: const EdgeInsets.all(
//               AppSpacing.sm,
//             ),
//             child: Image.asset(
//               AppAssets.patgolitoLogo,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // =========================================================
//   // ANNOUNCEMENTS HEADER
//   // =========================================================

//   Widget _buildAnnouncementsHeader() {
//     return Row(
//       crossAxisAlignment:
//           CrossAxisAlignment.center,
//       children: [
//         Expanded(
//           child: Text(
//             'Announcements',
//             style: AppTextStyles.homeSectionTitle,
//           ),
//         ),

//         GestureDetector(
//           onTap: () {
//             // TODO: View all announcements.
//           },
//           child: Row(
//             children: [
//               Text(
//                 'View all',
//                 style: AppTextStyles.homeViewAll,
//               ),

//               const SizedBox(
//                 width: AppSpacing.xs,
//               ),

//               Icon(
//                 Icons.chevron_right_rounded,
//                 size: AppSpacing.iconMedium,
//                 color: AppColors.primary,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // =========================================================
//   // ANNOUNCEMENTS
//   // =========================================================

//   Widget _buildAnnouncements() {
//     return SizedBox(
//       height: AppSpacing.announcementCardHeight,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         children: [
//           const _AnnouncementCard(
//             title: 'Introducing faster local deliveries',
//             description:
//                 'Get reliable transportation whenever you need it.',
//           ),

//           const SizedBox(
//             width: AppSpacing.lg,
//           ),

//           const _AnnouncementCard(
//             title: 'Earn more with Patgolito',
//             description:
//                 'Complete trips and unlock exciting rewards.',
//           ),
//         ],
//       ),
//     );
//   }

//   // =========================================================
//   // BOTTOM NAVIGATION
//   // =========================================================

//   Widget _buildBottomNavigation() {
//     return SafeArea(
//       top: false,
//       child: Container(
//         padding: const EdgeInsets.all(
//           AppSpacing.sm,
//         ),
//         decoration: BoxDecoration(
//           color: AppColors.surface,
//           borderRadius: const BorderRadius.vertical(
//             top: Radius.circular(
//               AppSpacing.bottomNavigationRadius,
//             ),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.black.withValues(
//                 alpha: AppColors.opacityShadow,
//               ),
//               blurRadius: AppSpacing.shadowBlur,
//               offset: const Offset(
//                 0,
//                 -5,
//               ),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             _BottomNavItem(
//               icon: Icons.home_rounded,
//               label: 'Home',
//               selected: _selectedIndex == 0,
//               onTap: () {
//                 setState(() {
//                   _selectedIndex = 0;
//                 });
//               },
//             ),
//             _BottomNavItem(
//               icon: Icons.inventory_2_outlined,
//               label: 'Orders',
//               selected: _selectedIndex == 1,
//               onTap: () {
//                 setState(() {
//                   _selectedIndex = 1;
//                 });
//               },
//             ),
//             _BottomNavItem(
//               icon: Icons.sell_outlined,
//               label: 'Offers',
//               selected: _selectedIndex == 2,
//               onTap: () {
//                 setState(() {
//                   _selectedIndex = 2;
//                 });
//               },
//             ),
//             _BottomNavItem(
//               icon: Icons.payments_outlined,
//               label: 'Payments',
//               selected: _selectedIndex == 3,
//               onTap: () {
//                 setState(() {
//                   _selectedIndex = 3;
//                 });
//               },
//             ),
//             _BottomNavItem(
//               icon: Icons.person_outline_rounded,
//               label: 'Account',
//               selected: _selectedIndex == 4,
//               onTap: () {
//                 setState(() {
//                   _selectedIndex = 4;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // =====================================================================
// // SERVICE CARD
// // =====================================================================
// class _ServiceCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String imagePath;
//   final VoidCallback onTap;

//   const _ServiceCard({
//     required this.title,
//     required this.description,
//     required this.imagePath,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: AppColors.white,
//       borderRadius: BorderRadius.circular(
//         AppSpacing.radiusCard,
//       ),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(
//           AppSpacing.radiusCard,
//         ),
//         child: Container(
//           padding: const EdgeInsets.fromLTRB(
//             AppSpacing.xl,
//             AppSpacing.xl,
//             AppSpacing.lg,
//             AppSpacing.lg,
//           ),
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(
//               AppSpacing.radiusCard,
//             ),
//             border: Border.all(
//               color: AppColors.primary.withValues(
//                 alpha: AppColors.opacityLightStrong,
//               ),
//               width: AppSpacing.borderThin,
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // =================================================
//               // SERVICE IMAGE
//               // =================================================

//               Expanded(
//                 flex: 5,
//                 child: Center(
//                   child: Image.asset(
//                     imagePath,
//                     width: AppSpacing.serviceImageWidth,
//                     height: AppSpacing.serviceImageHeight,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),

//               const SizedBox(
//                 height: AppSpacing.md,
//               ),

//               // =================================================
//               // TITLE
//               // =================================================

//               Text(
//                 title,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: AppTextStyles.homeCardTitle,
//               ),

//               const SizedBox(
//                 height: AppSpacing.xs,
//               ),

//               // =================================================
//               // DESCRIPTION
//               // =================================================

//               Expanded(
//                 flex: 4,
//                 child: Text(
//                   description,
//                   style: AppTextStyles.homeCardDescription,
//                 ),
//               ),

//               // =================================================
//               // ARROW
//               // =================================================

//               // Align(
//               //   alignment: Alignment.bottomRight,
//               //   child: Icon(
//               //     Icons.arrow_forward_rounded,
//               //     size: AppSpacing.iconExtraLarge,
//               //     color: AppColors.primary,
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // =====================================================================
// // ANNOUNCEMENT CARD
// // =====================================================================

// class _AnnouncementCard extends StatelessWidget {
//   final String title;
//   final String description;

//   const _AnnouncementCard({
//     required this.title,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: AppSpacing.announcementCardWidth,
//       padding: const EdgeInsets.all(
//         AppSpacing.xl,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(
//           AppSpacing.radiusCard,
//         ),
//         border: Border.all(
//           color: AppColors.primary.withValues(
//             alpha: AppColors.opacityLightStrong,
//           ),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment:
//             CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style:
//                 AppTextStyles.homeAnnouncementTitle,
//           ),

//           const SizedBox(
//             height: AppSpacing.sm,
//           ),

//           Expanded(
//             child: Text(
//               description,
//               style: AppTextStyles
//                   .homeAnnouncementDescription,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // =====================================================================
// // BOTTOM NAV ITEM
// // =====================================================================

// class _BottomNavItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;

//   const _BottomNavItem({
//     required this.icon,
//     required this.label,
//     required this.selected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         behavior: HitTestBehavior.opaque,
//         child: AnimatedContainer(
//           duration: const Duration(
//             milliseconds: 200,
//           ),
//           curve: Curves.easeOut,
//           padding: const EdgeInsets.symmetric(
//             vertical: AppSpacing.sm,
//           ),
//           decoration: BoxDecoration(
//             color: selected
//                 ? AppColors.primary.withValues(
//                     alpha: AppColors.opacityLight,
//                   )
//                 : AppColors.transparent,
//             borderRadius:
//                 BorderRadius.circular(
//               AppSpacing.radiusCircular,
//             ),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 icon,
//                 size: AppSpacing.iconMedium,
//                 color: selected
//                     ? AppColors.primary
//                     : AppColors.textSecondary,
//               ),

//               const SizedBox(
//                 height: AppSpacing.xs,
//               ),

//               Text(
//                 label,
//                 style: selected
//     ? AppTextStyles.homeNavLabelSelected
//     : AppTextStyles.homeNavLabelUnselected,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:client_app/features/home/viewmodel/home_viewmodel.dart';
import 'package:client_app/features/home/widgets/dummy_map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../widgets/branding_section.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_bottom_navigation.dart';
import '../widgets/location_search_card.dart';
import '../widgets/offer_banner.dart';
import '../widgets/recent_booking_card.dart';
import '../widgets/service_card.dart';
import '../widgets/vehicle_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  // static const CameraPosition _initialCameraPosition =
  //     CameraPosition(
  //   target: LatLng(
  //     26.8467,
  //     80.9462,
  //   ),
  //   zoom: 13.5,
  // );

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (
          context,
          viewModel,
          child,
        ) {
          return Scaffold(
            backgroundColor: AppColors.background,

            appBar: HomeAppBar(
              onNotificationPressed:
                  viewModel.onNotificationPressed,
              onProfilePressed: viewModel.onProfilePressed,
            ),

            body: Stack(
              children: [
                // =============================================
                // GOOGLE MAP
                // =============================================

                // const Positioned.fill(
                //   child: GoogleMap(
                //     initialCameraPosition:
                //         _initialCameraPosition,

                //     myLocationButtonEnabled: false,

                //     zoomControlsEnabled: false,

                //     compassEnabled: false,

                //     mapToolbarEnabled: false,

                //     buildingsEnabled: true,

                //     trafficEnabled: false,
                //   ),
                // ),

                const Positioned.fill(
  child: DummyMap(),
),

                // =============================================
                // MAP BUTTON
                // =============================================

                Positioned(
                  right: AppSpacing.lg,
                  top: AppSpacing.lg,
                  child: FloatingActionButton.small(
                    heroTag: 'map_location',
                    elevation: 3,
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.black,
                    onPressed: () {
                      debugPrint(
                        'Move map to user location',
                      );
                    },
                    child: const Icon(
                      Icons.my_location_rounded,
                    ),
                  ),
                ),

                // =============================================
                // DRAGGABLE DASHBOARD
                // =============================================

                DraggableScrollableSheet(
                  controller: _sheetController,

                  // Dashboard starts almost fully visible.
                  initialChildSize: 0.90,

                  // Dragging DOWN exposes this much map.
                  minChildSize: 0.50,

                  // Dragging UP closes map almost completely.
                  maxChildSize: 0.97,

                  snap: true,

                  snapSizes: const [
                    0.50,
                    0.90,
                    0.97,
                  ],

                  builder: (
                    context,
                    scrollController,
                  ) {
                    return _DashboardSheet(
                      scrollController:
                          scrollController,
                      viewModel: viewModel,
                    );
                  },
                ),
              ],
            ),

            bottomNavigationBar: HomeBottomNavigation(
              selectedIndex:
                  viewModel.selectedBottomNavIndex,
              onTap:
                  viewModel.changeBottomNavigation,
            ),
          );
        },
      ),
    );
  }
}

class _DashboardSheet extends StatelessWidget {
  final ScrollController scrollController;
  final HomeViewModel viewModel;

  const _DashboardSheet({
    required this.scrollController,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            AppSpacing.radiusExtraLarge,
          ),
          topRight: Radius.circular(
            AppSpacing.radiusExtraLarge,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: CustomScrollView(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          // ==========================================
          // DRAG HANDLE
          // ==========================================

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.md,
                bottom: AppSpacing.xl,
              ),
              child: Center(
                child: Container(
                  width: 54,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius:
                        BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ),

          // ==========================================
          // MAIN CONTENT
          // ==========================================

          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal:
                  AppSpacing.screenHorizontal,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // LOCATION
                  LocationSearchCard(
                    onTap:
                        viewModel.onLocationPressed,
                  ),

                  const SizedBox(
                    height: AppSpacing.xxxl,
                  ),

                  // OFFER
                  const OfferBanner(),

                  const SizedBox(
                    height: AppSpacing.xxxl,
                  ),

                  // ===================================
                  // EVERYTHING IN MINUTES
                  // ===================================

                  Text(
                    'Everything in Minutes',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                          fontWeight:
                              FontWeight.w700,
                        ),
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount:
                        viewModel.services.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,

                      crossAxisSpacing:
                          AppSpacing.lg,

                      mainAxisSpacing:
                          AppSpacing.lg,

                      mainAxisExtent: 185,
                    ),
                    itemBuilder: (context, index) {
  final service = viewModel.services[index];

  return ServiceCard(
    service: service,
    onTap: () {
      viewModel.onServiceSelected(
        context,
        service.title,
      );
    },
  );
},
                  ),

                  const SizedBox(
                    height: AppSpacing.xxxl,
                  ),

                  // ===================================
                  // EXPLORE VEHICLES
                  // ===================================

                  Text(
                    'Explore Vehicles',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                          fontWeight:
                              FontWeight.w700,
                        ),
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  SizedBox(
                    height: 105,
                    child: ListView.separated(
                      scrollDirection:
                          Axis.horizontal,

                      itemCount:
                          viewModel.vehicles.length,

                      separatorBuilder:
                          (_, __) =>
                              const SizedBox(
                        width: AppSpacing.md,
                      ),

                      itemBuilder:
                          (context, index) {
                        final vehicle =
                            viewModel
                                .vehicles[index];

                        return VehicleItem(
  vehicle: vehicle,
  onTap: () {
    viewModel.onVehiclePressed(
      context,
      vehicle,
    );
  },
);
                      },
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.xxxl,
                  ),

                  // ===================================
                  // RECENT BOOKINGS HEADER
                  // ===================================

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      Text(
                        'Recent Bookings',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight:
                                  FontWeight.w700,
                            ),
                      ),

                      TextButton(
                        onPressed: viewModel
                            .onViewAllBookings,
                        child: const Row(
                          children: [
                            Text('View All'),
                            Icon(
                              Icons.chevron_right,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  ...viewModel.recentBookings.map(
                    (booking) => Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: AppSpacing.lg,
                      ),
                      child: RecentBookingCard(
                        booking: booking,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.xxl,
                  ),

                  // ===================================
                  // PATGOLITO BRANDING
                  // ===================================

                  const BrandingSection(),

                  const SizedBox(
                    height: AppSpacing.huge,
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