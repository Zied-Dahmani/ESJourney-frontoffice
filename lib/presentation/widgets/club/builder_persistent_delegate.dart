import 'package:flutter/material.dart';

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
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
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
