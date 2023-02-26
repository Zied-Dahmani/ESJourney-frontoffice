import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/widgets/button.dart';
import 'package:esjourney/presentation/widgets/club/animated_detail_header.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';


// TODO Clean and understand the code, logic, hero image, stories, test on smaller device, and test with long & short club description

class ClubScreen extends StatefulWidget {
  const ClubScreen({Key? key, this.club}) : super(key: key);

  final club;

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
    return Scaffold(
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
                Text(widget.club.description,
                    style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppSizes.kbigSpace),
                Text(AppStrings.kstories,
                    style: theme.textTheme.headlineMedium),
              ],
            ),
          )),
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
                    padding: const EdgeInsets.only(right: AppSizes.ksmallSpace),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.kradius),
                        child: Image.network('$kbaseUrl${widget.club.image}',
                            fit: BoxFit.cover)),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.khugeSpace,vertical: AppSizes.kbigSpace),
              child: ButtonWidget(
                  text: AppStrings.kapply,
                  function: () {
                    Navigator.of(context).pushNamed(AppRoutes.applyToClubScreen);
                  }),
            ),
          )
        ],
      ),
    );

  }
}

class BuilderPersistentDelegate extends SliverPersistentHeaderDelegate {
  BuilderPersistentDelegate(
      {required double minExtent,
      required double maxExtent,
      required this.builder})
      : _minExtent = minExtent,
        _maxExtent = maxExtent;

  final double _minExtent, _maxExtent;
  final Widget Function(double percent) builder;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(shrinkOffset / _maxExtent);
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

// TODO Put it in the animations folder
class TranslateAnimation extends StatelessWidget {
  final Widget child;

  const TranslateAnimation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween(begin: 1.0, end: 0.0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutBack,
        builder: (context, value, _child) {
          return Transform.translate(
            offset: Offset(0.0, 100.0 * value),
            child: child,
          );
        },
        child: child);
  }
}
