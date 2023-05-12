import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ClubsList extends StatefulWidget {
  const ClubsList({Key? key, required this.clubs}) : super(key: key);

  final clubs;

  @override
  State<ClubsList> createState() => _ClubsListState();
}

class _ClubsListState extends State<ClubsList> {
  late final PageController _cardPageController;
  late final PageController _detailsPageController;

  double _cardPage = 0.0;
  int _cardIndex = 0;
  final _showDetails = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _cardPageController = PageController(viewportFraction: 0.77)
      ..addListener(_cardPagePercentListener);
    _detailsPageController = PageController();
  }

  _cardPagePercentListener() {
    setState(() {
      _cardPage = _cardPageController.page!;
      _cardIndex = _cardPageController.page!.round();
    });
  }

  @override
  void dispose() {
    _cardPageController
      ..removeListener(_cardPagePercentListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          height: ScreenSize.height(context) / 2,
          width: ScreenSize.width(context),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: PageView.builder(
              controller: _cardPageController,
              clipBehavior: Clip.none,
              itemCount: widget.clubs.length,
              onPageChanged: (page) {
                _detailsPageController.animateToPage(
                  page,
                  duration: const Duration(milliseconds: 500),
                  curve: const Interval(0.25, 1, curve: Curves.decelerate),
                );
              },
              itemBuilder: (_, index) {
                final item = widget.clubs[index];
                final progress = (_cardPage - index);
                final scale = ui.lerpDouble(1, .8, progress.abs())!;
                final isCurrentPage = index == _cardIndex;
                final isScrolling =
                    _cardPageController.position.isScrollingNotifier.value;
                final isFirstPage = index == 0;

                return Transform.scale(
                  alignment: Alignment.lerp(
                    Alignment.topLeft,
                    Alignment.center,
                    -progress,
                  ),
                  scale: isScrolling && isFirstPage ? 1 - progress : scale,
                  child: GestureDetector(
                    onTap: () {
                      _showDetails.value = !_showDetails.value;
                      const transitionDuration = Duration(milliseconds: 550);
                      Navigator.of(context).pushNamed(AppRoutes.clubScreen, arguments: item);
                      Future.delayed(transitionDuration, () {
                        _showDetails.value = !_showDetails.value;
                      });
                    },
                    child: Hero(
                      tag: item.images[0],
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        transform: Matrix4.identity()
                          ..translate(
                            isCurrentPage ? 0.0 : -20.0,
                            isCurrentPage ? 0.0 : 60.0,
                          ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppSizes.kradius)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              offset: const Offset(5, 25),
                              color: theme.colorScheme.onBackground.withOpacity(.65),
                            ),
                          ],
                          image: DecorationImage(
                            image: NetworkImage('$kbaseUrl${item.images[0]}'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: AppSizes.khugeSpace),
        Expanded(
          child: PageView.builder(
            controller: _detailsPageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.clubs.length,
            itemBuilder: (_, index) {
              final item = widget.clubs[index];
              final opacity = (_cardPage - index).abs();

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSizes.kbigSpace),
                child: Opacity(
                  opacity: (1 - opacity).abs(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: item.name,
                        child: Text(
                          item.name,
                          style: theme.textTheme.headlineMedium,
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _showDetails,
                        builder: (_, value, __) {
                          return Visibility(
                            visible: value,
                            child: Text(
                              item.shortDescription,
                              overflow: ScreenSize.height(context) < 600 ? TextOverflow.ellipsis : null,
                              style: theme.textTheme.bodySmall,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
