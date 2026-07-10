import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

/// Technology tag chip used in project cards and about section.
class TechChip extends StatelessWidget {
  const TechChip({
    super.key,
    required this.label,
    this.isCompact = false,
  });

  final String label;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? AppConstants.spacingSm : AppConstants.spacingMd,
        vertical: isCompact ? AppConstants.spacingXs : AppConstants.spacingSm,
      ),
      decoration: BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.textPrimary,
          fontSize: isCompact ? 11 : 12,
        ),
      ),
    );
  }
}
