
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resumebuilder/resume_screen.dart';

class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({super.key});

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}
List<String> languages = [
  "Python",
  "JavaScript",
  "Java",
  "C++",
  "C#",
  "Ruby",
  "Swift",
  "Kotlin",
  "TypeScript",
  "PHP",
];
String firstName = "";
String lastName = "";


// declare a fisrt name text controller
final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();

List<String> selectedLanguages = [];
final ImagePicker picker = ImagePicker();
XFile? _imageFile;
class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  bool isPartTime = false;
  String? filename;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                "Application Form",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  label: const Text(
                    "First Name",
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  label: const Text(
                    "Last Name",
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              const SizedBox(
                height: 8,
              ),

              const SizedBox(
                height: 15,
              ),


              const Text(
                "Programming Languages",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              MultiSelectChip(
                languages,
                onSelectionChanged: (selected) {
                  setState(() {
                    selectedLanguages = selected;
                  });
                },
              ),

              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  selectImage();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFEB4A5A),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.shade100,
                  ),
                  child: Text(
                    filename ??
                        "Upload  picture",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFEB4A5A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () async {


                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  ResumeScreen(selectedLanguages: selectedLanguages, firstName: firstNameController.text, lastName: lastNameController.text, imageFile: _imageFile),
                    ),
                  );

                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFEB4A5A),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.shade100,
                  ),
                  child: const Text(
                    "Generate",
                    style: TextStyle(
                      color: Color(0xFFEB4A5A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),


                ),
              ),
              if (_imageFile != null)
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(_imageFile!.path)),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  void selectImage() async {
    final XFile? image =
    await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }
}







class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(
      this.reportList,
      {required this.onSelectionChanged}
      );

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget.reportList) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
