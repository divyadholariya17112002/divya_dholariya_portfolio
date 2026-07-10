import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/url_service.dart';
import '../../core/theme/app_colors.dart';
import '../../models/project_model.dart';
import '../buttons/gradient_button.dart';
import '../common/glass_container.dart';
import '../common/tech_chip.dart';

/// Project showcase card with Play Store screenshot, role, tech chips, and action buttons.
class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.project,
    this.urlService = const UrlService(),
  });

  final ProjectModel project;
  final UrlService urlService;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Transform.translate(
        offset: Offset(0, _isHovered ? -4 : 0),
        child: AnimatedContainer(
          duration: AppConstants.animationFast,
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primaryPurple.withValues(alpha: 0.25),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: GlassContainer(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              _ProjectScreenshot(
                project: widget.project,
                isHovered: _isHovered,
              ),
              Padding(
                padding: const EdgeInsets.all(AppConstants.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.project.category != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppConstants.spacingSm,
                        ),
                        child: Text(
                          widget.project.category!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryPurple,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    Text(
                      widget.project.title,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppConstants.spacingSm),
                    _RoleBadge(role: widget.project.role),
                    const SizedBox(height: AppConstants.spacingMd),
                    Text(
                      widget.project.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                    Wrap(
                      spacing: AppConstants.spacingSm,
                      runSpacing: AppConstants.spacingSm,
                      children: widget.project.technologies
                          .map((tech) => TechChip(label: tech, isCompact: true))
                          .toList(),
                    ),
                    if (widget.project.hasGooglePlay || widget.project.hasGithub) ...[
                      const SizedBox(height: AppConstants.spacingLg),
                      _ActionButtons(
                        project: widget.project,
                        urlService: widget.urlService,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}

/// Fixed-aspect-ratio screenshot area — avoids layout jump on hover.
class _ProjectScreenshot extends StatelessWidget {
  const _ProjectScreenshot({
    required this.project,
    required this.isHovered,
  });

  final ProjectModel project;
  final bool isHovered;

  static const double _aspectRatio = 16 / 9;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: AspectRatio(
        aspectRatio: _aspectRatio,
        child: AnimatedScale(
          scale: isHovered ? 1.04 : 1.0,
          duration: AppConstants.animationNormal,
          curve: Curves.easeOutCubic,
          child: _ProjectImage(imagePath: project.imagePath, isSvg: project.isSvgImage),
        ),
      ),
    );
  }
}

/// Renders SVG or raster Play Store screenshot assets.
class _ProjectImage extends StatelessWidget {
  const _ProjectImage({
    required this.imagePath,
    required this.isSvg,
  });

  final String imagePath;
  final bool isSvg;

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      return SvgPicture.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.hardEdge,
      );
    }

    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) => Container(
        color: AppColors.cardDark,
        alignment: Alignment.center,
        child: const Icon(
          Icons.image_not_supported_outlined,
          color: AppColors.textMuted,
          size: 40,
        ),
      ),
    );
  }
}

/// Role label with icon.
class _RoleBadge extends StatelessWidget {
  const _RoleBadge({required this.role});

  final String role;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.person_outline_rounded,
          size: 16,
          color: AppColors.primaryBlue.withValues(alpha: 0.9),
        ),
        const SizedBox(width: AppConstants.spacingXs),
        Expanded(
          child: Text(
            role,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Google Play and GitHub action buttons in a responsive wrap layout.
class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.project,
    required this.urlService,
  });

  final ProjectModel project;
  final UrlService urlService;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppConstants.spacingSm,
      runSpacing: AppConstants.spacingSm,
      children: [
        if (project.hasGooglePlay)
          GradientButton(
            label: project.googlePlayButtonText,
            icon: Icons.shop_rounded,
            onPressed: () => urlService.launchUrlString(project.googlePlayUrl!),
          ),
        if (project.hasGithub)
          GradientButton(
            label: 'GitHub',
            icon: Icons.code,
            isOutlined: true,
            onPressed: () => urlService.launchUrlString(project.githubUrl!),
          ),
      ],
    );
  }
}
