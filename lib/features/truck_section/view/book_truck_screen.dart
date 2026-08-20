import 'package:client_app/features/truck_section/view/models/truck_option_card.dart';
import 'package:client_app/features/truck_section/viewmodel/book_truck_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';


class BookTruckScreen extends StatefulWidget {
  const BookTruckScreen({super.key});

  @override
  State<BookTruckScreen> createState() => _BookTruckScreenState();
}

class _BookTruckScreenState extends State<BookTruckScreen> {
  late final BookTruckViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = BookTruckViewModel();
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
                Expanded(
                  child: Stack(
                    children: [
                      ListView(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.screenHorizontal,
                          AppSpacing.lg,
                          AppSpacing.screenHorizontal,
                          AppSpacing.huge,
                        ),
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerLeft,
                            onPressed: () => Navigator.of(context).maybePop(),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Text(
                            'Book a truck',
                            style: AppTextStyles.screenTitle,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'Move your goods safely across the city.',
                            style: AppTextStyles.screenSubtitle,
                          ),
                          const SizedBox(height: AppSpacing.xxl),
                          for (final truck in _viewModel.truckOptions) ...[
                            TruckOptionCard(
                              truck: truck,
                              isSelected:
                                  truck.id == _viewModel.selectedTruckId,
                              onTap: () => _viewModel.selectTruck(truck.id),
                            ),
                            const SizedBox(height: AppSpacing.lg),
                          ],
                        ],
                      ),
                      // Soft fade so the list appears to scroll under the
                      // sticky bottom actions, matching the design.
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: IgnorePointer(
                          child: Container(
                            height: AppSpacing.huge,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.background.withOpacity(0),
                                  AppColors.background,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _BottomActions(viewModel: _viewModel),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({required this.viewModel});

  final BookTruckViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,
            child: ElevatedButton(
              onPressed: viewModel.onContinuePressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusButton),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Continue', style: AppTextStyles.buttonText),
                  const SizedBox(width: AppSpacing.sm),
                  const Icon(
                    Icons.arrow_forward,
                    color: AppColors.white,
                    size: AppSpacing.iconSmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,
            child: OutlinedButton(
              onPressed: viewModel.onCompareVehiclesPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusButton),
                ),
              ),
              child: Text(
                'Compare vehicles',
                style:
                    AppTextStyles.buttonText.copyWith(color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
