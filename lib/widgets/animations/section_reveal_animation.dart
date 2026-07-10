import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_constants.dart';

/// Wrapper that applies fade + slide reveal animation when section becomes visible.
class SectionRevealAnimation extends StatelessWidget {
  const SectionRevealAnimation({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.slideOffset = const Offset(0, 40),
  });

  final Widget child;
  final Duration delay;
  final Offset slideOffset;

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .fadeIn(
          duration: AppConstants.animationSlow,
          delay: delay,
          curve: Curves.easeOutCubic,
        )
        .slideX(
          begin: slideOffset.dx / 100,
          end: 0,
          duration: AppConstants.animationSlow,
          delay: delay,
          curve: Curves.easeOutCubic,
        )
        .slideY(
          begin: slideOffset.dy / 100,
          end: 0,
          duration: AppConstants.animationSlow,
          delay: delay,
          curve: Curves.easeOutCubic,
        );
  }
}
