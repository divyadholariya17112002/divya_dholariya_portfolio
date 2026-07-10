import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/services/navigation_service.dart';
import '../../widgets/common/floating_nav_bar.dart';
import '../../widgets/common/mobile_drawer.dart';
import '../../sections/hero/hero_section.dart';
import '../../sections/about/about_section.dart';
import '../../sections/experience/experience_section.dart';
import '../../sections/skills/skills_section.dart';
import '../../sections/projects/projects_section.dart';
import '../../sections/statistics/statistics_section.dart';
import '../../sections/education/education_section.dart';
import '../../sections/contact/contact_section.dart';
import '../../sections/footer/footer_section.dart';

/// Main portfolio page assembling all sections with scroll spy navigation.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  late final NavigationService _navigationService;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _navigationService = NavigationService(scrollController: _scrollController);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _navigationService.dispose();
    super.dispose();
  }

  /// Scroll spy: detects which section is currently in view.
  void _onScroll() {
    // VisibilityDetector handles per-section updates; scroll listener reserved
    // for future parallax or progress indicator features.
  }

  void _onSectionVisibility(String sectionId, VisibilityInfo info) {
    if (info.visibleFraction > 0.3) {
      _navigationService.setActiveSection(sectionId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MobileDrawer(navigationService: _navigationService),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _wrapWithVisibility(
                  'home',
                  HeroSection(
                    sectionKey: _navigationService.sectionKeys['home']!,
                    navigationService: _navigationService,
                  ),
                ),
                _wrapWithVisibility(
                  'about',
                  AboutSection(
                    sectionKey: _navigationService.sectionKeys['about']!,
                  ),
                ),
                _wrapWithVisibility(
                  'experience',
                  ExperienceSection(
                    sectionKey: _navigationService.sectionKeys['experience']!,
                  ),
                ),
                _wrapWithVisibility(
                  'skills',
                  SkillsSection(
                    sectionKey: _navigationService.sectionKeys['skills']!,
                  ),
                ),
                _wrapWithVisibility(
                  'projects',
                  ProjectsSection(
                    sectionKey: _navigationService.sectionKeys['projects']!,
                  ),
                ),
                _wrapWithVisibility(
                  'statistics',
                  StatisticsSection(
                    sectionKey: _navigationService.sectionKeys['statistics']!,
                  ),
                ),
                _wrapWithVisibility(
                  'education',
                  EducationSection(
                    sectionKey: _navigationService.sectionKeys['education']!,
                  ),
                ),
                _wrapWithVisibility(
                  'contact',
                  ContactSection(
                    sectionKey: _navigationService.sectionKeys['contact']!,
                  ),
                ),
                FooterSection(navigationService: _navigationService),
              ],
            ),
          ),
          FloatingNavBar(
            navigationService: _navigationService,
            onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ],
      ),
    );
  }

  /// Wraps a section widget with visibility detection for scroll spy.
  Widget _wrapWithVisibility(String sectionId, Widget child) {
    return VisibilityDetector(
      key: Key('visibility_$sectionId'),
      onVisibilityChanged: (info) => _onSectionVisibility(sectionId, info),
      child: child,
    );
  }
}
