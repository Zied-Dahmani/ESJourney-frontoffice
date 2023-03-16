import 'package:esjourney/presentation/widgets/text_form_field.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Apply3 extends StatefulWidget {
  const Apply3({Key? key, this.linkedInLinkController, this.updatePDFFile}) : super(key: key);

  final linkedInLinkController,updatePDFFile;

  @override
  State<Apply3> createState() => _Apply3State();
}

class _Apply3State extends State<Apply3> {
  var _fileUploaded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        TextFormFieldWidget(widget.linkedInLinkController,
            AppStrings.klinkedInProfileLink, TextInputType.text),
        const SizedBox(height: AppSizes.ksmallSpace),
        GestureDetector(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );

            if (result != null) {
              PlatformFile file = result.files.first;
              setState(() {
                _fileUploaded = true;
                widget.updatePDFFile(file);
              });
            }
          },
          child: Container(
            height: AppSizes.kbuttonHeight + 40,
            width: ScreenSize.width(context),
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
              borderRadius: BorderRadius.circular(AppSizes.kradius),
              border: Border.all(
                color: theme.colorScheme.tertiary,
              ),
            ),
            child: Center(
                child: Icon(
              _fileUploaded == false
                  ? FontAwesomeIcons.solidFilePdf
                  : FontAwesomeIcons.fileCircleCheck,
              size: 30,
              color: theme.colorScheme.primary,
            )),
          ),
        ),
      ],
    );
  }
}
