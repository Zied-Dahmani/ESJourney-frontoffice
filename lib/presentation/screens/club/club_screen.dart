import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/screens/zoom_drawer_screen.dart';
import 'package:esjourney/presentation/widgets/button.dart';
import 'package:esjourney/presentation/widgets/club/animated_detail_header.dart';
import 'package:esjourney/presentation/widgets/club/builder_persistent_delegate.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ClubScreen extends StatefulWidget {
  ClubScreen({Key? key, this.club}) : super(key: key);

  var club;

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 250);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(AppRoutes.zoomDrawerScreen);
        return true;
      },
      child: Scaffold(
        body: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          slivers: [
            SliverPersistentHeader(
                pinned: true,
                delegate: BuilderPersistentDelegate(
                    minExtent: 240,
                    maxExtent: ScreenSize.height(context),
                    builder: (percent) {
                      return AnimatedDetailHeader(
                        club: widget.club,
                        topPercent: ((1 - percent) / .7).clamp(0.0, 1.0),
                        bottomPercent: (percent / .3).clamp(0.0, 1.0),
                      );
                    })),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.kbigSpace, vertical: AppSizes.ksmallSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.kdescription,
                      style: theme.textTheme.headlineMedium),
                  const SizedBox(height: AppSizes.ksmallSpace),
                  Text(widget.club.fullDescription,
                      style: theme.textTheme.bodyMedium),
                  const SizedBox(height: AppSizes.kbigSpace),
                  Text(AppStrings.kstories,
                      style: theme.textTheme.headlineMedium),
                ],
              ),
            )),
            // TODO Stories
            SliverToBoxAdapter(
              child: SizedBox(
                height: AppSizes.kbigImageSize,
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSizes.kbigSpace),
                  scrollDirection: Axis.horizontal,
                  itemExtent: 150,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.ksmallSpace * .5),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSizes.kradius),
                          child: Image.network(
                              '$kbaseUrl${widget.club.images[index]}',
                              fit: BoxFit.cover)),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.khugeSpace,
                    vertical: AppSizes.kbigSpace),
                child: ButtonWidget(
                    text: AppStrings.kapply,
                    function: () {
                      if (widget.club.deadline.compareTo(DateTime.now()) > 0) {
                        Navigator.of(context).pushNamed(AppRoutes.applyToClubScreen);
                      } else {
                        showTopSnackBar(
                          Overlay.of(context)!,
                          const CustomSnackBar.error(
                            message: AppStrings.kdeadlineHasGonePast,
                          ),
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
