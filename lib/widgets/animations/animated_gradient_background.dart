import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Animated gradient background for hero and full-page sections.
class AnimatedGradientBackground extends StatefulWidget {
  const AnimatedGradientBackground({super.key, required this.child});

  final Widget child;

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                -1 + _controller.value * 2,
                -1,
              ),
              end: Alignment(
                1 - _controller.value * 2,
                1,
              ),
              colors: const [
                AppColors.backgroundDark,
                Color(0xFF0F0A1A),
                Color(0xFF0A0F1A),
                AppColors.backgroundDark,
              ],
              stops: const [0.0, 0.3, 0.7, 1.0],
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
