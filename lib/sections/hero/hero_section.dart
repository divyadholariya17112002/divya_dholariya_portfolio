import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/asset_constants.dart';
import '../../core/services/navigation_service.dart';
import '../../core/services/resume/resume_service.dart';
import '../../core/services/url_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_utils.dart';
import '../../models/portfolio_data.dart';
import '../../widgets/animations/animated_gradient_background.dart';
import '../../widgets/animations/floating_shapes.dart';
import '../../widgets/animations/scroll_down_indicator.dart';
import '../../widgets/animations/section_reveal_animation.dart';
import '../../widgets/buttons/gradient_button.dart';
import '../../widgets/buttons/social_icon_button.dart';
import '../../widgets/common/gradient_text.dart';
import '../../widgets/common/section_container.dart';

/// Hero section with profile, typing animation, CTA buttons, and social links.
class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.sectionKey,
    required this.navigationService,
    this.urlService = const UrlService(),
    this.resumeService = const ResumeService(),
  });

  final GlobalKey sectionKey;
  final NavigationService navigationService;
  final UrlService urlService;
  final ResumeService resumeService;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isDesktop = ResponsiveUtils.isDesktop(context);

    return SizedBox(
      key: sectionKey,
      height: MediaQuery.sizeOf(context).height,
      child: AnimatedGradientBackground(
        child: Stack(
          children: [
            const FloatingShapes(),
            // Radial glow behind profile
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.2,
              left: isMobile ? 0 : MediaQuery.sizeOf(context).width * 0.3,
              right: 0,
              child: Container(
                width: 400,
                height: 400,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.glowGradient,
                ),
              ),
            ),
            SectionContainer(
              child: Center(
                child: isMobile
                    ? _buildMobileLayout(context)
                    : _buildDesktopLayout(context, isDesktop),
              ),
            ),
            // Scroll down indicator at bottom
            Positioned(
              bottom: AppConstants.spacing2xl,
              left: 0,
              right: 0,
              child: Center(
                child: ScrollDownIndicator(
                  onTap: () => navigationService.navigateToSection('about'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          _buildProfileImage(context, size: 160),
          const SizedBox(height: AppConstants.spacingXl),
          _buildTextContent(context, centerAlign: true),
          const SizedBox(height: AppConstants.spacing2xl),
          _buildButtons(context, isMobile: true),
          const SizedBox(height: AppConstants.spacingLg),
          _buildSocialIcons(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: isDesktop ? 5 : 6,
            child: SectionRevealAnimation(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextContent(context),
                  const SizedBox(height: AppConstants.spacing2xl),
                  _buildButtons(context),
                  const SizedBox(height: AppConstants.spacingXl),
                  _buildSocialIcons(),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppConstants.spacing3xl),
          Expanded(
            flex: isDesktop ? 4 : 5,
            child: SectionRevealAnimation(
              delay: const Duration(milliseconds: 200),
              slideOffset: const Offset(40, 0),
              child: _buildProfileImage(context, size: isDesktop ? 320 : 260),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context, {required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withValues(alpha: 0.4),
            blurRadius: 40,
            spreadRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: ClipOval(
        child: SvgPicture.asset(
          AssetConstants.profileImage,
          fit: BoxFit.cover,
        ),
      ),
    )
        .animate()
        .fadeIn(duration: AppConstants.animationSlow)
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: AppConstants.animationSlow,
          curve: Curves.easeOutBack,
        );
  }

  Widget _buildTextContent(BuildContext context, {bool centerAlign = false}) {
    final align = centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centerAlign ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          'Hello, I\'m',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: textAlign,
        ),
        const SizedBox(height: AppConstants.spacingSm),
        GradientText(
          AppStrings.appName,
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: textAlign,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        SizedBox(
          height: 40,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.primaryPurple,
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              pause: const Duration(milliseconds: 2000),
              animatedTexts: AppStrings.typingPhrases
                  .map((phrase) => TypewriterAnimatedText(
                        phrase,
                        speed: const Duration(milliseconds: 100),
                      ))
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        Text(
          AppStrings.heroSubtitle,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: textAlign,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context, {bool isMobile = false}) {
    final buttons = [
      GradientButton(
        label: 'Download Resume',
        icon: Icons.download_rounded,
        onPressed: () => _downloadResume(context),
      ),
      GradientButton(
        label: 'View Projects',
        icon: Icons.folder_open_rounded,
        isOutlined: true,
        onPressed: () => navigationService.navigateToSection('projects'),
      ),
      GradientButton(
        label: 'Contact Me',
        icon: Icons.mail_rounded,
        isOutlined: true,
        onPressed: () => navigationService.navigateToSection('contact'),
      ),
    ];

    if (isMobile) {
      return Column(
        children: buttons
            .map((b) => Padding(
                  padding: const EdgeInsets.only(bottom: AppConstants.spacingMd),
                  child: b,
                ))
            .toList(),
      );
    }

    return Wrap(
      spacing: AppConstants.spacingMd,
      runSpacing: AppConstants.spacingMd,
      children: buttons,
    );
  }

  Future<void> _downloadResume(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      SnackBar(
        content: const Text('Preparing resume download...'),
        backgroundColor: AppColors.primaryPurple,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    final result = await resumeService.downloadResume();

    if (!context.mounted) return;

    messenger.showSnackBar(
      SnackBar(
        content: Text(
          result.isSuccess
              ? result.successMessage
              : 'Failed to download resume. Please try again.',
        ),
        backgroundColor:
            result.isSuccess ? AppColors.success : AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: PortfolioData.socialLinks
          .map((link) => Padding(
                padding: const EdgeInsets.only(right: AppConstants.spacingMd),
                child: SocialIconButton(
                  icon: link.icon,
                  tooltip: link.name,
                  onPressed: () => urlService.launchUrlString(link.url),
                ),
              ))
          .toList(),
    );
  }
}
