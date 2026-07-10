/// Data model representing a work experience entry.
class ExperienceModel {
  const ExperienceModel({
    required this.company,
    required this.role,
    required this.period,
    required this.highlights,
    this.isCurrent = false,
  });

  final String company;
  final String role;
  final String period;
  final List<String> highlights;
  final bool isCurrent;
}
