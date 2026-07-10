import 'package:flutter/material.dart';

/// Data model representing a skill with optional icon.
class SkillModel {
  const SkillModel({
    required this.name,
    this.icon,
    this.category,
  });

  final String name;
  final IconData? icon;
  final String? category;
}
