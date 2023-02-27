import 'dart:async';
import 'dart:convert';

import 'package:code_text_field/code_text_field.dart';
import 'package:esjourney/logic/cubits/challenges/coding_problem_cubit.dart';
import 'package:esjourney/logic/cubits/challenges/coding_problem_state.dart';
import 'package:esjourney/logic/cubits/challenges/submission_cubit.dart';
import 'package:esjourney/logic/cubits/challenges/submission_state.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  String result = "";
  String output = "";
  int memory = 0;

  @override
  void initState() {
    super.initState();
    script = "#include <stdio.h>\n\nint main() {\n}";
    // Instantiate the CodeController
    _codeController = CodeController(
      text: script,
      language: dart,
      patternMap: {
        r'"(?:[^"\\]|\\.)*"': const TextStyle(color: Colors.deepPurple),
        r'\w+\s*\([^)]*\)': const TextStyle(color: Colors.green),
        r'\b(?:void|char|int|float|double|if|else|while|for|do|switch|case|break|continue|return)\b':
            const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      },
      stringMap: {
        "printf":
            const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        "scanf":
            const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        "main":
            const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      },
    );
    data = [
      _ChartData('9.5%', 12),
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
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colorScheme.background,
      body: Builder(
        builder: (context) {
          final codingProblemState = context.watch<CodingProblemCubit>().state;
          final submissionState = context.watch<SubmissionCubit>().state;
          final userState = context.watch<UserCubit>().state;
          final user = userState is UserLogInSuccess ? userState.user : null;

          if (codingProblemState is CodingProblemLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (codingProblemState is CodingProblemSuccess) {
            output =
                codingProblemState.codingProblems.output.trim().toLowerCase();
            return Column(
              children: [
                SizedBox(
                  height: width * 0.06,
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: CodeField(
                      background: theme.colorScheme.background,
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
                      child: Column(
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              // code to handle FAB press
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      content: Text(
                                        codingProblemState
                                            .codingProblems.description,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontFamily: 'VisbyRoundCF',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    );
                                  });
                            },
                            backgroundColor: const Color(0xFFEB4A5A),
                            shape: const CircleBorder(),
                            child: const Icon(Icons.info_outlined),
                          ),
                          SizedBox(
                            height: width * 0.03,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              sendApiRequest(script).then((value) {
                                setState(() {
                                  var memoryInt = int.parse(value[1]!);
                                  result = value[0]!;
                                  memory = memoryInt.toInt();
                                });
                              }).then((value) {
                                if (result.trim().toLowerCase() == output) {
                                  BlocProvider.of<SubmissionCubit>(context)
                                      .submit(
                                          codingProblemState.codingProblems.id,
                                          user!.token!,
                                          memory);
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
                                              plotAreaBackgroundColor:
                                                  Colors.white,
                                              borderColor: Colors.transparent,
                                              primaryXAxis: CategoryAxis(
                                                  isVisible: false,
                                                  majorGridLines:
                                                      const MajorGridLines(
                                                          width: 0)),
                                              primaryYAxis: NumericAxis(
                                                  isVisible: false,
                                                  minimum: 0,
                                                  maximum: 50,
                                                  interval: 50),
                                              tooltipBehavior: _tooltip,
                                              series: <
                                                  ChartSeries<_ChartData,
                                                      String>>[
                                                ColumnSeries<_ChartData,
                                                        String>(
                                                    dataSource: data,
                                                    xValueMapper:
                                                        (_ChartData data, _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (_ChartData data, _) =>
                                                            data.y,
                                                    name: '',
                                                    color: const Color.fromRGBO(
                                                        8, 142, 255, 1))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              });

                              // Your code here
                            },
                            backgroundColor: const Color(0xFFEB4A5A),
                            shape: const CircleBorder(),
                            child: submissionState is SubmissionLoadInProgress
                                ? const CircularProgressIndicator()
                                : const Icon(Icons.play_arrow),
                          ),
                        ],
                      )),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Result",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'visbyRoundCF',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.2, // set the height as per your requirement
                      child: SingleChildScrollView(
                        child: Text(
                          result = result.replaceAll(
                            'jdoodle.c:',
                            '',
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (codingProblemState is CodingProblemIsFailure) {
            return Center(
              child: Text(
                'Something went wrong!',
                style: TextStyle(color: theme.colorScheme.error),
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }
}

Future<List<String?>> sendApiRequest(String code) async {
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
      var output = responseBody['output'];
      var memory = responseBody['memory'];
      return [output, memory];
    } else if (responseBody.containsKey('message')) {
      return responseBody['message'];
    }
  }
  return [];
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
