import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../constants/app_strings.dart';
import '../../../models/portfolio_data.dart';

/// Builds a resume PDF from portfolio data when no bundled PDF asset is available.
abstract final class ResumePdfGenerator {
  static Future<Uint8List> generate() async {
    final pdf = pw.Document(
      title: '${AppStrings.appName} - Resume',
      author: AppStrings.appName,
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          _buildHeader(),
          pw.SizedBox(height: 20),
          _buildSection('Contact', _buildContact()),
          pw.SizedBox(height: 16),
          _buildSection('Professional Summary', [
            pw.Text(AppStrings.aboutSummary, style: _bodyStyle),
          ]),
          pw.SizedBox(height: 16),
          _buildSection('Experience', _buildExperience()),
          pw.SizedBox(height: 16),
          _buildSection('Skills', [_buildSkills()]),
          pw.SizedBox(height: 16),
          _buildSection('Featured Projects', _buildProjects()),
          pw.SizedBox(height: 16),
          _buildSection('Education', _buildEducation()),
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          AppStrings.appName,
          style: pw.TextStyle(
            fontSize: 28,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.indigo800,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          AppStrings.appTitle,
          style: pw.TextStyle(
            fontSize: 16,
            color: PdfColors.indigo600,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildSection(String title, List<pw.Widget> children) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.only(bottom: 6),
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(color: PdfColors.indigo300, width: 1.5),
            ),
          ),
          child: pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.indigo800,
            ),
          ),
        ),
        pw.SizedBox(height: 10),
        ...children,
      ],
    );
  }

  static List<pw.Widget> _buildContact() {
    return [
      pw.Text('Email: ${AppStrings.email}', style: _bodyStyle),
      pw.SizedBox(height: 4),
      pw.Text('Phone: ${AppStrings.phone}', style: _bodyStyle),
      pw.SizedBox(height: 4),
      pw.Text('Location: ${AppStrings.location}', style: _bodyStyle),
      pw.SizedBox(height: 4),
      pw.Text('LinkedIn: ${AppStrings.linkedInUrl}', style: _bodyStyle),
      pw.SizedBox(height: 4),
      pw.Text('GitHub: ${AppStrings.githubUrl}', style: _bodyStyle),
    ];
  }

  static List<pw.Widget> _buildExperience() {
    return PortfolioData.experiences.map((exp) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 12),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              exp.company,
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              '${exp.role}  |  ${exp.period}',
              style: pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey700,
                fontStyle: pw.FontStyle.italic,
              ),
            ),
            pw.SizedBox(height: 6),
            ...exp.highlights.map(
              (item) => pw.Padding(
                padding: const pw.EdgeInsets.only(left: 8, bottom: 3),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('• ', style: _bodyStyle),
                    pw.Expanded(child: pw.Text(item, style: _bodyStyle)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  static pw.Widget _buildSkills() {
    final skillNames = PortfolioData.skills.map((s) => s.name).join('  •  ');
    return pw.Text(skillNames, style: _bodyStyle);
  }

  static List<pw.Widget> _buildProjects() {
    return PortfolioData.projects.map((project) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 10),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              project.title,
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              project.role,
              style: pw.TextStyle(
                fontSize: 9,
                color: PdfColors.indigo700,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(project.description, style: _bodyStyle),
            pw.SizedBox(height: 4),
            pw.Text(
              project.technologies.join(' • '),
              style: pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
            ),
          ],
        ),
      );
    }).toList();
  }

  static List<pw.Widget> _buildEducation() {
    return PortfolioData.education.map((edu) {
      final pursuing = edu.isPursuing ? ' (Pursuing)' : '';
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              '${edu.degree}$pursuing',
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              '${edu.institution}  |  ${edu.period}',
              style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
          ],
        ),
      );
    }).toList();
  }

  static final pw.TextStyle _bodyStyle = pw.TextStyle(
    fontSize: 10,
    lineSpacing: 1.4,
    color: PdfColors.grey800,
  );
}
