// import 'package:client_app/core/theme/app_colors.dart';
// import 'package:client_app/core/theme/app_spacing.dart';
// import 'package:client_app/core/theme/app_typography.dart';
// import 'package:client_app/features/goods_details/view/goods_details_screen.dart';
// import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';
// import 'package:client_app/features/select_vehicle/viewmodel/select_vehicle_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SelectVehicleScreen extends StatelessWidget {
//   final String pickupAddress;
//   final String dropAddress;
//   final String dropAddressSubtitle;
//   final String receiverName;
//   final String receiverPhone;
//   final String houseNumber;

//   const SelectVehicleScreen({
//     super.key,
//     required this.pickupAddress,
//     required this.dropAddress,
//     required this.dropAddressSubtitle,
//     required this.receiverName,
//     required this.receiverPhone,
//     required this.houseNumber,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//   create: (_) => SelectVehicleViewModel(
//     onProceed: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => const GoodsDetailsScreen(),
//         ),
//       );
//     },
//   ),
//   child: _SelectVehicleView(
//     pickupAddress: pickupAddress,
//     dropAddress: dropAddress,
//     dropAddressSubtitle: dropAddressSubtitle,
//   ),
// );
//   }
// }

// // =====================================================================
// // MAIN VIEW
// // =====================================================================

// class _SelectVehicleView extends StatelessWidget {
//   final String pickupAddress;
//   final String dropAddress;
//   final String dropAddressSubtitle;

//   const _SelectVehicleView({
//     required this.pickupAddress,
//     required this.dropAddress,
//     required this.dropAddressSubtitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,

//       appBar: _buildAppBar(context),

//       body: SafeArea(
//         child: Stack(
//           children: [
//             // =========================================================
//             // SCROLLABLE CONTENT
//             // =========================================================

//             SingleChildScrollView(
//               padding: const EdgeInsets.only(
//                 left: AppSpacing.lg,
//                 right: AppSpacing.lg,
//                 top: AppSpacing.sm,
//                 bottom: 125,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // ===================================================
//                   // LOCATION CARD
//                   // ===================================================

//                   _buildLocationCard(context),

//                   const SizedBox(height: 22),

//                   // ===================================================
//                   // AVAILABLE VEHICLES
//                   // ===================================================

//                   Text(
//                     'Available Vehicles',
//                     style: TextStyle(
//                       fontSize: AppTypography.xxlScaled,
//                       fontWeight: AppTypography.medium,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   // ===================================================
//                   // VEHICLE LIST
//                   // ===================================================

//                   _buildVehicleList(context),
//                 ],
//               ),
//             ),

//             // =========================================================
//             // BOTTOM BUTTON
//             // =========================================================

//             _buildBottomButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   // ===================================================================
//   // APP BAR
//   // ===================================================================

//   PreferredSizeWidget _buildAppBar(
//     BuildContext context,
//   ) {
//     return AppBar(
//       backgroundColor: AppColors.background,
//       elevation: 0,
//       automaticallyImplyLeading: false,
//       toolbarHeight: 70,
//       titleSpacing: 0,

//       title: Row(
//         children: [
//           // -----------------------------------------------------------
//           // BACK
//           // -----------------------------------------------------------

//           IconButton(
//             onPressed: () {
//               Navigator.of(context).maybePop();
//             },
//             padding: const EdgeInsets.only(left: 16),
//             icon: const Icon(
//               Icons.arrow_back,
//               size: 30,
//               color: AppColors.textSecondary,
//             ),
//           ),

//           // -----------------------------------------------------------
//           // TITLE
//           // -----------------------------------------------------------

//           const Spacer(),

//           Text(
//             'Select Vehicle',
//             style: TextStyle(
//               fontSize: AppTypography.xxlScaled,
//               fontWeight: AppTypography.medium,
//               color: AppColors.primaryDark,
//             ),
//           ),

//           const Spacer(),

//           // -----------------------------------------------------------
//           // PROFILE
//           // -----------------------------------------------------------

//           Padding(
//             padding: const EdgeInsets.only(right: 18),
//             child: Container(
//               width: 42,
//               height: 42,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: AppColors.textSecondary,
//               ),
//               child: const Icon(
//                 Icons.person,
//                 size: 27,
//                 color: AppColors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ===================================================================
//   // LOCATION CARD
//   // ===================================================================

//   Widget _buildLocationCard(
//     BuildContext context,
//   ) {
//     return Container(
//       width: double.infinity,

//       padding: const EdgeInsets.fromLTRB(
//         18,
//         18,
//         18,
//         0,
//       ),

//       decoration: BoxDecoration(
//         color: AppColors.surface,

//         borderRadius: BorderRadius.circular(
//           AppSpacing.radiusExtraLarge,
//         ),

//         border: Border.all(
//           color: AppColors.border,
//           width: 1.3,
//         ),

//         boxShadow: [
//           BoxShadow(
//             color: AppColors.black.withOpacity(
//               AppColors.opacityShadow,
//             ),
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),

//       child: Column(
//         children: [
//           // ===========================================================
//           // PICKUP
//           // ===========================================================

//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildLocationDot(
//                 AppColors.primaryDark,
//               ),

//               const SizedBox(width: 14),

//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Pickup',
//                       style: TextStyle(
//                         fontSize: AppTypography.lgScaled,
//                         color: AppColors.textSecondary,
//                         fontWeight: AppTypography.regular,
//                       ),
//                     ),

//                     const SizedBox(height: 3),

//                     Text(
//                       pickupAddress,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: AppTypography.lgScaled,
//                         color: AppColors.textPrimary,
//                         fontWeight: AppTypography.regular,
//                         height: 1.25,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           // ===========================================================
//           // LOCATION LINE
//           // ===========================================================

//           Padding(
//             padding: const EdgeInsets.only(
//               left: 6,
//             ),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Container(
//                 width: 2,
//                 height: 34,
//                 color: AppColors.border,
//               ),
//             ),
//           ),

//           // ===========================================================
//           // DROP
//           // ===========================================================

//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildLocationDot(
//                 AppColors.textSecondary,
//               ),

//               const SizedBox(width: 14),

//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Drop',
//                       style: TextStyle(
//                         fontSize: AppTypography.lgScaled,
//                         color: AppColors.textSecondary,
//                         fontWeight: AppTypography.regular,
//                       ),
//                     ),

//                     const SizedBox(height: 3),

//                     Text(
//                       dropAddress,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: AppTypography.lgScaled,
//                         color: AppColors.textPrimary,
//                         fontWeight: AppTypography.regular,
//                         height: 1.25,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 16),

//           // ===========================================================
//           // DIVIDER
//           // ===========================================================

//           const Divider(
//             height: 1,
//             color: AppColors.border,
//           ),

//           // ===========================================================
//           // DISTANCE / TIME / ACTIONS
//           // ===========================================================

//           SizedBox(
//             height: 54,
//             child: Row(
//               children: [
//                 const SizedBox(width: 20),

//                 Text(
//                   '8.4 km',
//                   style: TextStyle(
//                     fontSize: AppTypography.mdScaled,
//                     fontWeight: AppTypography.semiBold,
//                     color: AppColors.textSecondary,
//                   ),
//                 ),

//                 const SizedBox(width: 20),

//                 const Icon(
//                   Icons.access_time_outlined,
//                   size: 22,
//                   color: AppColors.textSecondary,
//                 ),

//                 const SizedBox(width: 5),

//                 Text(
//                   '32 mins',
//                   style: TextStyle(
//                     fontSize: AppTypography.mdScaled,
//                     fontWeight: AppTypography.semiBold,
//                     color: AppColors.textSecondary,
//                   ),
//                 ),

//                 const Spacer(),

//                 // -----------------------------------------------------
//                 // ADD STOP
//                 // -----------------------------------------------------

//                 GestureDetector(
//                   onTap: () {
//                     context
//                         .read<SelectVehicleViewModel>()
//                         .addStop();
//                   },
//                   child: Text(
//                     'Add Stop',
//                     style: TextStyle(
//                       fontSize: AppTypography.mdScaled,
//                       fontWeight: AppTypography.bold,
//                       color: AppColors.primaryDark,
//                     ),
//                   ),
//                 ),

//                 const Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 8,
//                   ),
//                   child: Text(
//                     '|',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: AppColors.border,
//                     ),
//                   ),
//                 ),

//                 // -----------------------------------------------------
//                 // EDIT
//                 // -----------------------------------------------------

//                 GestureDetector(
//                   onTap: () {
//                     context
//                         .read<SelectVehicleViewModel>()
//                         .editLocation();
//                   },
//                   child: Text(
//                     'Edit',
//                     style: TextStyle(
//                       fontSize: AppTypography.mdScaled,
//                       fontWeight: AppTypography.bold,
//                       color: AppColors.primaryDark,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 4),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ===================================================================
//   // LOCATION DOT
//   // ===================================================================

//   Widget _buildLocationDot(
//     Color color,
//   ) {
//     return Container(
//       margin: const EdgeInsets.only(
//         top: 6,
//       ),
//       width: 13,
//       height: 13,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: color,
//       ),
//     );
//   }

//   // ===================================================================
//   // VEHICLE LIST
//   // ===================================================================

//   Widget _buildVehicleList(
//     BuildContext context,
//   ) {
//     final viewModel =
//         context.watch<SelectVehicleViewModel>();

//     return Column(
//       children: List.generate(
//         viewModel.vehicles.length,
//         (index) {
//           final vehicle = viewModel.vehicles[index];

//           return Padding(
//             padding: const EdgeInsets.only(
//               bottom: 12,
//             ),
//             child: _buildVehicleCard(
//               context,
//               vehicle,
//               index,
//               viewModel.selectedVehicleIndex == index,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // ===================================================================
//   // VEHICLE CARD
//   // ===================================================================

//   Widget _buildVehicleCard(
//     BuildContext context,
//     VehicleModel vehicle,
//     int index,
//     bool isSelected,
//   ) {
//     return GestureDetector(
//       onTap: () {
//         context
//             .read<SelectVehicleViewModel>()
//             .selectVehicle(index);
//       },

//       child: AnimatedContainer(
//         duration: const Duration(
//           milliseconds: 200,
//         ),

//         // -------------------------------------------------------------
//         // SMALLER CARD
//         // -------------------------------------------------------------

//         height: 120,

//         padding: const EdgeInsets.all(10),

//         decoration: BoxDecoration(
//           color: isSelected
//               ? AppColors.primary.withOpacity(0.18)
//               : AppColors.surface,

//           borderRadius: BorderRadius.circular(
//             AppSpacing.radiusLarge,
//           ),

//           border: Border.all(
//             color: isSelected
//                 ? AppColors.primary
//                 : AppColors.border,
//             width: isSelected ? 2.5 : 1.3,
//           ),
//         ),

//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // =========================================================
//             // IMAGE
//             // =========================================================

//             _buildVehicleImage(
//               vehicle.image,
//               isSelected,
//             ),

//             const SizedBox(width: 10),

//             // =========================================================
//             // DETAILS
//             // =========================================================

//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 4),

//                   // ---------------------------------------------------
//                   // NAME
//                   // ---------------------------------------------------

//                   Text(
//                     vehicle.name,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: AppTypography.xlScaled,
//                       fontWeight: AppTypography.medium,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),

//                   const SizedBox(height: 7),

//                   // ---------------------------------------------------
//                   // WEIGHT
//                   // ---------------------------------------------------

//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 20,
//                     ),
//                     child: Text(
//                       vehicle.maxWeight,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: AppTypography.mdScaled,
//                         fontWeight: AppTypography.regular,
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                   ),

//                   const Spacer(),

//                   // ---------------------------------------------------
//                   // ARRIVAL
//                   // ---------------------------------------------------

//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.bolt,
//                         size: 18,
//                         color: AppColors.primaryDark,
//                       ),

//                       const SizedBox(width: 2),

//                       Flexible(
//                         child: Text(
//                           vehicle.arriving,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: AppTypography.smScaled,
//                             fontWeight: AppTypography.semiBold,
//                             color: AppColors.primaryDark,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // =========================================================
//             // PRICE / OFFER
//             // =========================================================

//             SizedBox(
//               width: 75,

//               child: Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   // ---------------------------------------------------
//                   // PRICE
//                   // ---------------------------------------------------

//                   Positioned(
//                     right: 0,
//                     bottom: 8,
//                     child: Text(
//                       vehicle.price,
//                       style: TextStyle(
//                         fontSize: AppTypography.xlScaled,
//                         fontWeight: AppTypography.regular,
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
//                   ),

//                   // ---------------------------------------------------
//                   // OFFER
//                   // ---------------------------------------------------

//                   if (isSelected &&
//                       vehicle.offer != null)
//                     Positioned(
//                       right: 14,
//                       top: 0,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 9,
//                           vertical: 5,
//                         ),

//                         decoration: BoxDecoration(
//                           color: AppColors.primaryDark,
//                           borderRadius: BorderRadius.circular(
//                             20,
//                           ),
//                         ),

//                         child: Text(
//                           vehicle.offer!,
//                           style: TextStyle(
//                             fontSize: AppTypography.smScaled,
//                             fontWeight: AppTypography.bold,
//                             color: AppColors.white,
//                           ),
//                         ),
//                       ),
//                     ),

//                   // ---------------------------------------------------
//                   // CHECK
//                   // ---------------------------------------------------

//                   if (isSelected)
//                     Positioned(
//                       right: -3,
//                       top: -3,
//                       child: Container(
//                         width: 29,
//                         height: 29,

//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: AppColors.primaryDark,
//                         ),

//                         child: const Icon(
//                           Icons.check,
//                           size: 18,
//                           color: AppColors.white,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ===================================================================
//   // VEHICLE IMAGE
//   // ===================================================================

//   Widget _buildVehicleImage(
//     String imagePath,
//     bool isSelected,
//   ) {
//     return Container(
//       width: 122,
//       height: 108,

//       decoration: BoxDecoration(
//         color: isSelected
//             ? AppColors.white
//             : AppColors.background,

//         borderRadius: BorderRadius.circular(
//           AppSpacing.radiusMedium,
//         ),
//       ),

//       alignment: Alignment.center,

//       child: Image.asset(
//         imagePath,

//         width: 100,
//         height: 100,

//         fit: BoxFit.contain,

//         errorBuilder: (
//           context,
//           error,
//           stackTrace,
//         ) {
//           return Icon(
//             Icons.local_shipping_outlined,
//             size: 40,
//             color: AppColors.textTertiary,
//           );
//         },
//       ),
//     );
//   }

//   // ===================================================================
//   // BOTTOM BUTTON
//   // ===================================================================

//   Widget _buildBottomButton(
//     BuildContext context,
//   ) {
//     final selectedVehicle =
//         context.select<
//             SelectVehicleViewModel,
//             VehicleModel>(
//       (viewModel) => viewModel.selectedVehicle,
//     );

//     return Positioned(
//       left: 0,
//       right: 0,
//       bottom: 0,

//       child: Container(
//         padding: const EdgeInsets.fromLTRB(
//           24,
//           20,
//           24,
//           22,
//         ),

//         decoration: BoxDecoration(
//           color: AppColors.surface,

//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(22),
//             topRight: Radius.circular(22),
//           ),

//           boxShadow: [
//             BoxShadow(
//               color: AppColors.black.withOpacity(
//                 0.08,
//               ),
//               blurRadius: 18,
//               offset: const Offset(0, -4),
//             ),
//           ],
//         ),

//         child: SizedBox(
//           height: 64,

//           child: ElevatedButton(
//             onPressed: () {
//               context
//                   .read<SelectVehicleViewModel>()
//                   .proceedWithVehicle();
//             },

//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primaryDark,
//               foregroundColor: AppColors.white,
//               elevation: 0,

//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(
//                   AppSpacing.radiusButton,
//                 ),
//               ),
//             ),

//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Flexible(
//                   child: Text(
//                     'Proceed With ${selectedVehicle.name}',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,

//                     style: TextStyle(
//                       fontSize: AppTypography.lgScaled,
//                       fontWeight: AppTypography.regular,
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 const Icon(
//                   Icons.arrow_forward,
//                   size: 30,
//                   color: AppColors.white,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:client_app/core/theme/app_colors.dart';
import 'package:client_app/core/theme/app_spacing.dart';
import 'package:client_app/core/theme/app_typography.dart';
import 'package:client_app/features/goods_details/view/goods_details_screen.dart';
import 'package:client_app/features/select_vehicle/view/model/vehicle_model.dart';
import 'package:client_app/features/select_vehicle/viewmodel/select_vehicle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectVehicleScreen extends StatelessWidget {
  final String pickupAddress;
  final String dropAddress;
  final String dropAddressSubtitle;
  final String receiverName;
  final String receiverPhone;
  final String houseNumber;

  const SelectVehicleScreen({
    super.key,
    required this.pickupAddress,
    required this.dropAddress,
    required this.dropAddressSubtitle,
    required this.receiverName,
    required this.receiverPhone,
    required this.houseNumber,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectVehicleViewModel(
        onProceed: (selectedVehicle) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GoodsDetailsScreen(
                selectedVehicle: selectedVehicle,
              ),
            ),
          );
        },
      ),
      child: _SelectVehicleView(
        pickupAddress: pickupAddress,
        dropAddress: dropAddress,
        dropAddressSubtitle: dropAddressSubtitle,
      ),
    );
  }
}

// =====================================================================
// MAIN VIEW
// =====================================================================

class _SelectVehicleView extends StatelessWidget {
  final String pickupAddress;
  final String dropAddress;
  final String dropAddressSubtitle;

  const _SelectVehicleView({
    required this.pickupAddress,
    required this.dropAddress,
    required this.dropAddressSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: _buildAppBar(context),

      body: SafeArea(
        child: Stack(
          children: [
            // =========================================================
            // SCROLLABLE CONTENT
            // =========================================================

            SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                top: AppSpacing.sm,
                bottom: 125,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===================================================
                  // LOCATION CARD
                  // ===================================================

                  _buildLocationCard(context),

                  const SizedBox(height: 22),

                  // ===================================================
                  // AVAILABLE VEHICLES
                  // ===================================================

                  Text(
                    'Available Vehicles',
                    style: TextStyle(
                      fontSize: AppTypography.xxlScaled,
                      fontWeight: AppTypography.medium,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ===================================================
                  // VEHICLE LIST
                  // ===================================================

                  _buildVehicleList(context),
                ],
              ),
            ),

            // =========================================================
            // BOTTOM BUTTON
            // =========================================================

            _buildBottomButton(context),
          ],
        ),
      ),
    );
  }

  // ===================================================================
  // APP BAR
  // ===================================================================

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
  ) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 70,
      titleSpacing: 0,
      title: Row(
        children: [
          // -----------------------------------------------------------
          // BACK
          // -----------------------------------------------------------

          IconButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            padding: const EdgeInsets.only(left: 16),
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: AppColors.textSecondary,
            ),
          ),

          // -----------------------------------------------------------
          // TITLE
          // -----------------------------------------------------------

          const Spacer(),

          Text(
            'Select Vehicle',
            style: TextStyle(
              fontSize: AppTypography.xxlScaled,
              fontWeight: AppTypography.medium,
              color: AppColors.primaryDark,
            ),
          ),

          const Spacer(),

          // -----------------------------------------------------------
          // PROFILE
          // -----------------------------------------------------------

          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.textSecondary,
              ),
              child: const Icon(
                Icons.person,
                size: 27,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===================================================================
  // LOCATION CARD
  // ===================================================================

  Widget _buildLocationCard(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        18,
        18,
        0,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusExtraLarge,
        ),
        border: Border.all(
          color: AppColors.border,
          width: 1.3,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(
              AppColors.opacityShadow,
            ),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ===========================================================
          // PICKUP
          // ===========================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLocationDot(
                AppColors.primaryDark,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pickup',
                      style: TextStyle(
                        fontSize: AppTypography.lgScaled,
                        color: AppColors.textSecondary,
                        fontWeight: AppTypography.regular,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      pickupAddress,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppTypography.lgScaled,
                        color: AppColors.textPrimary,
                        fontWeight: AppTypography.regular,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ===========================================================
          // LOCATION LINE
          // ===========================================================

          Padding(
            padding: const EdgeInsets.only(
              left: 6,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 2,
                height: 34,
                color: AppColors.border,
              ),
            ),
          ),

          // ===========================================================
          // DROP
          // ===========================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLocationDot(
                AppColors.textSecondary,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Drop',
                      style: TextStyle(
                        fontSize: AppTypography.lgScaled,
                        color: AppColors.textSecondary,
                        fontWeight: AppTypography.regular,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      dropAddress,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppTypography.lgScaled,
                        color: AppColors.textPrimary,
                        fontWeight: AppTypography.regular,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ===========================================================
          // DIVIDER
          // ===========================================================

          const Divider(
            height: 1,
            color: AppColors.border,
          ),

          // ===========================================================
          // DISTANCE / TIME / ACTIONS
          // ===========================================================

          SizedBox(
            height: 54,
            child: Row(
              children: [
                const SizedBox(width: 20),

                Text(
                  '8.4 km',
                  style: TextStyle(
                    fontSize: AppTypography.mdScaled,
                    fontWeight: AppTypography.semiBold,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(width: 20),

                const Icon(
                  Icons.access_time_outlined,
                  size: 22,
                  color: AppColors.textSecondary,
                ),

                const SizedBox(width: 5),

                Text(
                  '32 mins',
                  style: TextStyle(
                    fontSize: AppTypography.mdScaled,
                    fontWeight: AppTypography.semiBold,
                    color: AppColors.textSecondary,
                  ),
                ),

                const Spacer(),

                // -----------------------------------------------------
                // ADD STOP
                // -----------------------------------------------------

                GestureDetector(
                  onTap: () {
                    context
                        .read<SelectVehicleViewModel>()
                        .addStop();
                  },
                  child: Text(
                    'Add Stop',
                    style: TextStyle(
                      fontSize: AppTypography.mdScaled,
                      fontWeight: AppTypography.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Text(
                    '|',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.border,
                    ),
                  ),
                ),

                // -----------------------------------------------------
                // EDIT
                // -----------------------------------------------------

                GestureDetector(
                  onTap: () {
                    context
                        .read<SelectVehicleViewModel>()
                        .editLocation();
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: AppTypography.mdScaled,
                      fontWeight: AppTypography.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),

                const SizedBox(width: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===================================================================
  // LOCATION DOT
  // ===================================================================

  Widget _buildLocationDot(
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        top: 6,
      ),
      width: 13,
      height: 13,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  // ===================================================================
  // VEHICLE LIST
  // ===================================================================

  Widget _buildVehicleList(
    BuildContext context,
  ) {
    final viewModel =
        context.watch<SelectVehicleViewModel>();

    return Column(
      children: List.generate(
        viewModel.vehicles.length,
        (index) {
          final vehicle =
              viewModel.vehicles[index];

          return Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
            ),
            child: _buildVehicleCard(
              context,
              vehicle,
              index,
              viewModel.selectedVehicleIndex ==
                  index,
            ),
          );
        },
      ),
    );
  }

  // ===================================================================
  // VEHICLE CARD
  // ===================================================================

  Widget _buildVehicleCard(
    BuildContext context,
    VehicleModel vehicle,
    int index,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        context
            .read<SelectVehicleViewModel>()
            .selectVehicle(index);
      },
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 200,
        ),
        height: 120,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.18)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusLarge,
          ),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.border,
            width: isSelected ? 2.5 : 1.3,
          ),
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
          children: [
            // =========================================================
            // IMAGE
            // =========================================================

            _buildVehicleImage(
              vehicle.image,
              isSelected,
            ),

            const SizedBox(width: 10),

            // =========================================================
            // DETAILS
            // =========================================================

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),

                  Text(
                    vehicle.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppTypography.xlScaled,
                      fontWeight: AppTypography.medium,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      vehicle.maxWeight,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppTypography.mdScaled,
                        fontWeight: AppTypography.regular,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      const Icon(
                        Icons.bolt,
                        size: 18,
                        color: AppColors.primaryDark,
                      ),

                      const SizedBox(width: 2),

                      Flexible(
                        child: Text(
                          vehicle.arriving,
                          maxLines: 1,
                          overflow:
                              TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize:
                                AppTypography.smScaled,
                            fontWeight:
                                AppTypography.semiBold,
                            color:
                                AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // =========================================================
            // PRICE / OFFER
            // =========================================================

            SizedBox(
              width: 75,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // ---------------------------------------------------
                  // PRICE
                  // ---------------------------------------------------

                  Positioned(
                    right: 0,
                    bottom: 8,
                    child: Text(
                      vehicle.price,
                      style: TextStyle(
                        fontSize:
                            AppTypography.xlScaled,
                        fontWeight:
                            AppTypography.regular,
                        color:
                            AppColors.textPrimary,
                      ),
                    ),
                  ),

                  // ---------------------------------------------------
                  // OFFER
                  // ---------------------------------------------------

                  if (isSelected &&
                      vehicle.offer != null)
                    Positioned(
                      right: 14,
                      top: 0,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              AppColors.primaryDark,
                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Text(
                          vehicle.offer!,
                          style: TextStyle(
                            fontSize:
                                AppTypography.smScaled,
                            fontWeight:
                                AppTypography.bold,
                            color:
                                AppColors.white,
                          ),
                        ),
                      ),
                    ),

                  // ---------------------------------------------------
                  // CHECK
                  // ---------------------------------------------------

                  if (isSelected)
                    Positioned(
                      right: -3,
                      top: -3,
                      child: Container(
                        width: 29,
                        height: 29,
                        decoration:
                            const BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              AppColors.primaryDark,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 18,
                          color:
                              AppColors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===================================================================
  // VEHICLE IMAGE
  // ===================================================================

  Widget _buildVehicleImage(
    String imagePath,
    bool isSelected,
  ) {
    return Container(
      width: 122,
      height: 108,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.white
            : AppColors.background,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusMedium,
        ),
      ),
      alignment: Alignment.center,
      child: Image.asset(
        imagePath,
        width: 100,
        height: 100,
        fit: BoxFit.contain,
        errorBuilder: (
          context,
          error,
          stackTrace,
        ) {
          return Icon(
            Icons.local_shipping_outlined,
            size: 40,
            color: AppColors.textTertiary,
          );
        },
      ),
    );
  }

  // ===================================================================
  // BOTTOM BUTTON
  // ===================================================================

  Widget _buildBottomButton(
    BuildContext context,
  ) {
    final selectedVehicle =
        context.select<
            SelectVehicleViewModel,
            VehicleModel>(
      (viewModel) => viewModel.selectedVehicle,
    );

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          24,
          20,
          24,
          22,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius:
              const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(
                0.08,
              ),
              blurRadius: 18,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SizedBox(
          height: 64,
          child: ElevatedButton(
            onPressed: () {
              context
                  .read<SelectVehicleViewModel>()
                  .proceedWithVehicle();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  AppColors.primaryDark,
              foregroundColor:
                  AppColors.white,
              elevation: 0,
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  AppSpacing.radiusButton,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'Proceed With ${selectedVehicle.name}',
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize:
                          AppTypography.lgScaled,
                      fontWeight:
                          AppTypography.regular,
                      color:
                          AppColors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                const Icon(
                  Icons.arrow_forward,
                  size: 30,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}