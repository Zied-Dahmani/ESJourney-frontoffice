import 'package:esjourney/presentation/animations/club/custom_animated_opacity.dart';
import 'package:esjourney/presentation/animations/club/screen_animation_controller.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/widgets/club/apply_1.dart';
import 'package:esjourney/presentation/widgets/club/apply_2.dart';
import 'package:esjourney/presentation/widgets/club/apply_3.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ApplyToClubScreen extends StatefulWidget {
  const ApplyToClubScreen({Key? key}) : super(key: key);

  @override
  State<ApplyToClubScreen> createState() => _ApplyToClubScreenState();
}

class _ApplyToClubScreenState extends State<ApplyToClubScreen>
    with TickerProviderStateMixin {
  late final ScreenAnimationController _controller;

  List<String> titles = [AppStrings.kapplyToClubTitle1,AppStrings.kapplyToClubTitle2,AppStrings.kapplyToClubTitle3];
  int activeStep = 0;
  int upperBound = 2;

  final _phoneNumberController = TextEditingController();
  String _birthDate = AppStrings.kbirthDate;
  String? _studyLevel;
  String? _speciality;
  String _answer1='';
  String _answer2='';
  final _linkedInLinkController = TextEditingController();
  PlatformFile? _pdfFile;

  @override
  void initState() {
    super.initState();
    _controller = ScreenAnimationController(
      buttonController: AnimationController(
        duration: const Duration(milliseconds: 750),
        vsync: this,
      ),
      contentController: AnimationController(
        duration: const Duration(milliseconds: 750),
        vsync: this,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.buttonController.forward();
      await _controller.buttonController.reverse();
      await _controller.contentController.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final h = constraints.maxHeight;

      return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAnimatedOpacity(
            animation: _controller.topOpacityAnimation,
            child: AppBar(title: Text(titles[activeStep])),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                width: w,
                height: h * .89,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.kbigSpace),
                  child: Column(
                    children: [
                      CustomAnimatedOpacity(
                          animation: _controller.topOpacityAnimation,
                          child: IconStepper(
                            lineColor: theme.colorScheme.primary,
                            stepColor: theme.colorScheme.tertiary,
                            activeStepColor: theme.colorScheme.primary,
                            activeStepBorderColor: theme.colorScheme.primary,
                            enableStepTapping: false,
                            enableNextPreviousButtons: false,
                            icons: [
                              Icon(Icons.school,
                                  color: theme.colorScheme.onPrimary),
                              Icon(Icons.people,
                                  color: theme.colorScheme.onPrimary),
                              Icon(Icons.upload,
                                  color: theme.colorScheme.onPrimary),
                            ],
                            activeStep: activeStep,
                          )),
                      const SizedBox(height: AppSizes.kbigSpace),
                      CustomAnimatedOpacity(
                        animation: _controller.topOpacityAnimation,
                        child: content(),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 1,
                child: GestureDetector(
                  onTap: () => apply(),
                  child: AnimatedBuilder(
                    animation: _controller.buttonController,
                    builder: (_, child) {
                      final size = _controller
                          .buttonSizeAnimation(
                            Size(w * .8, AppSizes.kbuttonHeight),
                            Size(w * 1.2, h * 1.1),
                          )
                          .value;
                      final margin =
                          _controller.buttonMarginAnimation(h * .03).value;
                      return Container(
                        width: size.width,
                        height: size.height,
                        margin: EdgeInsets.only(bottom: margin),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppSizes.kradius)),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: h * .05,
                child: IgnorePointer(
                  child: Text(
                      activeStep != upperBound
                          ? AppStrings.kcontinue
                          : AppStrings.kapply,
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: theme.colorScheme.onPrimary)),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget content() {
    switch (activeStep) {
      case 0:
        return Apply1(
            phoneNumberController: _phoneNumberController,
            updateBirthdate: (String date) => _birthDate = date,
            updateStudyLevel: (String studyLevel) => _studyLevel = studyLevel,
            updateSpeciality: (String speciality) => _speciality = speciality);
      case 1:
        return  Apply2(updateAnswer1: (String answer1) => _answer1 = answer1, updateAnswer2:  (String answer2) => _answer2 = answer2);
      case 2:
        return Apply3(linkedInLinkController: _linkedInLinkController,updatePDFFile: (pdfFile) => _pdfFile = pdfFile);
      default:
        return const SizedBox();
    }
  }

  void apply()
  {
    if (_controller.buttonController.value == 0.0) {
      // TODO Logic
      if (activeStep == 0) {
        if (_phoneNumberController.text.isNotEmpty && _phoneNumberController.text.length != 8) {
          showErrorTopSnackBar(AppStrings.ktypeValidPhoneNumber);
        } else if (_phoneNumberController.text.isEmpty || _birthDate == AppStrings.kbirthDate || _studyLevel == null || _speciality == null) {
          showErrorTopSnackBar(AppStrings.kcompleteTheForm);
        }
        else
        {
          setState(() {
            activeStep++;
          });
        }
      } else if (activeStep == 1) {
        if(_answer1.isEmpty || _answer2.isEmpty)
        {
          showErrorTopSnackBar(AppStrings.kcompleteTheForm);
        }
        else
        {
          setState(() {
            activeStep++;
          });
        }
      } else {
        if(_linkedInLinkController.text.isNotEmpty && ! validator.url(_linkedInLinkController.text) )
        {
          showErrorTopSnackBar(AppStrings.ktypeValidLink);
        }
        else if(_linkedInLinkController.text.isEmpty || _pdfFile == null)
        {
          showErrorTopSnackBar(AppStrings.kcompleteTheForm);
        }
        else{
          Navigator.of(context).pushNamed(AppRoutes.doneScreen);
        }
      }
    }
  }

  void showErrorTopSnackBar(String message)
  {
    showTopSnackBar(
      Overlay.of(context)!,
      CustomSnackBar.error(
        message: message,
      ),
    );
  }
}
