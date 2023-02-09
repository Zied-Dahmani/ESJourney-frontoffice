import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget(this.controller, this.labelText, this.inputType,
      {super.key});

  final controller, labelText, inputType;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
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
      child: TextFormField(
        obscureText: _isObscure,
        controller: widget.controller,
        validator: (val) {
          if (val!.isEmpty) {
            return '${AppStrings.ktypeYour} ${widget.labelText.toString().toLowerCase()}!';
          }
          return null;
        },
        cursorColor: Colors.black,
        keyboardType: widget.inputType,
        style: TextStyle(
          color: theme.colorScheme.secondary,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20.0),
          suffixIcon: widget.inputType == TextInputType.visiblePassword
              ? IconButton(
                  icon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      // password eye icon
                      _isObscure ? Icons.visibility_off : Icons.visibility,

                      color: theme.colorScheme.tertiary,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: theme.colorScheme.tertiary,
            fontFamily: 'VisbyRoundCF',
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: theme.colorScheme.tertiary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: theme.colorScheme.tertiary,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
