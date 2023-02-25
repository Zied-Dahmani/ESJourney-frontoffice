import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';

class TimelineDotAndCard extends StatefulWidget {
  const TimelineDotAndCard(
      {Key? key,
      this.isSelected = false,
      this.displayCard = false,
      this.left = false,
      required this.delay,
      required this.text})
      : super(key: key);

  final bool isSelected, displayCard, left;
  final delay,text;

  @override
  State<TimelineDotAndCard> createState() => _TimelineDotAndCardState();
}

class _TimelineDotAndCardState extends State<TimelineDotAndCard> {
  bool _animated = false;

  void _animateWithDelay() async {
    if (widget.displayCard) {
      await Future.delayed(widget.delay);
      setState(() {
        _animated = true;
      });
    }
  }

  @override
  void didUpdateWidget(covariant TimelineDotAndCard oldWidget) {
    _animateWithDelay();
    super.didUpdateWidget(oldWidget);
  }

  Widget _buildCard() => TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: ScreenSize.width(context) / 3,
        color: Theme.of(context).colorScheme.tertiary,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.ksmallSpace),
          child: Text(widget.text,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 10)),
        ),
      ),
      builder: (context, value, child) {
        return Transform.scale(alignment: widget.left ? Alignment.centerRight: Alignment.centerLeft ,scale: value, child: child);
      });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        if (_animated && widget.left) ...[
          _buildCard(),
          Container(
            width: 20,
            height: 2,
            color: theme.colorScheme.tertiary,
          ),
        ],
        Container(
          height: AppSizes.ktimelineDotSize,
          width: AppSizes.ktimelineDotSize,
          decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.tertiary),
              shape: BoxShape.circle,
              color: theme.colorScheme.background),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
                backgroundColor: widget.isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline),
          ),
        ),
        if (_animated && !widget.left) ...[
          Container(
            width: 20,
            height: 2,
            color: theme.colorScheme.tertiary,
          ),
          _buildCard(),
        ],
      ],
    );
  }
}
