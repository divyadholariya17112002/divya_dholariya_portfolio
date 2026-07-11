import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/services/navigation_service.dart';
import '../../core/services/url_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_utils.dart';
import '../../models/portfolio_data.dart';
import '../../widgets/buttons/social_icon_button.dart';

/// Footer with navigation, social links, copyright, and back-to-top button.
class FooterSection extends StatelessWidget {
  const FooterSection({
    super.key,
    required this.navigationService,
    this.urlService = const UrlService(),
  });

  final NavigationService navigationService;
  final UrlService urlService;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.spacing3xl,
        horizontal: AppConstants.spacingLg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        border: Border(
          top: BorderSide(color: AppColors.glassBorder),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              if (isMobile) ...[
                _buildLogo(context),
                const SizedBox(height: AppConstants.spacingXl),
                _buildNavLinks(context),
                const SizedBox(height: AppConstants.spacingXl),
                _buildSocialIcons(),
              ] else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLogo(context),
                    _buildNavLinks(context),
                    _buildSocialIcons(),
                  ],
                ),
              const SizedBox(height: AppConstants.spacing2xl),
              const Divider(),
              const SizedBox(height: AppConstants.spacingLg),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.copyright,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  // _BackToTopButton(
                  //   onPressed: () => navigationService.scrollToTop(),
                  // ),
                ],
              ),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Text(
                  //   AppStrings.copyright,
                  //   style: Theme.of(context).textTheme.bodySmall,
                  // ),
                  _BackToTopButton(
                    onPressed: () => navigationService.scrollToTop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          AppColors.primaryGradient.createShader(bounds),
      child: Text(
        AppStrings.appName,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildNavLinks(BuildContext context) {
    return Wrap(
      spacing: AppConstants.spacingLg,
      runSpacing: AppConstants.spacingSm,
      alignment: WrapAlignment.center,
      children: AppStrings.sectionIds.map((id) {
        return InkWell(
          onTap: () => navigationService.navigateToSection(id),
          child: Text(
            AppStrings.sectionLabels[id] ?? id,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: PortfolioData.socialLinks
          .map((link) => Padding(
                padding: const EdgeInsets.only(left: AppConstants.spacingSm),
                child: SocialIconButton(
                  icon: link.icon,
                  tooltip: link.name,
                  size: 40,
                  onPressed: () => urlService.launchUrlString(link.url),
                ),
              ))
          .toList(),
    );
  }
}

class _BackToTopButton extends StatefulWidget {
  const _BackToTopButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<_BackToTopButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: AppConstants.animationFast,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingMd,
            vertical: AppConstants.spacingSm,
          ),
          decoration: BoxDecoration(
            gradient: _isHovered ? AppColors.primaryGradient : null,
            color: _isHovered ? null : AppColors.glassWhite,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_upward_rounded,
                size: 16,
                color: _isHovered ? Colors.white : AppColors.textSecondary,
              ),
              const SizedBox(width: AppConstants.spacingXs),
              Text(
                'Back to Top',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _isHovered ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
