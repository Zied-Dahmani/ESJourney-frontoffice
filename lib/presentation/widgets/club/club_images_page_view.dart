import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';

class ClubImagesPageView extends StatefulWidget {
  const ClubImagesPageView({Key? key, this.image}) : super(key: key);

  final image;

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
              itemCount: 3,
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              itemBuilder: (context, index) {
                final isSelected = _currentIndex == index;
                return AnimatedContainer(
                  duration: kThemeAnimationDuration,
                  margin: EdgeInsets.symmetric(
                      horizontal: AppSizes.ksmallSpace,
                      vertical: isSelected
                          ? AppSizes.ksmallSpace - 5
                          : AppSizes.kbigSpace),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.kradius),
                      image: DecorationImage(
                          image: NetworkImage('$kbaseUrl${widget.image}'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              theme.colorScheme.onPrimaryContainer,
                              BlendMode.darken))),
                );
              }),
        ),
        const SizedBox(height: AppSizes.ksmallSpace),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final isSelected = _currentIndex == index;
            return AnimatedContainer(
              duration: kThemeAnimationDuration,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 3,
              width: isSelected ? 20 : 10,
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.tertiary,
                borderRadius:
                const BorderRadius.all(Radius.circular(AppSizes.kradius)),
              ),
            );
          }),
        ),
        const SizedBox(height: AppSizes.ksmallSpace),
      ],
    );
  }
}
