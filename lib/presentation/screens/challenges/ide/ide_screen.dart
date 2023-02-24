import 'dart:async';
import 'dart:convert';

import 'package:code_text_field/code_text_field.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';

// Import the language & theme
import 'package:highlight/languages/dart.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class IdeScreen extends StatefulWidget {
  @override
  _IdeScreenState createState() => _IdeScreenState();
}

class _IdeScreenState extends State<IdeScreen> {
  CodeController? _codeController;
  String script = "";
  String output = "";
  String desiredOutput = "a";

  @override
  void initState() {
    super.initState();
    final script = "#include <stdio.h>\n\nint main() {\n}";

    // Instantiate the CodeController

    _codeController = CodeController(
      text: script,
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
        "printf":
            const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),

        // Matches the scanf function
        "scanf":
            const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),

        // Matches the main function
        "main":
            const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      },
    );
    data = [
      _ChartData('9.5%', 12) ,
      _ChartData('10.5%', 12),
      _ChartData('11.5%', 12),
      _ChartData('12.5%', 20),
      _ChartData('13.5%', 12),
      _ChartData('14.5%', 12),
      _ChartData('15.5%', 12),
      _ChartData('16.5%', 12),

    ];
    _tooltip = TooltipBehavior(enable: true);
  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  Widget build(BuildContext context) {
    final double width = ScreenSize.width(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: CodeField(
                onChanged: (value) {
                  if (value != null) {
                    script = value;
                  }
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
                        print("value: $value");
                        output = value!;
                      });
                    });

                    print("success");
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          content: Container(
                            height: width * 0.7,
                            width: width * 0.7,
                            color: Colors.white,
                            child: Container(
                              color: Colors.white,
                              height: width * 0.7,
                              width: width * 0.7,
                              child: SfCartesianChart(
                                plotAreaBorderWidth: 0,
                                borderWidth: 0,

                                plotAreaBackgroundColor: Colors.white,
                                borderColor: Colors.transparent,
                                primaryXAxis: CategoryAxis(
                                    isVisible: false,
                                    majorGridLines:
                                        const MajorGridLines(width: 0)),
                                primaryYAxis: NumericAxis(
                                    isVisible: false,
                                    minimum: 0,
                                    maximum: 50,
                                    interval: 50),
                                tooltipBehavior: _tooltip,
                                series: <ChartSeries<_ChartData, String>>[
                                  ColumnSeries<_ChartData, String>(
                                      dataSource: data,
                                      xValueMapper: (_ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (_ChartData data, _) =>
                                          data.y,
                                      name: '',
                                      //borderWidth: 0,

                                      color: Color.fromRGBO(8, 142, 255, 1))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );

                    // Your code here
                  },
                  backgroundColor: Color(0xFFEB4A5A),
                  child: Icon(Icons.play_arrow),
                  shape: CircleBorder(),
                )),
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
      print("bbbb ${responseBody['memory']}");
      print("bbbb ${responseBody['cpuTime']}");
      return responseBody['output'];
    } else if (responseBody.containsKey('message')) {
      return responseBody['message'];
    }
  }
  return null;
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

// return Scaffold(
//
// body: Center(
// child: Container(
// height: 400,
//
// color: Colors.red,
//
// child: SfCartesianChart(
//
// primaryXAxis: CategoryAxis(),
// primaryYAxis: NumericAxis(minimum: 0, maximum: 50, interval: 50 ),
// tooltipBehavior: _tooltip,
// series: <ChartSeries<_ChartData, String>>[
// ColumnSeries<_ChartData, String>(
// dataSource: data,
// xValueMapper: (_ChartData data, _) => data.x,
// yValueMapper: (_ChartData data, _) => data.y,
// name: '',
// color: Color.fromRGBO(8, 142, 255, 1))
// ]),
// ),
// ));
