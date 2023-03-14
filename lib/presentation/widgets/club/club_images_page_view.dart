import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';

class ClubImagesPageView extends StatefulWidget {
  const ClubImagesPageView({Key? key, this.images}) : super(key: key);

  final images;

  @override
  State<ClubImagesPageView> createState() => _ClubImagesPageViewState();
}

class _ClubImagesPageViewState extends State<ClubImagesPageView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: PageController(viewportFraction: .9),
              itemCount: widget.images.length,
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              itemBuilder: (context, index) {
                final isSelected = _currentIndex == index;
                return Hero(
                  tag: widget.images[index],
                  child: AnimatedContainer(
                    duration: kThemeAnimationDuration,
                    margin: EdgeInsets.symmetric(
                        horizontal: AppSizes.ksmallSpace,
                        vertical: isSelected
                            ? AppSizes.ksmallSpace - 5
                            : AppSizes.kbigSpace),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.kradius),
                        image: DecorationImage(
                            image: NetworkImage('$kbaseUrl${widget.images[index]}'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                theme.colorScheme.onPrimaryContainer,
                                BlendMode.darken))),
                  ),
                );
              }),
        ),
        const SizedBox(height: AppSizes.ksmallSpace),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.images.length, (index) {
            final isSelected = _currentIndex == index;
            return AnimatedContainer(
              duration: kThemeAnimationDuration,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: AppSizes.kdividerHeight * 1.5,
              width: isSelected ? AppSizes.kbigSpace : AppSizes.ksmallSpace,
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.tertiary,
                borderRadius: const BorderRadius.all(Radius.circular(AppSizes.kradius)),
              ),
            );
          }),
        ),
        const SizedBox(height: AppSizes.ksmallSpace)
      ],
    );
  }
}
