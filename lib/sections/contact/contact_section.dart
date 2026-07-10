import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/services/url_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_utils.dart';
import '../../models/portfolio_data.dart';
import '../../widgets/animations/section_reveal_animation.dart';
import '../../widgets/buttons/gradient_button.dart';
import '../../widgets/buttons/social_icon_button.dart';
import '../../widgets/common/glass_container.dart';
import '../../widgets/common/section_container.dart';

/// Contact section with info cards, form, and map placeholder.
class ContactSection extends StatefulWidget {
  const ContactSection({
    super.key,
    required this.sectionKey,
    this.urlService = const UrlService(),
  });

  final GlobalKey sectionKey;
  final UrlService urlService;

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    // Compose mailto link with form data for web-friendly submission.
    final body = 'Name: ${_nameController.text}\n\n${_messageController.text}';
    await widget.urlService.launchEmail(
      AppStrings.email,
      subject: _subjectController.text,
      body: body,
    );

    if (mounted) {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Opening email client...'),
          backgroundColor: AppColors.primaryPurple,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      key: widget.sectionKey,
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing4xl),
      child: SectionContainer(
        child: SectionRevealAnimation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Contact',
                subtitle: 'Let\'s work together',
              ),
              if (isMobile)
                Column(
                  children: [
                    _buildContactInfo(context),
                    const SizedBox(height: AppConstants.spacing2xl),
                    _buildContactForm(context),
                    const SizedBox(height: AppConstants.spacing2xl),
                    _buildMapPlaceholder(context),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _buildContactInfo(context),
                          const SizedBox(height: AppConstants.spacing2xl),
                          _buildMapPlaceholder(context),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacing2xl),
                    Expanded(
                      flex: 3,
                      child: _buildContactForm(context),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(AppConstants.spacingXl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ContactInfoItem(
            icon: Icons.email_rounded,
            label: 'Email',
            value: AppStrings.email,
            onTap: () => widget.urlService.launchEmail(AppStrings.email),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          _ContactInfoItem(
            icon: Icons.phone_rounded,
            label: 'Phone',
            value: AppStrings.phone,
            onTap: () => widget.urlService.launchPhone(AppStrings.phone),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          _ContactInfoItem(
            icon: Icons.location_on_rounded,
            label: 'Location',
            value: AppStrings.location,
          ),
          const SizedBox(height: AppConstants.spacingXl),
          Text(
            'Connect with me',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Row(
            children: PortfolioData.socialLinks
                .map((link) => Padding(
                      padding: const EdgeInsets.only(right: AppConstants.spacingMd),
                      child: SocialIconButton(
                        icon: link.icon,
                        tooltip: link.name,
                        onPressed: () =>
                            widget.urlService.launchUrlString(link.url),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(AppConstants.spacingXl),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Send a Message',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.spacingLg),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Your Name'),
              maxLength: AppConstants.maxNameLength,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Please enter your name' : null,
            ),
            const SizedBox(height: AppConstants.spacingMd),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Your Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Please enter your email';
                if (!v.contains('@')) return 'Please enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: AppConstants.spacingMd),
            TextFormField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'Subject'),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Please enter a subject' : null,
            ),
            const SizedBox(height: AppConstants.spacingMd),
            TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'Message'),
              maxLines: 5,
              maxLength: AppConstants.maxMessageLength,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Please enter a message' : null,
            ),
            const SizedBox(height: AppConstants.spacingLg),
            GradientButton(
              label: _isSubmitting ? 'Sending...' : 'Send Message',
              icon: Icons.send_rounded,
              onPressed: _isSubmitting ? () {} : _handleSubmit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapPlaceholder(BuildContext context) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryPurple.withValues(alpha: 0.2),
              AppColors.primaryBlue.withValues(alpha: 0.2),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.map_rounded,
              size: 48,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: AppConstants.spacingMd),
            Text(
              'Surat, Gujarat, India',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppConstants.spacingXs),
            Text(
              'Google Map Placeholder',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  const _ContactInfoItem({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
