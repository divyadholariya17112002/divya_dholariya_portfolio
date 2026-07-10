import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_utils.dart';
import '../../models/education_model.dart';
import '../../models/portfolio_data.dart';
import '../../widgets/animations/section_reveal_animation.dart';
import '../../widgets/common/glass_container.dart';
import '../../widgets/common/section_container.dart';

/// Education section with timeline layout.
class EducationSection extends StatelessWidget {
  const EducationSection({super.key, required this.sectionKey});

  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing4xl),
      color: AppColors.surfaceDark.withValues(alpha: 0.5),
      child: SectionContainer(
        child: SectionRevealAnimation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Education',
                subtitle: 'Academic background',
              ),
              ...PortfolioData.education.asMap().entries.map((entry) {
                final index = entry.key;
                final edu = entry.value;
                return SectionRevealAnimation(
                  delay: Duration(milliseconds: 150 * index),
                  child: _EducationCard(
                    education: edu,
                    isLast: index == PortfolioData.education.length - 1,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard({
    required this.education,
    required this.isLast,
  });

  final EducationModel education;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : AppConstants.spacingLg),
      child: GlassContainer(
        padding: const EdgeInsets.all(AppConstants.spacingXl),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: isMobile ? 48 : 64,
              height: isMobile ? 48 : 64,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                education.isPursuing ? Icons.school : Icons.menu_book_rounded,
                color: Colors.white,
                size: isMobile ? 24 : 32,
              ),
            ),
            const SizedBox(width: AppConstants.spacingLg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        education.degree,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (education.isPursuing) ...[
                        const SizedBox(width: AppConstants.spacingMd),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.spacingMd,
                            vertical: AppConstants.spacingXs,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accentCyan.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.accentCyan.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Text(
                            'Pursuing',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.accentCyan,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingXs),
                  Text(
                    education.institution,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryPurple,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingXs),
                  Text(
                    education.period,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (education.description != null) ...[
                    const SizedBox(height: AppConstants.spacingMd),
                    Text(
                      education.description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
