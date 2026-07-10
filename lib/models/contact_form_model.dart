/// Data model for contact form submission fields.
class ContactFormModel {
  const ContactFormModel({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
  });

  final String name;
  final String email;
  final String subject;
  final String message;

  bool get isValid =>
      name.isNotEmpty &&
      email.isNotEmpty &&
      email.contains('@') &&
      subject.isNotEmpty &&
      message.isNotEmpty;
}
