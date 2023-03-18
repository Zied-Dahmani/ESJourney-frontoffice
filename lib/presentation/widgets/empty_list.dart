import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({Key? key, required this.text}) : super(key: key);

  final text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: AppSizes.khugeImageSize,
            width: AppSizes.khugeImageSize,
            child: SvgPicture.asset('assets/images/sad.svg')),
        const SizedBox(height: AppSizes.kbigSpace),
        Text(text, style: Theme.of(context).textTheme.bodyMedium!)
      ],
    );
  }
}
