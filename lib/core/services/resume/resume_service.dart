import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/asset_constants.dart';
import 'resume_pdf_generator.dart';

/// Handles resume download/sharing:
/// - Web & desktop: triggers a browser/OS download via FileSaver.
/// - Android & iOS: writes the PDF to a temp file and opens the system
///   share sheet so the user can save, open, or send the file.
class ResumeService {
  const ResumeService();

  static const String _fileName = 'Divya_Dholariya_Resume';

  /// Downloads or shares the resume as a PDF file.
  Future<ResumeDownloadResult> downloadResume() async {
    try {
      final assetBytes = await _loadBundledPdf();
      final bytes = assetBytes ?? await ResumePdfGenerator.generate();
      final source = assetBytes != null
          ? ResumeDownloadSource.bundledAsset
          : ResumeDownloadSource.generated;

      if (kIsWeb || _isDesktop) {
        // Web / desktop: use FileSaver to trigger a browser download.
        await FileSaver.instance.saveFile(
          name: _fileName,
          bytes: bytes,
          fileExtension: 'pdf',
          mimeType: MimeType.pdf,
        );
      } else {
        // Android / iOS: write to a temp file then open the share sheet.
        // Share.shareXFiles is the correct API for share_plus ^10.x.
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/$_fileName.pdf');
        await file.writeAsBytes(bytes, flush: true);

        final xFile = XFile(
          file.path,
          mimeType: 'application/pdf',
          name: '$_fileName.pdf',
        );
        await Share.shareXFiles(
          [xFile],
          subject: '$_fileName.pdf',
        );
      }

      return ResumeDownloadResult.success(source: source);
    } catch (error) {
      return ResumeDownloadResult.failure(message: error.toString());
    }
  }

  /// True when running natively on a desktop OS (Windows / macOS / Linux).
  bool get _isDesktop =>
      !kIsWeb &&
      (Platform.isWindows || Platform.isMacOS || Platform.isLinux);

  /// Loads the bundled resume PDF from assets if it exists and is valid.
  Future<Uint8List?> _loadBundledPdf() async {
    try {
      final data = await rootBundle.load(AssetConstants.resumePdf);
      final bytes = data.buffer.asUint8List();
      return _isValidPdf(bytes) ? bytes : null;
    } catch (_) {
      return null;
    }
  }

  /// Validates PDF magic bytes (%PDF).
  bool _isValidPdf(Uint8List bytes) {
    if (bytes.length < 4) return false;
    return String.fromCharCodes(bytes.sublist(0, 4)) == '%PDF';
  }
}

/// Indicates whether the downloaded file came from assets or was generated.
enum ResumeDownloadSource { bundledAsset, generated }

/// Result of a resume download attempt.
class ResumeDownloadResult {
  const ResumeDownloadResult._({
    required this.isSuccess,
    this.source,
    this.message,
  });

  factory ResumeDownloadResult.success({
    required ResumeDownloadSource source,
  }) {
    return ResumeDownloadResult._(isSuccess: true, source: source);
  }

  factory ResumeDownloadResult.failure({required String message}) {
    return ResumeDownloadResult._(isSuccess: false, message: message);
  }

  final bool isSuccess;
  final ResumeDownloadSource? source;
  final String? message;

  String get successMessage => switch (source) {
        ResumeDownloadSource.bundledAsset => 'Resume downloaded successfully.',
        ResumeDownloadSource.generated =>
          'Resume generated and downloaded successfully.',
        null => 'Resume downloaded successfully.',
      };
}
