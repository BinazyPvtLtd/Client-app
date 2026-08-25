// import 'package:flutter/material.dart';

// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_spacing.dart';

// class LocationSearchCard extends StatelessWidget {
//   final VoidCallback onTap;

//   const LocationSearchCard({
//     super.key,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: AppColors.white,
//       borderRadius: BorderRadius.circular(
//         AppSpacing.radiusExtraLarge,
//       ),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(
//           AppSpacing.radiusExtraLarge,
//         ),
//         child: Container(
//           height: 82,
//           padding: const EdgeInsets.symmetric(
//             horizontal: AppSpacing.xl,
//           ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(
//               AppSpacing.radiusExtraLarge,
//             ),
//             border: Border.all(
//               color: AppColors.border,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.black.withValues(
//                   alpha: AppColors.opacityShadow,
//                 ),
//                 blurRadius: 16,
//                 offset: const Offset(0, 6),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               const Icon(
//                 Icons.search_rounded,
//                 size: 34,
//                 color: AppColors.black,
//               ),

//               const SizedBox(width: AppSpacing.lg),

//               Expanded(
//                 child: Text(
//                   'Where do you want to send?',
//                   style: Theme.of(context)
//                       .textTheme
//                       .headlineSmall
//                       ?.copyWith(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 20,
//                       ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class LocationSearchCard
    extends StatelessWidget {
  final VoidCallback onTap;

  const LocationSearchCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          AppColors.transparent,

      child: InkWell(
        onTap: onTap,

        // Exactly half of 58 = pill
        borderRadius:
            BorderRadius.circular(
          29,
        ),

        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(
            29,
          ),

          child: Container(
            width:
                double.infinity,

            height: 58,

            padding:
                const EdgeInsets.symmetric(
              horizontal:
                  AppSpacing.lg,
            ),

            decoration:
                BoxDecoration(
              color:
                  AppColors.white,

              borderRadius:
                  BorderRadius.circular(
                29,
              ),

              border:
                  Border.all(
                color:
                    AppColors.primary
                        .withValues(
                  alpha: 0.28,
                ),

                width: 1.2,
              ),
            ),

            child: Row(
              children: [
                // =====================================
                // SEARCH ICON
                // =====================================

                const Icon(
                  Icons
                      .search_rounded,

                  size: 23,

                  color:
                      AppColors
                          .textSecondary,
                ),

                const SizedBox(
                  width:
                      AppSpacing.md,
                ),

                // =====================================
                // TEXT
                // =====================================

                Expanded(
                  child: Text(
                    'Where do you want to send?',

                    maxLines: 1,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        AppTextStyles
                            .bodyLarge
                            .copyWith(
                      color:
                          AppColors
                              .textSecondary,
                    ),
                  ),
                ),

                const SizedBox(
                  width:
                      AppSpacing.sm,
                ),

                // =====================================
                // LOCATION
                // =====================================

                const Icon(
                  Icons
                      .my_location_rounded,

                  size: 20,

                  color:
                      AppColors
                          .textPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}