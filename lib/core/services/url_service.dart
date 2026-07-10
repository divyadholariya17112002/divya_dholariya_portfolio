import 'package:url_launcher/url_launcher.dart';

/// Service for launching external URLs, emails, and phone links.
class UrlService {
  const UrlService();

  /// Opens a URL in the default browser.
  Future<bool> launchUrlString(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return false;
  }

  /// Opens the default email client with a pre-filled recipient.
  Future<bool> launchEmail(String email, {String? subject, String? body}) async {
    final params = <String, String>{};
    if (subject != null) params['subject'] = subject;
    if (body != null) params['body'] = body;
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: params.isEmpty ? null : params,
    );
    return launchUrl(uri);
  }

  /// Opens the phone dialer with the given number.
  Future<bool> launchPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    return launchUrl(uri);
  }
}
