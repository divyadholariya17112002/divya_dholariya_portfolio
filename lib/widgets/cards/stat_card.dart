import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/statistic_model.dart';
import '../animations/animated_counter.dart';
import '../common/glass_container.dart';
import '../../core/constants/app_constants.dart';

/// Statistics display card with animated counter.
class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.stat});

  final StatisticModel stat;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(AppConstants.spacingXl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (stat.icon != null) ...[
            Icon(stat.icon, size: 36, color: AppColors.primaryPurple),
            const SizedBox(height: AppConstants.spacingMd),
          ],
          AnimatedCounter(
            value: stat.value,
            prefix: stat.prefix,
            suffix: stat.suffix,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              foreground: Paint()
                ..shader = AppColors.primaryGradient.createShader(
                  const Rect.fromLTWH(0, 0, 200, 50),
                ),
            ),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            stat.label,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
