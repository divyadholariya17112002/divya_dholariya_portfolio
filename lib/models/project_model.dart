/// Data model representing a portfolio project.
class ProjectModel {
  const ProjectModel({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.technologies,
    required this.role,
    this.githubUrl,
    this.googlePlayUrl,
    this.googlePlayButtonText = 'View on Google Play',
    this.category,
  });

  final String title;
  final String description;
  final String imagePath;
  final List<String> technologies;
  final String role;
  final String? githubUrl;
  final String? googlePlayUrl;
  final String googlePlayButtonText;
  final String? category;

  bool get hasGooglePlay => googlePlayUrl != null && googlePlayUrl!.isNotEmpty;
  bool get hasGithub => githubUrl != null && githubUrl!.isNotEmpty;
  bool get isSvgImage => imagePath.toLowerCase().endsWith('.svg');
}
