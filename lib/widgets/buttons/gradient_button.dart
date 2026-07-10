import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

/// Primary gradient-filled action button.
class GradientButton extends StatefulWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isOutlined = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isOutlined;

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: AppConstants.animationFast,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: AppConstants.animationFast,
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingLg,
                vertical: AppConstants.spacingMd,
              ),
              decoration: BoxDecoration(
                gradient: widget.isOutlined ? null : AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
                border: widget.isOutlined
                    ? Border.all(
                        color: _isHovered
                            ? AppColors.primaryPurple
                            : AppColors.glassBorder,
                        width: 1.5,
                      )
                    : null,
                boxShadow: _isHovered && !widget.isOutlined
                    ? [
                        BoxShadow(
                          color: AppColors.primaryPurple.withValues(alpha: 0.4),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: 18,
                      color: widget.isOutlined
                          ? AppColors.textPrimary
                          : Colors.white,
                    ),
                    const SizedBox(width: AppConstants.spacingSm),
                  ],
                  Text(
                    widget.label,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: widget.isOutlined
                          ? AppColors.textPrimary
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
