import 'dart:io';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/widgets/button.dart';
import 'package:esjourney/presentation/widgets/club/icon_with_background.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';

class ClubScreen extends StatelessWidget {
  const ClubScreen({Key? key, this.club}) : super(key: key);

  final club;

  // TODO Build UI
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(bottom: AppSizes.khugeSpace),
      color: theme.colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Hero(
                tag: club.image,
                child: Container(
                  height: ScreenSize.height(context) / 2.5,
                  width: ScreenSize.width(context),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(AppSizes.kradius),
                        bottomRight: Radius.circular(AppSizes.kradius)),
                    image: DecorationImage(
                      image: NetworkImage('$kbaseUrl${club.image}'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              IconWithBackground(
                icon: Platform.isIOS
                    ? Icons.arrow_back_ios_new
                    : Icons.arrow_back,
                function: () => Navigator.of(context).pop(),
              ),
              Positioned(
                bottom: 10,
                left: 20,
                child: Hero(
                    tag: club.name,
                    child: Text(club.name,
                        style: theme.textTheme.headlineMedium!.copyWith(
                            color: theme.colorScheme.onPrimary,
                            shadows: [
                              const Shadow(
                                offset: Offset(3.0, 3.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(200, 0, 0, 0),
                              )
                            ]))),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kbigSpace, vertical: AppSizes.kbigSpace),
            child: Text(club.description,
                style: theme.textTheme.bodySmall),
          ),
          const Spacer(),
          ButtonWidget(
              text: AppStrings.kapply,
              function: () {
                 Navigator.of(context).pushNamed(AppRoutes.applyToClubScreen);
              }),
        ],
      ),
    );
  }
}
