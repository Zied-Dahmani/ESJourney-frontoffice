import 'package:flutter/material.dart';

class LeaderboardHistory extends StatefulWidget {
  final List<String> buttonLabels;
  final void Function()? onThisWeekPressed;
  final void Function()? onMonthPressed;
  final void Function()? onAllTimePressed;

  const LeaderboardHistory({
    Key? key,
    required this.buttonLabels,
    this.onThisWeekPressed,
    this.onMonthPressed,
    this.onAllTimePressed,
  }) : super(key: key);

  @override
  _LeaderboardHistoryState createState() => _LeaderboardHistoryState();
}

class _LeaderboardHistoryState extends State<LeaderboardHistory> {
  int selectedButtonIndex = 0;

  void _onButtonPressed(int buttonIndex) {
    setState(() {
      selectedButtonIndex = buttonIndex;
    });
    // Call the corresponding callback function based on the buttonIndex
    switch (buttonIndex) {
      case 0:
        widget.onThisWeekPressed?.call();
        break;
      case 1:
        widget.onMonthPressed?.call();
        break;
      case 2:
        widget.onAllTimePressed?.call();
        break;
    // Add more cases for additional buttons if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: theme.colorScheme.onPrimary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.buttonLabels.length, (index) {
              return _buildButton(index, widget.buttonLabels[index]);
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(int buttonIndex, String buttonLabel) {
    final isSelected = buttonIndex == selectedButtonIndex;
    return InkWell(
      onTap: () => _onButtonPressed(buttonIndex),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 11.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3C4150) : null,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text(
          buttonLabel,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontFamily: 'VisbyRoundCF',
            fontSize: isSelected ? 16.0 : 13.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}