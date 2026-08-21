import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

import '../viewmodel/ride_rating_viewmodel.dart';

class RideRatingScreen extends StatefulWidget {
  const RideRatingScreen({
    super.key,
  });

  @override
  State<RideRatingScreen> createState() =>
      _RideRatingScreenState();
}

class _RideRatingScreenState
    extends State<RideRatingScreen> {
  late final RideRatingViewModel _viewModel;

  late final TextEditingController
      _commentController;

  @override
  void initState() {
    super.initState();

    _viewModel =
        RideRatingViewModel();

    _commentController =
        TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _viewModel.dispose();

    super.dispose();
  }

  // =========================================================
  // SCREEN
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      appBar: AppBar(
        backgroundColor:
            AppColors.background,

        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back_rounded,
            size:
                AppSpacing.iconMedium,
          ),
        ),

        title: Text(
          'Patgolito',
          style:
              AppTextStyles.homeAppName,
        ),

        centerTitle: true,
      ),

      body: ListenableBuilder(
        listenable: _viewModel,

        builder: (
          context,
          _,
        ) {
          return Column(
            children: [
              // =============================================
              // SCROLLABLE BODY
              // =============================================

              Expanded(
                child:
                    SingleChildScrollView(
                  physics:
                      const BouncingScrollPhysics(),

                  padding:
                      const EdgeInsets.fromLTRB(
                    AppSpacing
                        .screenHorizontal,
                    AppSpacing.xl,
                    AppSpacing
                        .screenHorizontal,
                    AppSpacing.xxl,
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .stretch,

                    children: [
                      // =====================================
                      // TITLE
                      // =====================================

                      Text(
                        'How was your\nexperience?',
                        style:
                            AppTextStyles.screenTitle,
                      ),

                      const SizedBox(
                        height:
                            AppSpacing.xxxl,
                      ),

                      // =====================================
                      // DRIVER CARD
                      // =====================================

                      _buildDriverCard(),

                      const SizedBox(
                        height:
                            AppSpacing.huge,
                      ),

                      // =====================================
                      // RATE LABEL
                      // =====================================

                      Text(
                        'RATE YOUR RIDE',

                        textAlign:
                            TextAlign.center,

                        style:
                            AppTextStyles.labelLarge,
                      ),

                      const SizedBox(
                        height:
                            AppSpacing.xl,
                      ),

                      // =====================================
                      // STARS
                      // =====================================

                      _buildRatingStars(),

                      const SizedBox(
                        height:
                            AppSpacing.huge,
                      ),

                      // =====================================
                      // FEEDBACK
                      // =====================================

                      Text(
                        'What went well?',
                        style:
                            AppTextStyles.heading3,
                      ),

                      const SizedBox(
                        height:
                            AppSpacing.lg,
                      ),

                      _buildFeedbackChips(),

                      const SizedBox(
                        height:
                            AppSpacing.xxxl,
                      ),

                      // =====================================
                      // COMMENT LABEL
                      // =====================================

                      Text(
                        'Additional Comments (Optional)',
                        style:
                            AppTextStyles.heading3,
                      ),

                      const SizedBox(
                        height:
                            AppSpacing.md,
                      ),

                      // =====================================
                      // COMMENT FIELD
                      // =====================================

                      _buildCommentField(),

                      const SizedBox(
                        height:
                            AppSpacing.huge,
                      ),
                    ],
                  ),
                ),
              ),

              // =============================================
              // SUBMIT
              // =============================================

              _buildBottomAction(),
            ],
          );
        },
      ),
    );
  }

  // =========================================================
  // DRIVER CARD
  // =========================================================

  Widget _buildDriverCard() {
    return Container(
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

        boxShadow: [
          BoxShadow(
            color:
                AppColors.black.withOpacity(
              AppColors.opacityShadow,
            ),

            blurRadius: 10,

            offset:
                const Offset(
              0,
              3,
            ),
          ),
        ],
      ),

      child: Row(
        children: [
          // =============================================
          // DRIVER PHOTO PLACEHOLDER
          // =============================================

          Container(
            width: 68,
            height: 68,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: AppColors.surface,

              border: Border.all(
                color:
                    AppColors.border,
              ),
            ),

            child: const Icon(
              Icons.person_rounded,

              color:
                  AppColors.textSecondary,

              size:
                  AppSpacing.iconLarge,
            ),
          ),

          const SizedBox(
            width: AppSpacing.lg,
          ),

          // =============================================
          // DRIVER INFO
          // =============================================

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  _viewModel.driverName,

                  style:
                      AppTextStyles.heading2,
                ),

                const SizedBox(
                  height: AppSpacing.sm,
                ),

                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size:
                          AppSpacing.iconSmall,
                    ),

                    const SizedBox(
                      width:
                          AppSpacing.xs,
                    ),

                    Text(
                      _viewModel
                          .driverRating,

                      style:
                          AppTextStyles.bodyMedium,
                    ),

                    const SizedBox(
                      width:
                          AppSpacing.sm,
                    ),

                    Text(
                      '•',
                      style:
                          AppTextStyles.bodyMedium,
                    ),

                    const SizedBox(
                      width:
                          AppSpacing.sm,
                    ),

                    Text(
                      _viewModel.driverRole,

                      style:
                          AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // RATING STARS
  // =========================================================

  Widget _buildRatingStars() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center,

      children: List.generate(
        5,

        (index) {
          final starValue =
              index + 1;

          final selected =
              starValue <=
                  _viewModel.rating;

          return IconButton(
            onPressed: () {
              _viewModel.setRating(
                starValue,
              );
            },

            padding:
                const EdgeInsets.all(
              AppSpacing.sm,
            ),

            icon: Icon(
              selected
                  ? Icons.star_rounded
                  : Icons
                      .star_border_rounded,

              color: selected
                  ? AppColors.primary
                  : AppColors
                      .textTertiary,

              size:
                  AppSpacing.iconLarge,
            ),
          );
        },
      ),
    );
  }

  // =========================================================
  // FEEDBACK CHIPS
  // =========================================================

  Widget _buildFeedbackChips() {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,

      children:
          _viewModel.feedbackOptions
              .map(
        (
          feedback,
        ) {
          final selected =
              _viewModel
                  .isFeedbackSelected(
            feedback,
          );

          return InkWell(
            onTap: () {
              _viewModel
                  .toggleFeedback(
                feedback,
              );
            },

            borderRadius:
                BorderRadius.circular(
              AppSpacing
                  .radiusCircular,
            ),

            child:
                AnimatedContainer(
              duration:
                  const Duration(
                milliseconds: 180,
              ),

              padding:
                  const EdgeInsets.symmetric(
                horizontal:
                    AppSpacing.xl,
                vertical:
                    AppSpacing.md,
              ),

              decoration:
                  BoxDecoration(
                color: selected
                    ? AppColors.primary
                    : AppColors.white,

                borderRadius:
                    BorderRadius.circular(
                  AppSpacing
                      .radiusCircular,
                ),

                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : AppColors.border,
                ),
              ),

              child: Text(
                feedback,

                style:
                    AppTextStyles.bodyMedium
                        .copyWith(
                  color: selected
                      ? AppColors.white
                      : AppColors
                          .textPrimary,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  // =========================================================
  // COMMENT
  // =========================================================

  Widget _buildCommentField() {
    return TextField(
      controller:
          _commentController,

      minLines: 5,
      maxLines: 7,

      textInputAction:
          TextInputAction.newline,

      onChanged:
          _viewModel.setComment,

      style:
          AppTextStyles.bodyLarge,

      decoration: InputDecoration(
        hintText:
            'Tell us about your experience...',

        hintStyle:
            AppTextStyles.inputHint,

        filled: true,

        fillColor:
            AppColors.white,

        contentPadding:
            const EdgeInsets.all(
          AppSpacing.xl,
        ),

        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusCard,
          ),

          borderSide:
              const BorderSide(
            color: AppColors.border,
          ),
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusCard,
          ),

          borderSide:
              const BorderSide(
            color: AppColors.border,
          ),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusCard,
          ),

          borderSide:
              const BorderSide(
            color:
                AppColors.primary,

            width:
                AppSpacing.borderMedium,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // BOTTOM ACTION
  // =========================================================

  Widget _buildBottomAction() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
        AppSpacing.screenHorizontal,
        AppSpacing.xl,
      ),

      decoration: BoxDecoration(
        color:
            AppColors.background,

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

      child: SafeArea(
        top: false,

        child: SizedBox(
          width: double.infinity,
          height:
              AppSpacing.buttonHeight,

          child: ElevatedButton(
            onPressed:
                _viewModel.isSubmitting
                    ? null
                    : () {
                        _viewModel
                            .submitReview(
                          context,
                        );
                      },

            child:
                _viewModel.isSubmitting
                    ? const SizedBox(
                        width:
                            AppSpacing
                                .iconSmall,
                        height:
                            AppSpacing
                                .iconSmall,

                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                          color:
                              AppColors.white,
                        ),
                      )
                    : Text(
                        'Submit Review',
                        style:
                            AppTextStyles
                                .buttonText,
                      ),
          ),
        ),
      ),
    );
  }
}