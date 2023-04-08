import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget(
    this.controller,
    this.labelText,
    this.inputType, {
    super.key,
    this.onChanged,
    this.isLoading = false,
    this.icon,
  });

  final controller, labelText, inputType;
  final void Function(String)? onChanged;
  final IconData? icon;
  final bool isLoading;

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool _isObscure = false;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.inputType == TextInputType.visiblePassword;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextFormField(
            obscureText: _isObscure,
            controller: widget.controller,
            onChanged: widget.onChanged,
            validator: (val) {
              if (val!.isEmpty) {
                return '${AppStrings.ktypeYour} ${widget.labelText.toLowerCase()}!';
              }
              return null;
            },
            cursorColor: theme.colorScheme.secondary,
            keyboardType: widget.inputType,
            style: TextStyle(
              color: theme.colorScheme.secondary,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(AppSizes.kbigSpace),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: widget.labelText,
            ),
          ),
          if (widget.isLoading)
            Container(
              margin: const EdgeInsets.only(right: AppSizes.kbigSpace),
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.secondary),
              ),
            ),
          if (!widget.isLoading && widget.icon != null)
            IconButton(
              icon: Icon(
                widget.icon,
                color: theme.colorScheme.tertiary,
              ),
              onPressed: () {},
            )
        ],
      ),
    );
  }
}
