import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:resumebuilder/pdf_viewer_screen.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumeScreen extends StatefulWidget {
  static const String path = "lib/src/pages/profile/profile4.dart";
  final List<String> selectedLanguages ;
  final String firstName;
  final String lastName;
  final XFile? imageFile;
  const ResumeScreen({super.key, required this.selectedLanguages, required this.firstName, required this.lastName, this.imageFile});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

final pdf = pw.Document();
File imageDirectory = File('imageDirectory');

class _ResumeScreenState extends State<ResumeScreen> {
  late File imageFile;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.commentDots,
                color: Colors.black54,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black54,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(),
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: const Text(
                    "Over 8+ years of experience and web development and 5+ years of experience in mobile applications development "),
              ),
          Container(
            width: 500,
            height: 100,

            child: ListView.builder(

              scrollDirection: Axis.vertical,
              itemCount: widget.selectedLanguages.length,
              itemBuilder: (context, index) {
                return _buildSkillRow(widget.selectedLanguages[index], 0.5); // pass proficiency level statically
              },
            ),
          ),
              _buildExperienceRow(
                  company: "GID Nepal",
                  position: "Wordpress Developer",
                  duration: "2010 - 2012"),
              _buildExperienceRow(
                  company: "Lohani Tech",
                  position: "Laravel Developer",
                  duration: "2012 - 2015"),
              const SizedBox(height: 20.0),
              _buildTitle("Contact"),
              const SizedBox(height: 5.0),
              Row(
                children: const <Widget>[
                  SizedBox(width: 30.0),
                  Icon(
                    Icons.mail,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "dlohani48@gmail.com",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: const <Widget>[
                  SizedBox(width: 30.0),
                  Icon(
                    Icons.phone,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "+977-9818523107",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              _buildSocialsRow(),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final directory = (await getApplicationDocumentsDirectory()).path; //from path_provide package
            String fileName = DateTime.now().microsecondsSinceEpoch.toString();

            screenshotController
                .captureAndSave(
              "$directory/$fileName.png",
              pixelRatio: 2,
            )
                .then((value) async {
              print("value: $value");
              Uint8List imageBytes = await getImageData(value!);
              String pdfPath = await convertImageToPdf(imageBytes);
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return PdfViewScreen(pdfPath: pdfPath);
              }));
              setState(() {
                // Now you can update the state here
                // If you have a variable to store the PDF path in your state, you could do:
                // this.pdfPath = pdfPath;
              });
            });
          },
          child: const Icon(Icons.download),
        ),

      ),
    );
  }
  Future<Uint8List> getImageData(String imagePath) async {
    File imageFile = File(imagePath);

    if (await imageFile.exists()) {
      Uint8List imageBytes = await imageFile.readAsBytes();
      return imageBytes;
    } else {
      throw Exception('Image file does not exist.');
    }
  }

// a fucntion that converts a file path to a pdf file
  Future<String> convertImageToPdf(Uint8List imageBytes) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pw.MemoryImage(imageBytes)),
          );
        },
      ),
    );
    final output = await getExternalStorageDirectory();
    final file = File("${output!.path}/example.pdf");
    await file.writeAsBytes(await pdf.save());
    print("file path: ${file.path}");
    _launchURL(file.path);
    return file.path;
  }

  Row _buildSocialsRow() {
    return Row(
      children: <Widget>[
        const SizedBox(width: 20.0),
        IconButton(
          color: Colors.indigo,
          icon: const Icon(FontAwesomeIcons.facebook),
          onPressed: () {
            _launchURL("https://facebook.com/lohanidamodar");
          },
        ),
        const SizedBox(width: 5.0),
        IconButton(
          color: Colors.indigo,
          icon: const Icon(FontAwesomeIcons.github),
          onPressed: () {
            _launchURL("https://github.com/lohanidamodar");
          },
        ),
        const SizedBox(width: 5.0),
        IconButton(
          color: Colors.red,
          icon: const Icon(FontAwesomeIcons.youtube),
          onPressed: () {
            _launchURL("https://youtube.com/c/reactbits");
          },
        ),
        const SizedBox(width: 10.0),
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  ListTile _buildExperienceRow(
      {required String company, String? position, String? duration}) {
    return ListTile(
      leading: const Padding(
        padding: EdgeInsets.only(top: 8.0, left: 20.0),
        child: Icon(
          Icons.circle,
          size: 10,
          color: Colors.black,
        ),
      ),
      title: Text(
        company,
        style:
        const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text("$position ($duration)"),
    );
  }

  Row _buildSkillRow(String skill, double level) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 16.0),
        Expanded(
            flex: 2,
            child: Text(
              skill.toUpperCase(),
              textAlign: TextAlign.right,
            )),
        const SizedBox(width: 10.0),
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            value: level,
          ),
        ),
        const SizedBox(width: 16.0),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      children: <Widget>[
        const SizedBox(width: 20.0),
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(widget.imageFile!.path)),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Text(
              "${widget.firstName} ${widget.lastName}",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            const Text("Full Stack Developer"),
            const SizedBox(height: 5.0),
            Row(
              children: const <Widget>[
                Icon(
                  FontAwesomeIcons.map,
                  size: 12.0,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "Kathmandu, Nepal",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }


}