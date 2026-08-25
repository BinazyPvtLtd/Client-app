

import 'package:client_app/features/home/viewmodel/home_viewmodel.dart';
import 'package:client_app/features/home/widgets/dummy_map.dart';
import 'package:client_app/features/home/widgets/recent_drop_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../widgets/branding_section.dart';
import '../widgets/home_app_bar.dart';
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


                AnimatedBuilder(
  animation: _sheetController,

  builder: (
    context,
    child,
  ) {
    // Sheet attach hone se pehle
    // normal app bar show hogi.
    if (!_sheetController.isAttached) {
      return child!;
    }

    final double sheetSize =
        _sheetController.size;

    // Sheet:
    // 0.90 = normal home position
    // 0.50 = map fully exposed

    const double minSize = 0.50;
    const double normalSize = 0.90;

    final double progress =
        ((sheetSize - minSize) /
                (normalSize - minSize))
            .clamp(
      0.0,
      1.0,
    );

    // progress 1 = appbar normal
    // progress 0 = appbar moved upward

    final double translateY =
        -90 * (1 - progress);

    return Transform.translate(
      offset: Offset(
        0,
        translateY,
      ),

      child: Opacity(
        opacity: progress,

        child: IgnorePointer(
          ignoring:
              progress < 0.2,

          child: child,
        ),
      ),
    );
  },

  child: HomeAppBar(
    onNotificationPressed: () {
      viewModel.onNotificationPressed(
        context,
      );
    },

    onProfilePressed:
        viewModel.onProfilePressed,
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
  height: AppSpacing.sm,
),

RecentDropLocation(
  location: viewModel.recentDropLocation,

  onTap: () {
    viewModel.onRecentDropPressed(
      context,
    );
  },
),

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

                      mainAxisExtent: 158,
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
                    height: 95,
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

                   // OFFER
                  const OfferBanner(),

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