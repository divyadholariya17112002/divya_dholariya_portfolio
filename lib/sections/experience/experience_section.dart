import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_utils.dart';
import '../../models/experience_model.dart';
import '../../models/portfolio_data.dart';
import '../../widgets/animations/section_reveal_animation.dart';
import '../../widgets/common/glass_container.dart';
import '../../widgets/common/section_container.dart';

/// Experience section with vertical timeline design.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key, required this.sectionKey});

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
                title: 'Experience',
                subtitle: 'My professional journey',
              ),
              ...PortfolioData.experiences.asMap().entries.map((entry) {
                final index = entry.key;
                final experience = entry.value;
                return SectionRevealAnimation(
                  delay: Duration(milliseconds: 150 * index),
                  child: _TimelineItem(
                    experience: experience,
                    isLast: index == PortfolioData.experiences.length - 1,
                    isMobile: ResponsiveUtils.isMobile(context),
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

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.experience,
    required this.isLast,
    required this.isMobile,
  });

  final ExperienceModel experience;
  final bool isLast;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          SizedBox(
            width: isMobile ? 40 : 60,
            child: Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: experience.isCurrent
                        ? AppColors.primaryGradient
                        : null,
                    color: experience.isCurrent
                        ? null
                        : AppColors.primaryPurple.withValues(alpha: 0.5),
                    border: Border.all(
                      color: AppColors.primaryPurple,
                      width: 2,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: AppColors.glassBorder,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : AppConstants.spacing2xl,
              ),
              child: GlassContainer(
                padding: const EdgeInsets.all(AppConstants.spacingXl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            experience.company,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        if (experience.isCurrent)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.spacingMd,
                              vertical: AppConstants.spacingXs,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Current',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacingXs),
                    Text(
                      experience.role,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primaryPurple,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingXs),
                    Text(
                      experience.period,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                    ...experience.highlights.map(
                      (highlight) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppConstants.spacingSm,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.arrow_right_rounded,
                              color: AppColors.primaryBlue,
                              size: 20,
                            ),
                            Expanded(
                              child: Text(
                                highlight,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
