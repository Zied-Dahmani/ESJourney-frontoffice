// Add this import at the top of your file
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Create a new StatefulWidget for the poll creation form
class PollCreationForm extends StatefulWidget {
  final void Function(String question, List<String> options) onSubmit;

  const PollCreationForm({required this.onSubmit});

  @override
  _PollCreationFormState createState() => _PollCreationFormState();
}

class _PollCreationFormState extends State<PollCreationForm> {
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = [];
  int _numberOfOptions = 2;

  void _submitPoll() {
    String question = _questionController.text;
    List<String> options = _optionControllers.map((controller) => controller.text).toList();

    widget.onSubmit(question, options);
  }

  void _addOption() {
    setState(() {
      _numberOfOptions += 1;
      _optionControllers.add(TextEditingController());
    });
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _numberOfOptions; i++) {
      _optionControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _optionControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Question', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: _questionController),
            const SizedBox(height: 10),
            const Text('Options', style: TextStyle(fontWeight: FontWeight.bold)),
            ..._optionControllers.map((controller) => TextField(controller: controller)).toList(),
            TextButton(onPressed: _addOption, child: const Text('Add Option')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _submitPoll, child: const Text('Submit Poll')),
          ],
        ),
      ),
    );
  }
}
