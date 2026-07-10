import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

/// Animated floating geometric shapes for hero background decoration.
class FloatingShapes extends StatelessWidget {
  const FloatingShapes({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        _FloatingShape(
          top: size.height * 0.1,
          left: size.width * 0.05,
          size: 80,
          color: AppColors.primaryPurple.withValues(alpha: 0.15),
          delay: 0,
        ),
        _FloatingShape(
          top: size.height * 0.3,
          right: size.width * 0.1,
          size: 120,
          color: AppColors.primaryBlue.withValues(alpha: 0.12),
          delay: 500,
          isCircle: true,
        ),
        _FloatingShape(
          bottom: size.height * 0.2,
          left: size.width * 0.15,
          size: 60,
          color: AppColors.accentCyan.withValues(alpha: 0.1),
          delay: 1000,
        ),
        _FloatingShape(
          top: size.height * 0.5,
          right: size.width * 0.25,
          size: 90,
          color: AppColors.accentPink.withValues(alpha: 0.08),
          delay: 1500,
          isCircle: true,
        ),
        _FloatingShape(
          bottom: size.height * 0.35,
          right: size.width * 0.05,
          size: 50,
          color: AppColors.primaryPurple.withValues(alpha: 0.1),
          delay: 2000,
        ),
      ],
    );
  }
}

class _FloatingShape extends StatelessWidget {
  const _FloatingShape({
    required this.size,
    required this.color,
    required this.delay,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.isCircle = false,
  });

  final double size;
  final Color color;
  final int delay;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle ? null : BorderRadius.circular(16),
        ),
      )
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .moveY(
            begin: 0,
            end: -20,
            duration: Duration(milliseconds: 3000 + delay),
            curve: Curves.easeInOut,
          )
          .rotate(
            begin: 0,
            end: isCircle ? 0.1 : 0.05,
            duration: Duration(milliseconds: 4000 + delay),
          ),
    );
  }
}
