import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';


class PdfViewScreen extends StatelessWidget {
  const PdfViewScreen({Key? key, required this.pdfPath}) : super(key: key);
final String pdfPath;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      body:  PDFView(
        filePath: pdfPath,

      )

    );
  }
}