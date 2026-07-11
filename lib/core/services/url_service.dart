import 'package:url_launcher/url_launcher.dart';

/// Service for launching external URLs, emails, and phone links.
class UrlService {
  const UrlService();

  /// Opens a URL in the default browser.
  ///
  /// Uses [LaunchMode.externalApplication] so the link opens outside the app
  /// on mobile, and in a new tab on web.
  Future<bool> launchUrlString(String url) async {
    final uri = Uri.parse(url);
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  /// Opens the default email client with a pre-filled recipient.
  ///
  /// Note: [canLaunchUrl] returns false for `mailto:` in most web browsers
  /// even when the browser *can* handle it, so we skip that check and attempt
  /// the launch directly. On web this opens the browser's mail handler (e.g.
  /// Gmail if set as default); on mobile it opens the mail app.
  Future<bool> launchEmail(String email, {String? subject, String? body}) async {
    final params = <String, String>{};
    if (subject != null) params['subject'] = subject;
    if (body != null) params['body'] = body;
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: params.isEmpty ? null : params,
    );
    try {
      // platformDefault lets the OS/browser decide how to handle mailto:
      // which works correctly on both web and mobile.
      return await launchUrl(uri, mode: LaunchMode.platformDefault);
    } catch (_) {
      return false;
    }
  }

  /// Opens the phone dialer with the given number.
  Future<bool> launchPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    try {
      return await launchUrl(uri, mode: LaunchMode.platformDefault);
    } catch (_) {
      return false;
    }
  }
}
