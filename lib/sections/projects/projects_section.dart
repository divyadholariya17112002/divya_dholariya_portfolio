import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_utils.dart';
import '../../models/portfolio_data.dart';
import '../../widgets/animations/section_reveal_animation.dart';
import '../../widgets/cards/project_card.dart';
import '../../widgets/common/section_container.dart';

/// Featured projects section with responsive wrap layout (intrinsic card heights).
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key, required this.sectionKey});

  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveUtils.gridColumns(context, mobile: 1, tablet: 2, desktop: 3);
    final isMobile = ResponsiveUtils.isMobile(context);

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
                title: 'Featured Projects',
                subtitle: 'Some of my recent work',
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final spacing = AppConstants.spacingLg;
                  final totalSpacing = spacing * (columns - 1);
                  final cardWidth = isMobile
                      ? constraints.maxWidth
                      : (constraints.maxWidth - totalSpacing) / columns;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: List.generate(PortfolioData.projects.length, (index) {
                      return SizedBox(
                        width: cardWidth,
                        child: SectionRevealAnimation(
                          delay: Duration(milliseconds: 100 * index),
                          child: ProjectCard(
                            project: PortfolioData.projects[index],
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
