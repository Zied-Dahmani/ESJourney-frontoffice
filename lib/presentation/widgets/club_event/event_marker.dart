import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventMarker extends StatelessWidget {
  const EventMarker({Key? key, this.isSelected = false}) : super(key: key);

  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final size = isSelected
        ? AppSizes.kmarkerSizeExpanded
        : AppSizes.kmarkerSizeShrinked;
    return Center(
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: const Duration(milliseconds: 400),
        child: SvgPicture.asset('assets/images/marker.svg'),
      ),
    );
  }
}
