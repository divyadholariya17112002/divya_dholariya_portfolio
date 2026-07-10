/// Data model representing an education entry.
class EducationModel {
  const EducationModel({
    required this.degree,
    required this.institution,
    required this.period,
    this.description,
    this.isPursuing = false,
  });

  final String degree;
  final String institution;
  final String period;
  final String? description;
  final bool isPursuing;
}
