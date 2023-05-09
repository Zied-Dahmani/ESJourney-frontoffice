import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
bool isPDFVisible = false; // Track whether the PDF is visible

class _MyAppState extends State<MyApp> {
  final picker = ImagePicker();
  final pdf = pw.Document();
  List<File> _image = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("image to pdf"),
        actions: [
          IconButton(
              icon: Icon(Icons.picture_as_pdf),
              onPressed: () {
                createPDF();
                savePDF();
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImageFromGallery,
        child: Icon(Icons.add),
      ),
      body:

      _image != null
          ? ListView.builder(
        itemCount: _image.length,
        itemBuilder: (context, index) => Container(
            height: 400,
            width: double.infinity,
            margin: EdgeInsets.all(8),
            child: Image.file(
              _image[index],
              fit: BoxFit.cover,
            )),
      )
          : Container(),
    );
  }

  getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image.add(File(pickedFile.path));
      } else {
        print('No image selected');
      }
    });
  }

  createPDF() async {
    for (var img in _image) {
      final image = pw.MemoryImage(img.readAsBytesSync());

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }
  }

  savePDF() async {
    try {
      final dir = await getExternalStorageDirectory();
      // generate a random string for your file name
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();

      final file = File('${dir!.path}/$fileName.pdf');
      print('${dir!.path}/$fileName.pdf');
      await file.writeAsBytes(await pdf.save());
print('saved');
    } catch (e) {
      print('error');
     // showPrintedMessage('error', e.toString());
    }
  }


}