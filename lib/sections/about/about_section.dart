import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../models/portfolio_data.dart';
import '../../widgets/animations/section_reveal_animation.dart';
import '../../widgets/common/glass_container.dart';
import '../../widgets/common/section_container.dart';
import '../../widgets/common/tech_chip.dart';

/// About section with professional summary and technology highlights.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.sectionKey});

  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing4xl),
      child: SectionContainer(
        child: SectionRevealAnimation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'About Me',
                subtitle: 'Get to know me better',
              ),
              GlassContainer(
                padding: const EdgeInsets.all(AppConstants.spacingXl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.aboutSummary,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: AppConstants.spacing2xl),
                    Text(
                      'Technologies & Tools',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                    Wrap(
                      spacing: AppConstants.spacingSm,
                      runSpacing: AppConstants.spacingSm,
                      children: PortfolioData.aboutHighlights
                          .map((tag) => TechChip(label: tag))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
