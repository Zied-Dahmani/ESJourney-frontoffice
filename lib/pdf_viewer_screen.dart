import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';


class PdfViewScreen extends StatelessWidget {
  const PdfViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // ...

      body:  PDFView(
        filePath: '/storage/emulated/0/Android/data/com.example.resumebuilder/files/1683652800696740.pdf',
      )

    );
  }
}