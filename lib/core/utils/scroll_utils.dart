import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Smooth scroll utilities for section navigation.
abstract final class ScrollUtils {
  /// Scrolls to a section identified by its GlobalKey with smooth animation.
  static Future<void> scrollToSection(
    GlobalKey key, {
    Duration duration = AppConstants.animationSlow,
    Curve curve = Curves.easeInOutCubic,
  }) async {
    final context = key.currentContext;
    if (context == null) return;

    await Scrollable.ensureVisible(
      context,
      duration: duration,
      curve: curve,
      alignment: 0.05,
    );
  }

  /// Scrolls to the top of the page.
  static Future<void> scrollToTop(
    ScrollController controller, {
    Duration duration = AppConstants.animationSlow,
    Curve curve = Curves.easeInOutCubic,
  }) async {
    if (!controller.hasClients) return;
    await controller.animateTo(0, duration: duration, curve: curve);
  }
}
