import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Device type classification for responsive layouts.
enum DeviceType { mobile, tablet, desktop }

/// Utility methods for responsive layout decisions and spacing.
abstract final class ResponsiveUtils {
  /// Returns the current device type based on screen width.
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < AppConstants.mobileBreakpoint) return DeviceType.mobile;
    if (width < AppConstants.desktopBreakpoint) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  static bool isMobile(BuildContext context) =>
      getDeviceType(context) == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      getDeviceType(context) == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      getDeviceType(context) == DeviceType.desktop;

  /// Returns horizontal section padding based on device type.
  static double sectionPadding(BuildContext context) {
    return switch (getDeviceType(context)) {
      DeviceType.mobile => AppConstants.sectionPaddingMobile,
      DeviceType.tablet => AppConstants.sectionPaddingTablet,
      DeviceType.desktop => AppConstants.sectionPaddingDesktop,
    };
  }

  /// Returns column count for grid layouts based on device type.
  static int gridColumns(BuildContext context, {int mobile = 1, int tablet = 2, int desktop = 3}) {
    return switch (getDeviceType(context)) {
      DeviceType.mobile => mobile,
      DeviceType.tablet => tablet,
      DeviceType.desktop => desktop,
    };
  }

  /// Returns a responsive font size multiplier.
  static double fontScale(BuildContext context) {
    return switch (getDeviceType(context)) {
      DeviceType.mobile => 0.85,
      DeviceType.tablet => 0.95,
      DeviceType.desktop => 1.0,
    };
  }
}
