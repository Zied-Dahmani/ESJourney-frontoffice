import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';

class Apply2 extends StatelessWidget {
  const Apply2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.kWhyWouldYouLikeToJoinUs),
        const SizedBox(height: AppSizes.ksmallSpace),
        TextField(
          minLines: 4,
          maxLines: 4,
          cursorColor: theme.colorScheme.secondary,
          style: theme.textTheme.bodySmall,
          keyboardType: TextInputType.multiline,
        ),
        const SizedBox(height: AppSizes.ksmallSpace),
        const Text(AppStrings.kdoYouHaveXP),
        const SizedBox(height: AppSizes.ksmallSpace),
        TextField(
          minLines: 4,
          maxLines: 4,
          cursorColor: theme.colorScheme.secondary,
          style: theme.textTheme.bodySmall,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }
}
