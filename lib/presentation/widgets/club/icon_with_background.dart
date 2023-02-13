import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';

class IconWithBackground extends StatelessWidget {
  const IconWithBackground({Key? key, this.icon, this.function}) : super(key: key);

  final icon,function;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    return Positioned(
      top: height / 15,
      left: 20,
      child: GestureDetector(
        onTap: () => function(),
        child: Container(
            height: AppSizes.kiconBackgroundSize,
            width: AppSizes.kiconBackgroundSize,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius:
              const BorderRadius.all(Radius.circular(AppSizes.kradius)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Icon(icon, color: theme.colorScheme.onPrimary),
            )),
      ),
    );
  }
}
