import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/responsive_utils.dart';
import '../../models/portfolio_data.dart';
import '../../widgets/animations/section_reveal_animation.dart';
import '../../widgets/cards/stat_card.dart';
import '../../widgets/common/section_container.dart';

/// Statistics section with animated counters.
class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key, required this.sectionKey});

  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveUtils.gridColumns(context, mobile: 2, tablet: 2, desktop: 4);

    return Container(
      key: sectionKey,
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing4xl),
      child: SectionContainer(
        child: SectionRevealAnimation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Statistics',
                subtitle: 'Numbers that define my journey',
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: AppConstants.spacingLg,
                  mainAxisSpacing: AppConstants.spacingLg,
                  childAspectRatio: ResponsiveUtils.isMobile(context) ? 1.0 : 1.2,
                ),
                itemCount: PortfolioData.statistics.length,
                itemBuilder: (context, index) {
                  return SectionRevealAnimation(
                    delay: Duration(milliseconds: 150 * index),
                    child: StatCard(stat: PortfolioData.statistics[index]),
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
