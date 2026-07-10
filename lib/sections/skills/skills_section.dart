import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_utils.dart';
import '../../models/portfolio_data.dart';
import '../../models/skill_model.dart';
import '../../widgets/animations/section_reveal_animation.dart';
import '../../widgets/common/glass_container.dart';
import '../../widgets/common/section_container.dart';

/// Skills section with animated grid layout.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, required this.sectionKey});

  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveUtils.gridColumns(context, mobile: 2, tablet: 3, desktop: 4);

    return Container(
      key: sectionKey,
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing4xl),
      child: SectionContainer(
        child: SectionRevealAnimation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Skills',
                subtitle: 'Technologies I work with',
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: AppConstants.spacingMd,
                  mainAxisSpacing: AppConstants.spacingMd,
                  childAspectRatio: ResponsiveUtils.isMobile(context) ? 1.8 : 2.2,
                ),
                itemCount: PortfolioData.skills.length,
                itemBuilder: (context, index) {
                  return _SkillCard(
                    skill: PortfolioData.skills[index],
                    index: index,
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

class _SkillCard extends StatefulWidget {
  const _SkillCard({required this.skill, required this.index});

  final SkillModel skill;
  final int index;

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: AppConstants.animationFast,
        child: GlassContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.skill.icon != null)
                Icon(
                  widget.skill.icon,
                  size: 28,
                  color: _isHovered
                      ? AppColors.primaryPurple
                      : AppColors.textSecondary,
                ),
              const SizedBox(height: AppConstants.spacingSm),
              Text(
                widget.skill.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 50 * widget.index),
          duration: AppConstants.animationNormal,
        )
        .slideY(begin: 0.2, end: 0);
  }
}
