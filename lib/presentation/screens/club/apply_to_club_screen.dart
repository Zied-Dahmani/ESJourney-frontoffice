import 'package:esjourney/presentation/animations/club/custom_animated_opacity.dart';
import 'package:esjourney/presentation/animations/club/screen_animation_controller.dart';
import 'package:esjourney/presentation/router/routes.dart';
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

class _ApplyToClubScreenState extends State<ApplyToClubScreen>
    with TickerProviderStateMixin {
  late final ScreenAnimationController _controller;

  List<String> titles = ['Personal informations', 'Why us? ', 'Resume'];
  int activeStep = 0;
  int upperBound = 2;

  final _phoneNumberController = TextEditingController();
  String _birthDate = AppStrings.kbirthDate;
  String? _studyLevel;
  String? _speciality;
  final _linkedInLinkController = TextEditingController();

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
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
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
                height: h * .85,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.kbigSpace),
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
                  onTap: () {
                    if(_controller.buttonController.value==0.0) {
                      // TODO Logic
                      if (activeStep == 0) {
                        setState(() {
                          activeStep++;
                        });
                      } else if (activeStep == 1) {
                        setState(() {
                          activeStep++;
                        });
                      } else {
                        Navigator.of(context).pushNamed(AppRoutes.doneScreen);
                        // bool _isValidURL = Uri.parse(_linkedInLinkController.text).isAbsolute;
                      }
                    }
                  },
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
