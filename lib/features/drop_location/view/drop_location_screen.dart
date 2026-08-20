// import 'package:client_app/features/drop_location/view/model/address_summary_card.dart';
// import 'package:client_app/features/drop_location/view/model/reciever_details_sheet.dart';
// import 'package:client_app/features/drop_location/viewmodel/drop_location_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_spacing.dart';
// import '../../../../core/theme/app_text_styles.dart';


// class DropLocationScreen extends StatefulWidget {
//   const DropLocationScreen({
//     super.key,
//     required this.addressTitle,
//     required this.addressSubtitle,
//     this.initialPosition,
//   });

//   /// The address picked on the previous (Select Location) screen.
//   final String addressTitle;
//   final String addressSubtitle;
//   final LatLng? initialPosition;

//   @override
//   State<DropLocationScreen> createState() => _DropLocationScreenState();
// }

// class _DropLocationScreenState extends State<DropLocationScreen> {
//   late final DropLocationViewModel _viewModel;

//   @override
//   void initState() {
//     super.initState();
//     _viewModel = DropLocationViewModel(
//       addressTitle: widget.addressTitle,
//       addressSubtitle: widget.addressSubtitle,
//       initialPosition: widget.initialPosition,
//     );
//   }

//   @override
//   void dispose() {
//     _viewModel.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: ListenableBuilder(
//           listenable: _viewModel,
//           builder: (context, _) {
//             return Column(
//               children: [
//                 // =========================================
//                 // APP BAR
//                 // =========================================
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(
//                     AppSpacing.screenHorizontal,
//                     AppSpacing.lg,
//                     AppSpacing.screenHorizontal,
//                     AppSpacing.lg,
//                   ),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         padding: EdgeInsets.zero,
//                         onPressed: () => Navigator.of(context).maybePop(),
//                         icon: const Icon(
//                           Icons.arrow_back,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                       const SizedBox(width: AppSpacing.sm),
//                       Text('Drop Location', style: AppTextStyles.heading1),
//                     ],
//                   ),
//                 ),

//                 // =========================================
//                 // MAP + OVERLAYS
//                 // =========================================
//                 Expanded(
//                   flex: 6,
//                   child: _MapSection(viewModel: _viewModel),
//                 ),

//                 // =========================================
//                 // ADDRESS CARD + RECEIVER FORM
//                 // =========================================
//                 Transform.translate(
//                   offset: const Offset(0, -AppSpacing.lg),
//                   child: AddressSummaryCard(viewModel: _viewModel),
//                 ),
//                 Expanded(
//                   flex: 5,
//                   child: Transform.translate(
//                     offset: const Offset(0, -AppSpacing.lg),
//                     child: ReceiverDetailsSheet(viewModel: _viewModel),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // =====================================================================
// // MAP SECTION
// // =====================================================================

// class _MapSection extends StatelessWidget {
//   const _MapSection({required this.viewModel});

//   final DropLocationViewModel viewModel;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: const BorderRadius.vertical(
//         top: Radius.circular(AppSpacing.radiusLarge),
//       ),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           // Base map. Requires google_maps_flutter set up with an API key
//           // (Android/iOS) — see pubspec + platform config.
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: viewModel.pinPosition,
//               zoom: 15,
//             ),
//             onMapCreated: viewModel.onMapCreated,
//             onCameraMove: viewModel.onCameraMove,
//             onCameraIdle: viewModel.onCameraIdle,
//             myLocationButtonEnabled: false,
//             zoomControlsEnabled: false,
//             mapToolbarEnabled: false,
//           ),

//           // Search bar.
//           Positioned(
//             top: AppSpacing.md,
//             left: AppSpacing.lg,
//             right: AppSpacing.lg,
//             child: _SearchBar(viewModel: viewModel),
//           ),

//           // Fixed center pin + tooltip (the map moves under it).
//           Padding(
//             padding: const EdgeInsets.only(bottom: 36),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: AppSpacing.md,
//                     vertical: AppSpacing.sm,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppColors.textPrimary.withOpacity(0.85),
//                     borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
//                   ),
//                   child: Text(
//                     'Your goods will be dropped here',
//                     style: AppTextStyles.bodyMedium.copyWith(
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: AppSpacing.xs),
//                 Container(
//                   width: 44,
//                   height: 44,
//                   alignment: Alignment.center,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColors.primary,
//                   ),
//                   child: const Icon(
//                     Icons.location_on_rounded,
//                     color: AppColors.white,
//                     size: AppSpacing.iconMedium,
//                   ),
//                 ),
//                 Container(
//                   width: 8,
//                   height: 8,
//                   margin: const EdgeInsets.only(top: 2),
//                   decoration: BoxDecoration(
//                     color: AppColors.primary.withOpacity(0.35),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Locate-me button.
//           Positioned(
//             right: AppSpacing.lg,
//             bottom: AppSpacing.xxl,
//             child: _LocateMeButton(viewModel: viewModel),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SearchBar extends StatelessWidget {
//   const _SearchBar({required this.viewModel});

//   final DropLocationViewModel viewModel;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 2,
//       borderRadius: BorderRadius.circular(AppSpacing.radiusInput),
//       color: AppColors.surface,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(AppSpacing.radiusInput),
//         onTap: () => viewModel.onChangeAddressPressed(context),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: AppSpacing.lg,
//             vertical: AppSpacing.md,
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.search_rounded,
//                 size: AppSpacing.iconSmall,
//                 color: AppColors.textTertiary,
//               ),
//               const SizedBox(width: AppSpacing.sm),
//               Text('Search drop location', style: AppTextStyles.inputHint),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _LocateMeButton extends StatelessWidget {
//   const _LocateMeButton({required this.viewModel});

//   final DropLocationViewModel viewModel;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       shape: const CircleBorder(),
//       elevation: 3,
//       color: AppColors.surface,
//       child: InkWell(
//         customBorder: const CircleBorder(),
//         onTap: viewModel.onLocateMePressed,
//         child: Padding(
//           padding: const EdgeInsets.all(AppSpacing.md),
//           child: Icon(
//             Icons.my_location_rounded,
//             color: AppColors.primary,
//             size: AppSpacing.iconMedium,
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:client_app/features/drop_location/view/model/address_summary_card.dart';
import 'package:client_app/features/drop_location/view/model/reciever_details_sheet.dart';
import 'package:client_app/features/drop_location/viewmodel/drop_location_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class DropLocationScreen extends StatefulWidget {
  const DropLocationScreen({
    super.key,
    required this.addressTitle,
    required this.addressSubtitle,
  });

  final String addressTitle;
  final String addressSubtitle;

  @override
  State<DropLocationScreen> createState() => _DropLocationScreenState();
}

class _DropLocationScreenState extends State<DropLocationScreen> {
  late final DropLocationViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = DropLocationViewModel(
      addressTitle: widget.addressTitle,
      addressSubtitle: widget.addressSubtitle,
    );
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
          builder: (context, _) {
            return Column(
              children: [
                // =========================================
                // APP BAR
                // =========================================
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    AppSpacing.lg,
                    AppSpacing.screenHorizontal,
                    AppSpacing.lg,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Drop Location',
                        style: AppTextStyles.heading1,
                      ),
                    ],
                  ),
                ),

                // =========================================
                // DUMMY MAP
                // =========================================
                Expanded(
                  flex: 6,
                  child: _MapSection(
                    viewModel: _viewModel,
                  ),
                ),

                // =========================================
                // ADDRESS CARD
                // =========================================
                Transform.translate(
                  offset: const Offset(0, -AppSpacing.lg),
                  child: AddressSummaryCard(
                    viewModel: _viewModel,
                  ),
                ),

                // =========================================
                // RECEIVER DETAILS
                // =========================================
                Expanded(
                  flex: 5,
                  child: Transform.translate(
                    offset: const Offset(0, -AppSpacing.lg),
                    child: ReceiverDetailsSheet(
                      viewModel: _viewModel,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// =====================================================================
// DUMMY MAP SECTION
// =====================================================================

class _MapSection extends StatelessWidget {
  const _MapSection({
    required this.viewModel,
  });

  final DropLocationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppSpacing.radiusLarge),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // =========================================
          // DUMMY MAP BACKGROUND
          // =========================================
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFE8E5DF),
            child: CustomPaint(
              painter: _DummyMapPainter(),
            ),
          ),

          // =========================================
          // SEARCH BAR
          // =========================================
          Positioned(
            top: AppSpacing.md,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            child: _SearchBar(
              viewModel: viewModel,
            ),
          ),

          // =========================================
          // CENTER PIN
          // =========================================
          Padding(
            padding: const EdgeInsets.only(bottom: 36),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusMedium,
                    ),
                  ),
                  child: Text(
                    'Your goods will be dropped here',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xs),

                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: const Icon(
                    Icons.location_on_rounded,
                    color: AppColors.white,
                    size: AppSpacing.iconMedium,
                  ),
                ),

                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.35),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),

          // =========================================
          // LOCATE ME BUTTON
          // =========================================
          Positioned(
            right: AppSpacing.lg,
            bottom: AppSpacing.xxl,
            child: _LocateMeButton(
              viewModel: viewModel,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SEARCH BAR
// =====================================================================

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.viewModel,
  });

  final DropLocationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(
        AppSpacing.radiusInput,
      ),
      color: AppColors.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusInput,
        ),
        onTap: () {
          viewModel.onChangeAddressPressed(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search_rounded,
                size: AppSpacing.iconSmall,
                color: AppColors.textTertiary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Search drop location',
                style: AppTextStyles.inputHint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// LOCATE ME BUTTON
// =====================================================================

class _LocateMeButton extends StatelessWidget {
  const _LocateMeButton({
    required this.viewModel,
  });

  final DropLocationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      elevation: 3,
      color: AppColors.surface,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: viewModel.onLocateMePressed,
        child: const Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Icon(
            Icons.my_location_rounded,
            color: AppColors.primary,
            size: AppSpacing.iconMedium,
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// DUMMY MAP PAINTER
// =====================================================================

class _DummyMapPainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..color = Colors.white.withOpacity(0.9);

    // Main roads
    canvas.drawLine(
      Offset(0, size.height * 0.35),
      Offset(size.width, size.height * 0.58),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.2, 0),
      Offset(size.width * 0.65, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.75, 0),
      Offset(size.width * 0.35, size.height),
      paint,
    );

    final secondaryPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..color = Colors.white.withOpacity(0.75);

    // Secondary roads
    canvas.drawLine(
      Offset(0, size.height * 0.75),
      Offset(size.width, size.height * 0.25),
      secondaryPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.05, size.height * 0.1),
      Offset(size.width * 0.9, size.height * 0.9),
      secondaryPaint,
    );

    // Green areas
    final greenPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFD6E2C8);

    canvas.drawCircle(
      Offset(size.width * 0.18, size.height * 0.22),
      55,
      greenPaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.82, size.height * 0.72),
      70,
      greenPaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.68, size.height * 0.18),
      40,
      greenPaint,
    );

    // Small buildings / blocks
    final blockPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFD8D3CA);

    for (int i = 0; i < 12; i++) {
      final x = (i * 73.0) % size.width;
      final y = ((i * 117.0) % size.height);

      canvas.drawRect(
        Rect.fromLTWH(
          x,
          y,
          35,
          22,
        ),
        blockPaint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}