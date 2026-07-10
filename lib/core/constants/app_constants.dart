import 'app_strings.dart';

/// Layout, animation, and breakpoint constants used across the app.
abstract final class AppConstants {
  // Breakpoints (aligned with responsive_framework)
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
  static const double maxContentWidth = 1200;

  // Spacing scale
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;
  static const double spacing2xl = 48;
  static const double spacing3xl = 64;
  static const double spacing4xl = 96;

  // Section padding
  static const double sectionPaddingMobile = 24;
  static const double sectionPaddingTablet = 48;
  static const double sectionPaddingDesktop = 64;

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 400);
  static const Duration animationSlow = Duration(milliseconds: 800);
  static const Duration animationVerySlow = Duration(milliseconds: 1200);

  // Navigation bar
  static const double navBarHeight = 64;
  static const double navBarBorderRadius = 32;

  // Glassmorphism
  static const double glassBlur = 20;
  static const double glassOpacity = 0.1;
  static const double glassBorderOpacity = 0.2;

  // Scroll spy offset for section detection
  static const double scrollSpyOffset = 120;

  // Contact form field limits
  static const int maxNameLength = 100;
  static const int maxMessageLength = 1000;

  // Portfolio owner info (re-exported for convenience)
  static const String ownerName = AppStrings.appName;
  static const String ownerTitle = AppStrings.appTitle;
}
