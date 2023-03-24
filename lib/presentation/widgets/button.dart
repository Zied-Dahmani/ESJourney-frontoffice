import 'package:esjourney/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    this.text,
    this.image,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.height = AppSizes.kbuttonHeight - 5,
    this.width,
    this.function,
    this.isDisabled = false,
  }) : super(key: key);

  final text, image, icon, backgroundColor, textColor, height, width;
  final void Function()? function;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: width - 70,
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
            backgroundColor != null
                ? theme.colorScheme.onPrimary.withOpacity(0.4)
                : theme.colorScheme.onPrimary.withOpacity(0.2),
          ),
          backgroundColor: isDisabled
              ? MaterialStateProperty.all(Colors.grey)
              : MaterialStateProperty.all(
            backgroundColor ?? theme.colorScheme.primary,
          ),
        ),
        onPressed: isDisabled ? null : () => function?.call(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null) ...[
              Image.asset(image,
                  height: AppSizes.kiconSize, width: AppSizes.kiconSize),
              const SizedBox(width: AppSizes.ksmallSpace)
            ],
            if (icon != null) ...[
              Icon(icon, color: textColor ?? theme.colorScheme.primary),
              const SizedBox(width: AppSizes.ksmallSpace)
            ],
            Text(
              text,
              style: theme.textTheme.bodyMedium!.copyWith(
                  color: isDisabled
                      ? theme.disabledColor
                      : theme.colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

