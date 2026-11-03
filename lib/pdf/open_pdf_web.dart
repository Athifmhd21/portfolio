import 'dart:html' as html;

void openPdf() {
  final pdfUrl = Uri.base.resolve('assets/assets/athif21.pdf').toString();

  html.window.open(pdfUrl, '_blank');
}
