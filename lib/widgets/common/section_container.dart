import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

/// Constrains content to max width with responsive horizontal padding.
class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = screenWidth < AppConstants.mobileBreakpoint
        ? AppConstants.sectionPaddingMobile
        : screenWidth < AppConstants.desktopBreakpoint
            ? AppConstants.sectionPaddingTablet
            : AppConstants.sectionPaddingDesktop;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: child,
        ),
      ),
    );
  }
}

/// Standard section header with gradient accent line and title.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: AppConstants.spacingMd),
            Text(
              title,
              style: theme.textTheme.headlineMedium,
            ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            subtitle!,
            style: theme.textTheme.bodyLarge,
          ),
        ],
        const SizedBox(height: AppConstants.spacing2xl),
      ],
    );
  }
}
