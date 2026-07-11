import 'package:flutter/material.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/asset_constants.dart';
import 'experience_model.dart';
import 'project_model.dart';
import 'skill_model.dart';
import 'education_model.dart';
import 'statistic_model.dart';
import 'social_link_model.dart';

/// Centralized portfolio data used across all sections.
abstract final class PortfolioData {
  static const List<ExperienceModel> experiences = [
    ExperienceModel(
      company: 'LogicGo Infotech',
      role: 'Flutter Developer',
      period: 'May 2026 – June 2026',
      isCurrent: true,
      highlights: [
        'Omeeba Social Platform',
        'Lottery Application',
        'Health Compass App',
        'REST API Integration',
        'Quality Assurance',
        'Bug Fixing & Optimization',
      ],
    ),
    ExperienceModel(
      company: 'Hexotix Pvt Ltd',
      role: 'Flutter Developer',
      period: 'July 2025 – Dec 2025',
      highlights: [
        'Reveal Diamond Detector',
        'Python Backend Integration',
        'Flutter Mobile Development',
        'Raspberry Pi Integration',
        'Industrial IoT Solutions',
        'Bluetooth Connectivity',
      ],
    ),
    ExperienceModel(
      company: 'Tecocraft Infusion',
      role: 'Junior Flutter Developer',
      period: 'January 2024-June 2025',
      highlights: [
        'Milk Delivery Application',
        '75+ TV Remote Apps',
        'Firebase Integration',
        'Payment Gateway Integration',
        'App Migration Projects',
      ],
    ),
    ExperienceModel(
      company: 'iFlutter',
      role: 'Intern Flutter Developer',
      period: 'July 2023-December 2023',
      highlights: [
        'News Application',
        'Gallery Application',
        'Hobby Application',
        'Rest APIs',
        'Local Storage',
      ],
    ),
  ];

  static const List<SkillModel> skills = [
    SkillModel(name: 'Flutter', icon: Icons.flutter_dash),
    SkillModel(name: 'Dart', icon: Icons.code),
    SkillModel(name: 'Firebase', icon: Icons.local_fire_department),
    SkillModel(name: 'REST API', icon: Icons.api),
    SkillModel(name: 'Dio', icon: Icons.cloud_download),
    SkillModel(name: 'SQLite', icon: Icons.storage),
    SkillModel(name: 'Hive', icon: Icons.inventory_2),
    SkillModel(name: 'Bloc', icon: Icons.view_module),
    SkillModel(name: 'Provider', icon: Icons.change_circle),
    SkillModel(name: 'GetX', icon: Icons.speed),
    SkillModel(name: 'MVVM', icon: Icons.architecture),
    SkillModel(name: 'Clean Architecture', icon: Icons.layers),
    SkillModel(name: 'Git', icon: Icons.merge_type),
    SkillModel(name: 'GitHub', icon: Icons.code),
    SkillModel(name: 'GitLab', icon: Icons.source),
    SkillModel(name: 'Postman', icon: Icons.send),
    SkillModel(name: 'Razorpay', icon: Icons.payment),
    SkillModel(name: 'Bluetooth', icon: Icons.bluetooth),
    SkillModel(name: 'Python', icon: Icons.terminal),
    SkillModel(name: 'IoT', icon: Icons.sensors),
    SkillModel(name: 'Responsive UI', icon: Icons.devices),
    SkillModel(name: 'Material Design', icon: Icons.design_services),
  ];

  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'Reveal Diamond Detector',
      role: 'Lead Flutter Developer',
      description:
          'Developed a complete Flutter application for an industrial diamond '
          'detection device with Raspberry Pi integration, real-time device '
          'communication, scan workflows, live analysis, and result reporting.',
      imagePath: AssetConstants.projectReveal,
      technologies: [
        'Flutter',
        'Raspberry Pi',
        'REST API',
        'Python',
        'IoT',
        'Bluetooth',
      ],
      googlePlayUrl:
      'https://play.google.com/store/apps/details?id=org.jtr.jtr_mobile&pcampaignid=web_share',
      category: 'Industrial',
    ),
    ProjectModel(
      title: 'Health Compass',
      role: 'Flutter Developer',
      description:
          'Contributed to the Health Compass healthcare platform by developing '
          'UI modules, integrating REST APIs, performing QA testing, and supporting '
          'Android, iOS, and Web applications.',
      imagePath: AssetConstants.projectHealth,
      technologies: ['Flutter', 'REST API', 'Firebase', 'Android', 'iOS', 'Web'],
      googlePlayUrl:
          'https://play.google.com/store/apps/details?id=com.healthcompass.app&pcampaignid=web_share',
      category: 'Healthcare',
    ),
    ProjectModel(
      title: 'Center Grade',
      role: 'Flutter Developer',
      description:
          'Contributed to an AI-powered card grading application by building '
          'Flutter UI screens, integrating APIs, and ensuring a smooth user '
          'experience across the application.',
      imagePath: AssetConstants.projectCenterGrade,
      technologies: ['Flutter', 'REST API', 'AI', 'Responsive UI'],
      googlePlayUrl:
          'https://play.google.com/store/apps/details?id=com.center.grade&pcampaignid=web_share',
      category: 'AI',
    ),
    ProjectModel(
      title: 'Milk Delivery & Payment',
      role: 'Flutter Developer',
      description:
          'Built a multi-role Flutter application with Firebase Authentication, '
          'MVVM architecture, Razorpay, UPI payments, billing, invoices, and '
          'order management.',
      imagePath: AssetConstants.projectMilk,
      technologies: ['Flutter', 'Firebase', 'MVVM', 'Razorpay', 'UPI'],
      googlePlayUrl:
      'https://play.google.com/store/apps/details?id=com.girorganic.user&pcampaignid=web_share',
      category: 'E-Commerce',
    ),
    ProjectModel(
      title: '75+ Smart TV & AC Remote Apps',
      role: 'Flutter Developer',
      description:
          'Migrated and maintained more than 75 Flutter applications by upgrading '
          'Flutter SDK, Android SDK, JDK, AdMob, and third-party packages.',
      imagePath: AssetConstants.projectTv,
      technologies: ['Flutter', 'Android SDK', 'AdMob'],
      googlePlayUrl:
      'https://play.google.com/store/apps/details?id=com.fas.universal.remote.control&pcampaignid=web_share',
      category: 'Migration',
    ),
    ProjectModel(
      title: 'Omeeba',
      role: 'Flutter Developer',
      description:
          'Worked on a social media platform by developing UI screens, integrating '
          'REST APIs, and performing QA testing.',
      imagePath: AssetConstants.projectOmeeba,
      technologies: ['Flutter', 'REST API', 'UI'],
      googlePlayUrl:
      'https://apps.apple.com/in/app/omeeba/id6753140500',
      category: 'Social',
    ),
  ];

  static const List<StatisticModel> statistics = [
    StatisticModel(
      value: 3,
      label: 'Years Experience',
      suffix: '+',
      // prefix: 'Nearly ',
      icon: Icons.work_history,
    ),
    StatisticModel(
      value: 15,
      label: 'Applications Built',
      suffix: '+',
      icon: Icons.apps,
    ),
    StatisticModel(
      value: 75,
      label: 'Apps Migrated',
      suffix: '+',
      icon: Icons.swap_horiz,
    ),
    StatisticModel(
      value: 6,
      label: 'AI Tools Mastered',
      suffix: '',
      icon: Icons.psychology,
    ),
  ];

  static const List<EducationModel> education = [
    EducationModel(
      degree: 'BCA',
      institution: 'Bachelor of Computer Applications',
      period: '2018 – 2021',
      description: 'Foundation in computer science, programming, and software development.',
    ),
    EducationModel(
      degree: 'MCA',
      institution: 'Master of Computer Applications',
      period: '2021 – 2023',
      description: 'Advanced studies in software engineering and application development.',
    ),
    EducationModel(
      degree: 'PhD',
      institution: 'Doctor of Philosophy (Pursuing)',
      period: '2024 – Present',
      description: 'Research in advanced computing and software engineering methodologies.',
      isPursuing: true,
    ),
  ];

  static const List<SocialLinkModel> socialLinks = [
    SocialLinkModel(
      name: 'LinkedIn',
      url: AppStrings.linkedInUrl,
      icon: Icons.link,
    ),
    SocialLinkModel(
      name: 'GitHub',
      url: AppStrings.githubUrl,
      icon: Icons.code,
    ),
    SocialLinkModel(
      name: 'Email',
      url: 'mailto:${AppStrings.email}',
      icon: Icons.email,
    ),
  ];

  /// About section highlight tags.
  static const List<String> aboutHighlights = [
    'Nearly 3 Years Flutter',
    'Android',
    'iOS',
    'Flutter Web',
    'Clean Architecture',
    'MVVM',
    'Firebase',
    'REST APIs',
    'SQLite',
    'Hive',
    'Provider',
    'Bloc',
    'GetX',
    'Bluetooth',
    'Raspberry Pi',
    'IoT',
    'Payment Gateway',
    'Razorpay',
    'UPI',
    'ChatGPT',
    'Cursor',
    'Claude',
    'Gemini',
    'GitHub Copilot',
    'Windsurf',
  ];
}
