import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/services/navigation_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_utils.dart';
import '../common/glass_container.dart';

/// Floating navigation bar with scroll spy active section highlighting.
class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({
    super.key,
    required this.navigationService,
    required this.onMenuTap,
  });

  final NavigationService navigationService;
  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Positioned(
      top: AppConstants.spacingLg,
      left: AppConstants.spacingLg,
      right: AppConstants.spacingLg,
      child: GlassContainer(
        borderRadius: AppConstants.navBarBorderRadius,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingLg,
          vertical: AppConstants.spacingSm,
        ),
        child: Row(
          children: [
            // Logo / brand
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.primaryGradient.createShader(bounds),
              child: Text(
                'DD',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Spacer(),
            if (isMobile)
              IconButton(
                onPressed: onMenuTap,
                icon: const Icon(Icons.menu_rounded),
                color: AppColors.textPrimary,
              )
            else
              ListenableBuilder(
                listenable: navigationService,
                builder: (context, _) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: AppStrings.sectionIds.map((id) {
                      final isActive = navigationService.activeSection == id;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _NavItem(
                          label: AppStrings.sectionLabels[id] ?? id,
                          isActive: isActive,
                          onTap: () => navigationService.navigateToSection(id),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppConstants.animationFast,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingMd,
            vertical: AppConstants.spacingSm,
          ),
          decoration: BoxDecoration(
            gradient: widget.isActive ? AppColors.primaryGradient : null,
            color: widget.isActive
                ? null
                : _isHovered
                    ? AppColors.glassWhite
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: widget.isActive ? Colors.white : AppColors.textSecondary,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
