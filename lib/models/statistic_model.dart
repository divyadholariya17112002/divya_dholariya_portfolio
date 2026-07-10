import 'package:flutter/material.dart';

/// Data model for animated statistics counters.
class StatisticModel {
  const StatisticModel({
    required this.value,
    required this.label,
    required this.suffix,
    this.prefix = '',
    this.icon,
  });

  final int value;
  final String label;
  final String suffix;
  final String prefix;
  final IconData? icon;
}
