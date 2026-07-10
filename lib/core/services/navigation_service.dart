import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../utils/scroll_utils.dart';

/// Manages section GlobalKeys and scroll spy for navigation highlighting.
class NavigationService extends ChangeNotifier {
  NavigationService({required this.scrollController});

  final ScrollController scrollController;
  String _activeSection = 'home';

  String get activeSection => _activeSection;

  /// GlobalKeys for each portfolio section, used for scroll-to and spy.
  final Map<String, GlobalKey> sectionKeys = {
    for (final id in AppStrings.sectionIds) id: GlobalKey(),
  };

  /// Updates the active section and notifies listeners.
  void setActiveSection(String sectionId) {
    if (_activeSection != sectionId) {
      _activeSection = sectionId;
      notifyListeners();
    }
  }

  /// Scrolls smoothly to the section with the given ID.
  Future<void> navigateToSection(String sectionId) async {
    final key = sectionKeys[sectionId];
    if (key != null) {
      await ScrollUtils.scrollToSection(key);
      setActiveSection(sectionId);
    }
  }

  /// Scrolls back to the top of the page.
  Future<void> scrollToTop() async {
    await ScrollUtils.scrollToTop(scrollController);
    setActiveSection('home');
  }

}
