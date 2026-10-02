import 'package:client_app/core/theme/app_colors.dart';
import 'package:client_app/core/theme/app_spacing.dart';
import 'package:client_app/core/theme/app_text_styles.dart';
import 'package:client_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import '../model/support_category_model.dart';
import '../viewmodel/help_support_viewmodel.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({
    super.key,
  });


  @override
  State<HelpSupportScreen> createState() =>
      _HelpSupportScreenState();
}

class _HelpSupportScreenState
    extends State<HelpSupportScreen> {
  late final HelpSupportViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel =
        HelpSupportViewModel();
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
            color:
                AppColors.textPrimary,
            size:
                AppSpacing.iconMedium,
          ),
        ),

        title: Text(
          'Help & Support',
          style:
              AppTextStyles.screenTitle,
        ),

        centerTitle: false,
      ),

      body: SafeArea(
        top: false,
        child: ListenableBuilder(
          listenable: _viewModel,

          builder: (
            context,
            _,
          ) {
            return SingleChildScrollView(
              physics:
                  const BouncingScrollPhysics(),

              padding:
                  const EdgeInsets.fromLTRB(
                AppSpacing
                    .screenHorizontal,
                AppSpacing.xxl,
                AppSpacing
                    .screenHorizontal,
                AppSpacing.xxxl,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  

                  _buildSearchField(),

                  const SizedBox(
                    height:
                        AppSpacing.xxxl,
                  ),

                  

                  Text(
                    'Categories',

                    style:
                        AppTextStyles.heading1
                            .copyWith(
                      fontWeight:
                          AppTypography.bold,
                    ),
                  ),

                  const SizedBox(
                    height:
                        AppSpacing.xl,
                  ),

                  
                  _buildCategories(),

                  const SizedBox(
                    height:
                        AppSpacing.xxxl,
                  ),

                  const Divider(),

                  const SizedBox(
                    height:
                        AppSpacing.xxl,
                  ),

                  

                  Text(
                    'Contact Us',

                    style:
                        AppTextStyles.heading1
                            .copyWith(
                      fontWeight:
                          AppTypography.bold,
                    ),
                  ),

                  const SizedBox(
                    height:
                        AppSpacing.xl,
                  ),

                  _buildContactActions(),
                ],
              ),
            );
          },
        ),
      ),

      // IMPORTANT:
      // No bottom navigation here.
    );
  }

  // =========================================================
  // SEARCH FIELD
  // =========================================================

  Widget _buildSearchField() {
    return TextField(
      controller:
          _viewModel.searchController,

      onChanged:
          _viewModel.onSearchChanged,

      style:
          AppTextStyles.bodyLarge
              .copyWith(
        color:
            AppColors.textPrimary,
      ),

      decoration: InputDecoration(
        hintText:
            'How can we help?',

        hintStyle:
            AppTextStyles.inputHint,

        prefixIcon:
            const Icon(
          Icons.search_rounded,
          color:
              AppColors.textSecondary,
          size:
              AppSpacing.iconMedium,
        ),

        filled: true,

        fillColor:
            AppColors.white,

        contentPadding:
            const EdgeInsets.symmetric(
          horizontal:
              AppSpacing.lg,
          vertical:
              AppSpacing.lg,
        ),

        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            AppSpacing
                .radiusMedium,
          ),
          borderSide:
              const BorderSide(
            color:
                AppColors.border,
          ),
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            AppSpacing
                .radiusMedium,
          ),
          borderSide:
              const BorderSide(
            color:
                AppColors.border,
          ),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            AppSpacing
                .radiusMedium,
          ),
          borderSide:
              const BorderSide(
            color:
                AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  

  Widget _buildCategories() {
    final categories =
        _viewModel.categories;

    if (categories.isEmpty) {
      return Container(
        width: double.infinity,

        padding: const EdgeInsets.all(
          AppSpacing.xxl,
        ),

        decoration: BoxDecoration(
          color:
              AppColors.surface,

          borderRadius:
              BorderRadius.circular(
            AppSpacing.radiusCard,
          ),
        ),

        child: Text(
          'No matching support category found.',

          textAlign:
              TextAlign.center,

          style:
              AppTextStyles.bodyMedium,
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,

      physics:
          const NeverScrollableScrollPhysics(),

      itemCount:
          categories.length,

      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

        crossAxisSpacing:
            AppSpacing.lg,

        mainAxisSpacing:
            AppSpacing.lg,

        mainAxisExtent: 84,
      ),

      itemBuilder: (
        context,
        index,
      ) {
        final category =
            categories[index];

        return _SupportCategoryCard(
          category: category,

          onTap: () {
            _viewModel.openCategory(
              context,
              category,
            );
          },
        );
      },
    );
  }

  // =========================================================
  // CONTACT ACTIONS
  // =========================================================

  Widget _buildContactActions() {
    return Column(
      children: [
        
        SizedBox(
          width:
              double.infinity,

          height:
              AppSpacing.buttonHeight,

          child:
              ElevatedButton.icon(
            onPressed: () {
              _viewModel.openChatSupport(
                context,
              );
            },

            icon: const Icon(
              Icons
                  .chat_outlined,

              color:
                  AppColors.white,

              size:
                  AppSpacing.iconSmall,
            ),

            label: Text(
              'Chat Support',

              style:
                  AppTextStyles.buttonText,
            ),
          ),
        ),

        const SizedBox(
          height:
              AppSpacing.md,
        ),
        

        SizedBox(
          width:
              double.infinity,

          height:
              AppSpacing.buttonHeight,

          child:
              OutlinedButton.icon(
            onPressed: () {
              _viewModel.callSupport(
                context,
              );
            },

            style:
                OutlinedButton.styleFrom(
              foregroundColor:
                  AppColors.primary,

              side:
                  const BorderSide(
                color:
                    AppColors.primary,

                width:
                    AppSpacing
                        .borderMedium,
              ),
              
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  AppSpacing
                      .radiusButton,
                ),
              ),
            ),

            icon: const Icon(
              Icons.phone_outlined,

              color:
                  AppColors.primary,

              size:
                  AppSpacing.iconSmall,
            ),

            label: Text(
              'Call Support',

              style: AppTextStyles
                  .buttonTextDark
                  .copyWith(
                color:
                    AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// SUPPORT CATEGORY CARD
// =====================================================================

class _SupportCategoryCard
    extends StatelessWidget {
  final SupportCategoryModel category;

  final VoidCallback onTap;

  const _SupportCategoryCard({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          AppColors.white,

      borderRadius:
          BorderRadius.circular(
        AppSpacing.radiusMedium,
      ),

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusMedium,
        ),

        child: Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal:
                AppSpacing.md,

            vertical:
                AppSpacing.sm,
          ),

          decoration:
              BoxDecoration(
            color:
                AppColors.white,

            borderRadius:
                BorderRadius.circular(
              AppSpacing
                  .radiusMedium,
            ),

            border:
                Border.all(
              color:
                  AppColors.border,
            ),

            boxShadow: [
              BoxShadow(
                color:
                    AppColors.black
                        .withOpacity(
                  AppColors
                      .opacityShadow,
                ),

                blurRadius: 8,

                offset:
                    const Offset(
                  0,
                  2,
                ),
              ),
            ],
          ),

          child: Row(
            children: [
              // =========================================
              // ICON
              // =========================================

              Container(
                width: 46,
                height: 46,

                alignment:
                    Alignment.center,

                decoration:
                    BoxDecoration(
                  shape:
                      BoxShape.circle,

                  color:
                      AppColors.primary
                          .withOpacity(
                    AppColors
                        .opacityExtraLight,
                  ),
                ),

                child: Icon(
                  category.icon,

                  color:
                      AppColors.primary,

                  size:
                      AppSpacing
                          .iconMedium,
                ),
              ),

              const SizedBox(
                width:
                    AppSpacing.md,
              ),

              // =========================================
              // TITLE
              // =========================================

              Expanded(
                child: Text(
                  category.title,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style:
                      AppTextStyles
                          .heading3
                          .copyWith(
                    fontWeight:
                        AppTypography
                            .semiBold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}