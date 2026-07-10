import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/services/navigation_service.dart';
import '../../core/theme/app_colors.dart';

/// Mobile drawer navigation for smaller screens.
class MobileDrawer extends StatelessWidget {
  const MobileDrawer({
    super.key,
    required this.navigationService,
  });

  final NavigationService navigationService;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surfaceDark,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingLg),
              child: ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.primaryGradient.createShader(bounds),
                child: Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListenableBuilder(
                listenable: navigationService,
                builder: (context, _) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.spacingMd,
                    ),
                    children: AppStrings.sectionIds.map((id) {
                      final isActive = navigationService.activeSection == id;
                      return ListTile(
                        leading: Icon(
                          _iconForSection(id),
                          color: isActive
                              ? AppColors.primaryPurple
                              : AppColors.textSecondary,
                        ),
                        title: Text(
                          AppStrings.sectionLabels[id] ?? id,
                          style: TextStyle(
                            color: isActive
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontWeight:
                                isActive ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                        selected: isActive,
                        selectedTileColor:
                            AppColors.primaryPurple.withValues(alpha: 0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          navigationService.navigateToSection(id);
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForSection(String id) {
    return switch (id) {
      'home' => Icons.home_rounded,
      'about' => Icons.person_rounded,
      'experience' => Icons.work_rounded,
      'skills' => Icons.code_rounded,
      'projects' => Icons.folder_rounded,
      'statistics' => Icons.bar_chart_rounded,
      'education' => Icons.school_rounded,
      'contact' => Icons.mail_rounded,
      _ => Icons.circle,
    };
  }
}
