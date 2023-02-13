import 'package:esjourney/presentation/widgets/button.dart';
import 'package:esjourney/presentation/widgets/club/apply_1.dart';
import 'package:esjourney/presentation/widgets/club/apply_2.dart';
import 'package:esjourney/presentation/widgets/club/apply_3.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

class ApplyToClubScreen extends StatefulWidget {
  const ApplyToClubScreen({Key? key}) : super(key: key);

  @override
  State<ApplyToClubScreen> createState() => _ApplyToClubScreenState();
}

class _ApplyToClubScreenState extends State<ApplyToClubScreen> {

  List<String> titles = ['Personal informations', 'Why us? ', 'Resume'];
  int activeStep = 0;
  int upperBound = 2;

  final _phoneNumberController = TextEditingController();
  String _birthDate = AppStrings.kbirthDate;
  String? _studyLevel;
  String? _speciality;
  final _linkedInLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(titles[activeStep]),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: const EdgeInsets.only(
              right: AppSizes.kbigSpace,
              left: AppSizes.kbigSpace,
              bottom: AppSizes.khugeSpace),
          color: theme.colorScheme.background,
          child: Column(
            children: [
              IconStepper(
                lineColor: theme.colorScheme.primary,
                stepColor: theme.colorScheme.tertiary,
                activeStepColor: theme.colorScheme.primary,
                activeStepBorderColor: theme.colorScheme.primary,
                enableStepTapping: false,
                enableNextPreviousButtons: false,
                icons: [
                  Icon(Icons.school, color: theme.colorScheme.onPrimary),
                  Icon(Icons.people, color: theme.colorScheme.onPrimary),
                  Icon(Icons.upload, color: theme.colorScheme.onPrimary),
                ],
                activeStep: activeStep,
              ),
              const SizedBox(height: AppSizes.kbigSpace),
              content(),
              const Spacer(),
              ButtonWidget(
                  text: activeStep != upperBound
                      ? AppStrings.kcontinue
                      : AppStrings.kapply,
                  function: () {
                    // TODO Logic
                    setState(() {
                      activeStep++;
                    });
                    if (activeStep == 0) {
                    } else if (activeStep == 1) {
                    } else {
                      // bool _isValidURL = Uri.parse(_linkedInLinkController.text).isAbsolute;
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget content() {
    switch (activeStep) {
      case 0:
        return Apply1(
            birthDate: _birthDate,
            phoneNumberController: _phoneNumberController,
            studyLevel: _studyLevel,
            speciality: _speciality);
      case 1:
        return const Apply2();
      case 2:
        return Apply3(linkedInLinkController: _linkedInLinkController);
      default:
        return const SizedBox();
    }
  }
}
