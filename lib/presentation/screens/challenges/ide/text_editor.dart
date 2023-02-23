import 'package:flutter/material.dart';

class CodeEditor extends StatefulWidget {
  @override
  _CodeEditorState createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  TextEditingController _controller = TextEditingController();
  List<String> _lines = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);

  }

  void _onTextChanged() {
    setState(() {
      _lines = _controller.text.split('\n');
    });
  }

  String get text => _controller.text;

  set text(String newText) {
    setState(() {
      _controller.text = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Line numbers
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1.0,
                ),
              ),
            ),
            child: Column(
              children: [
                for (int i = 1; i <= _lines.length; i++)
                  Text('$i', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          // Code editor
          Expanded(
            child: TextField(
              controller: _controller,
              maxLines: null,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,

              ),
              style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 16.0,
                color: Colors.white,

              ),
            ),
          ),
        ],
      ),
    );
  }
}


