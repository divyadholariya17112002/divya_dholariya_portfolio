import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';

/// Animated scroll-down indicator for the hero section.
class ScrollDownIndicator extends StatelessWidget {
  const ScrollDownIndicator({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Scroll Down',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textMuted,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primaryPurple,
            size: 32,
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(begin: 0, end: 8, duration: const Duration(milliseconds: 1000)),
        ],
      ),
    );
  }
}
