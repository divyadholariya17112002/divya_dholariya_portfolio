import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_strings.dart';
import 'core/services/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Optimize for web: set preferred orientations and system UI overlay.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const PortfolioApp());
}

/// Root application widget with theme, routing, and responsive breakpoints.
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '${AppStrings.appName} | ${AppStrings.appTitle}',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: const [
          Breakpoint(start: 0, end: AppConstants.mobileBreakpoint, name: MOBILE),
          Breakpoint(
            start: AppConstants.mobileBreakpoint,
            end: AppConstants.tabletBreakpoint,
            name: TABLET,
          ),
          Breakpoint(
            start: AppConstants.tabletBreakpoint,
            end: AppConstants.desktopBreakpoint,
            name: DESKTOP,
          ),
          Breakpoint(
            start: AppConstants.desktopBreakpoint,
            end: double.infinity,
            name: '4K',
          ),
        ],
      ),
    );
  }
}
