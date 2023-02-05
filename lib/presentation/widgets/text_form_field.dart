import 'package:esjourney/utils/strings.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      this.controller, this.icon, this.labelText, this.inputType,
      {super.key});
  final controller, icon, labelText, inputType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        validator: (val) {
          if (val!.isEmpty) {
            return '${AppStrings.ktypeYour} ${labelText.toString()
                .toLowerCase()}!';
          }
          return null;
        },
        cursorColor: theme.colorScheme.secondary,
        keyboardType: inputType,
        style:  TextStyle(
          color: theme.colorScheme.tertiary,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.secondary),
          labelText: labelText,
        ),
      ),
    );
  }
}