import 'package:esjourney/presentation/widgets/club/date_picker.dart';
import 'package:esjourney/presentation/widgets/club/drop_down_button.dart';
import 'package:esjourney/presentation/widgets/text_form_field.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';

class Apply1 extends StatelessWidget {
  Apply1(
      {super.key,
      required this.phoneNumberController,
      required this.birthDate,
      required this.studyLevel,
      required this.speciality});

  final phoneNumberController, birthDate, studyLevel, speciality;

  final _studyLevels = [
    '1st year',
    '2nd year',
    '3rd year',
    '4th year',
    '5th year'
  ];

  final _specialties = ['TIC', 'GCEM', 'ESB', 'PREPA'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormFieldWidget(phoneNumberController, AppStrings.kphoneNumber,
            TextInputType.phone),
        const SizedBox(height: AppSizes.ksmallSpace),
        DatePicker(birthDate: birthDate),
        const SizedBox(height: AppSizes.ksmallSpace),
        DropDownButton(
            title: AppStrings.kstudyLevel,
            items: _studyLevels,
            selectedItem: studyLevel),
        const SizedBox(height: AppSizes.ksmallSpace),
        DropDownButton(
            title: AppStrings.kspeciality,
            items: _specialties,
            selectedItem: speciality)
      ],
    );
  }
}
