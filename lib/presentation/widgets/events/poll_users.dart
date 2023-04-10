import 'package:flutter/material.dart';

class PollResult extends StatefulWidget {
  final String question;
  final List<String> options;
  final Map<String, int> votes;
  final int displayTime;
  final Function(String) onVote;
  final String? votedOption;
  final VoidCallback onClose;
  const PollResult({
    Key? key,
    required this.question,
    required this.options,
    required this.votes,
    required this.displayTime,
    required this.onVote,
    required this.votedOption,
    required this.onClose,
  }) : super(key: key);

  @override
  _PollResultState createState() => _PollResultState();
}

class _PollResultState extends State<PollResult> {
  int _remainingTime = 0;
  bool _showResults = false;

  String? get _votedOption => widget.votedOption;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.displayTime;
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: widget.onClose,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...widget.options.map((option) {
            final isSelected = _votedOption == option;
            final votes = widget.votes[option] ?? 0;
            final totalVotes = widget.votes.values.fold(0, (acc, value) => acc + value);
            final percentage = totalVotes > 0 ? votes / totalVotes * 100 : 0;

            return InkWell(
              onTap: _showResults ? null : () => widget.onVote(option),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: isSelected ? Colors.blue.withOpacity(0.2) : null,
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 18,
                          color: isSelected ? Colors.blue : null,
                        ),
                      ),
                    ),
                    if (_showResults)
                      Text(
                        '$votes votes (${percentage.toStringAsFixed(1)}%)',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _remainingTime--;
        if (_remainingTime == 0) {
          _showResults = true;
        }
        if (_remainingTime > 0) {
          _startTimer();
        }
      });
    });
  }
}
