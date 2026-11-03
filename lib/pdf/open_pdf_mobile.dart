import 'package:url_launcher/url_launcher.dart';

Future<void> openPdf() async {
  final Uri url = Uri.parse(
    "https://drive.google.com/file/d/1uWIs0aQ7RyTdSzcdo7is129TzDrYeO7a/view?usp=drive_link",
  );

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not open PDF';
  }
}
