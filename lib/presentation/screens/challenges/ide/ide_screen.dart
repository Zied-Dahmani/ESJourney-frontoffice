import 'dart:async';
import 'dart:convert';

import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';

// Import the language & theme
import 'package:highlight/languages/dart.dart';
import 'package:http/http.dart' as http;

class IdeScreen extends StatefulWidget {
  @override
  _IdeScreenState createState() => _IdeScreenState();
}

class _IdeScreenState extends State<IdeScreen> {
  CodeController? _codeController;
String script = "";
String output = "";
  @override
  void initState() {
    super.initState();
    final source = "#include <stdio.h>\n\nint main() {\n}";

    // Instantiate the CodeController

    _codeController = CodeController(
      text: source,
      language: dart,
      patternMap: {
        r'"(?:[^"\\]|\\.)*"': const TextStyle(color: Colors.yellow),

        // Matches C function calls with parentheses
        r'\w+\s*\([^)]*\)': const TextStyle(color: Colors.green),

        // Matches C keywords
        r'\b(?:void|char|int|float|double|if|else|while|for|do|switch|case|break|continue|return)\b':
            const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      },
      stringMap: {
        "printf": const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),

        // Matches the scanf function
        "scanf": const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),

        // Matches the main function
        "main": const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      },
    );
  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height*0.6,
              child: CodeField(

                onChanged: (value) {
                  script = value;
                },

                controller: _codeController!,
                textStyle: const TextStyle(fontFamily: 'SourceCode'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: FloatingActionButton(
                onPressed: () {
                  print("clicked");
                  print("script: $script");
                  sendApiRequest(script).then((value) {
                    setState(() {
                      output = value!;
                    });
                  });
                  // Your code here
                },
                backgroundColor: Color(0xFFEB4A5A),
                child: Icon(Icons.play_arrow),
                shape: CircleBorder(),
              )

            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Result",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),

           Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                output,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),


        ],
      ),

    );
  }
}

Future<String?> sendApiRequest(String code) async {
  var url = 'https://api.jdoodle.com/v1/execute';
  var headers = {'Content-Type': 'application/json'};

  var program = {
    "script": code,
    "language": "c",
    "versionIndex": "0",
    "clientId": "68a2260a9f54c29a85601341de6209e9",
    "clientSecret":
        "349b0b5a856a562a7ba4a9bbaec6d07633bacf2488a40c742ce27308a3517df5"
  };

  var response = await http.post(Uri.parse(url),
      headers: headers, body: json.encode(program));

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    if (responseBody.containsKey('output')) {
      print("aaa ${responseBody['output']}");
      return responseBody['output'];
    } else if (responseBody.containsKey('message')) {
      return responseBody['message'];
    }
  }

  return null;
}
