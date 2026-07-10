import 'package:flutter/material.dart';

/// Data model for social media / contact links.
class SocialLinkModel {
  const SocialLinkModel({
    required this.name,
    required this.url,
    required this.icon,
  });

  final String name;
  final String url;
  final IconData icon;
}
