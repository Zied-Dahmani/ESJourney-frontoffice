import 'package:esjourney/utils/strings.dart';
import 'package:flutter/material.dart';

class ApplyToClubScreen extends StatefulWidget {
  const ApplyToClubScreen({Key? key}) : super(key: key);

  @override
  State<ApplyToClubScreen> createState() => _ApplyToClubScreenState();
}

class _ApplyToClubScreenState extends State<ApplyToClubScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(AppStrings.kapply),
      ),
      // TODO Stepper
      body: Container()
    );
  }
}
