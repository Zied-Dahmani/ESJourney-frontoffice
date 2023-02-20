import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:esjourney/data/models/challenges/quiz/quiz_model.dart';
import 'package:esjourney/logic/cubits/challenges/quiz_cubit.dart';
import 'package:esjourney/logic/cubits/challenges/quiz_state.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/screens/challenges/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../widgets/challenges/disco_button.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

var _predictionInput = List.filled(1, List.filled(2, 0.0));
int _questionIndex = 0;
CountDownController _controller = CountDownController();
bool _isSelected = false;
List<int> selectedOptionIndices = [];
List<int> correctOptionIndices = [];
List<int> _userAnswers = [];
late int _selectedOptionIndex;
bool _isQuizAnswered = false;
bool timerEnded = false;
bool hasSetState = false;
bool _isAnswerAdded = false;
List<Quiz> apiQuiz = [];
double _isAnswerCorrect = 0.0;
List<String> _answeredQuestions = [];
String _discoBtnText = "Next";
class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    final getQuiz = BlocProvider.of<QuizCubit>(context);
    getQuiz.getQuiz("c");
  }

  String hardness(String currentHardness, int predictedHardness) {
    final Map<int, int> incDecreaseHardness = {0: -1, 1: 0, 2: 1};
    final List<String> hardness = ["easy", "medium", "hard"];
    int nextHardnessIndex = hardness.indexOf(currentHardness) +
        incDecreaseHardness[predictedHardness]!;

    String nextQuestionHardness;
    if (0 <= nextHardnessIndex && nextHardnessIndex < 3) {
      nextQuestionHardness = hardness[hardness.indexOf(currentHardness) +
          incDecreaseHardness[predictedHardness]!];
    } else {
      nextQuestionHardness = currentHardness;
    }

    return nextQuestionHardness;
  }

  Future<int> predData(List<List<double>> input) async {
    final interpreter = await Interpreter.fromAsset('quiz.tflite');
    var output = List.filled(1 * 3, 0).reshape([1, 3]);

    interpreter.run(input, output);

    var predictedDifficultyIndex = output[0]
        .indexOf(output[0].reduce((double a, double b) => a > b ? a : b));

    return predictedDifficultyIndex;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserLogInSuccess) {
        final user = state.user;
        return BlocBuilder<QuizCubit, QuizState>(builder: (context, state) {
          if (state is QuizSuccess) {
            final apiQuiz = state.quizzes;
            for (int i = 0; i < apiQuiz.length; i++) {
              correctOptionIndices.add(apiQuiz[i].answer);
            }

            return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.tertiary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[300],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  theme.colorScheme.shadow),
                              value: (_questionIndex + 1) / apiQuiz.length,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: Text(
                            "${_questionIndex + 1}/${apiQuiz.length}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                        height: MediaQuery.of(context).size.height * 0.23,
                        width: MediaQuery.of(context).size.height * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: // custom color hex code
                                  Color(0xFFE7E7E7),
                              offset: Offset(6.0, 8.0),
                              blurRadius: 10.0,
                              spreadRadius: 0, // changes position of shadow
                            ),
                          ],
                          border: Border.all(
                            color: theme.colorScheme.tertiary,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 45, 20, 0),
                          child: Text(
                            apiQuiz[_questionIndex].question,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !_isQuizAnswered,
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: CircularCountDownTimer(
                              duration: 99999,
                              initialDuration: 0,
                              controller: _controller,
                              width: 60,
                              height: 60,
                              ringColor: theme.colorScheme.tertiary,
                              ringGradient: null,
                              fillColor: theme.colorScheme.primary,
                              fillGradient: null,
                              textStyle: TextStyle(
                                fontSize: 15.0,
                                color: theme.colorScheme.shadow,
                                fontWeight: FontWeight.bold,
                              ),
                              backgroundColor: Colors.white,
                              backgroundGradient: null,
                              strokeWidth: 8.0,
                              strokeCap: StrokeCap.round,
                              textFormat: CountdownTextFormat.S,
                              isReverse: false,
                              isReverseAnimation: false,
                              isTimerTextShown: true,
                              autoStart: true,
                              onStart: () {},
                              onComplete: () {
                                if (!timerEnded) {
                                  if (_isSelected == true && !_isAnswerAdded) {
                                    _userAnswers.add(_selectedOptionIndex);
                                    _isAnswerAdded = true;
                                  } else if (!_isAnswerAdded) {
                                    _userAnswers.add(-1);
                                    _isAnswerAdded = true;
                                  }
                                  if (_questionIndex < apiQuiz.length) {
                                    if (!hasSetState) {
                                      setState(() {
                                        _questionIndex++;
                                        _isSelected = false;
                                        selectedOptionIndices = [];
                                        timerEnded =
                                            false; // set timerEnded to false
                                        hasSetState = true;
                                        _controller.reset();
                                        _controller.restart(duration: 3);
                                        _isAnswerAdded = false;
                                      });
                                      hasSetState = false;
                                    }
                                  } else {
                                    setState(() {
                                      _questionIndex = 0;
                                      _isQuizAnswered = true;
                                      _controller.pause();
                                    });
                                  }
                                }
                              },
                              onChange: (String timeStamp) {},
                              timeFormatterFunction:
                                  (defaultFormatterFunction, duration) {
                                if (duration.inSeconds == 0) {
                                  return "1";
                                } else {
                                  return Function.apply(
                                      defaultFormatterFunction, [duration]);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  QuestionCard(
                    isQuizAnswered: _isQuizAnswered,
                    quiz: apiQuiz[_questionIndex],
                    correctOptionIndices: correctOptionIndices[_questionIndex],
                    selectedOptionIndices: _isQuizAnswered
                        ? [_userAnswers[_questionIndex]]
                        : selectedOptionIndices,
                    onOptionTap: (index) {
                      setState(
                        () {
                          _isSelected = true;
                          _selectedOptionIndex = index[0];
                        },
                      );
                    },
                  ),
                  DiscoButton(
                    isActive: true,

                    //_isSelected || _isQuizAnswered,
                    onPressed: () async {
                      _answeredQuestions.add(apiQuiz[_questionIndex].question);
                      print("question isss " + apiQuiz[_questionIndex].difficulty);
                      if (_selectedOptionIndex ==
                          correctOptionIndices[_questionIndex]) {
                        _isAnswerCorrect = 1;
                      } else {
                        _isAnswerCorrect = 0;
                      }

                      //print("is answer correct: $_isAnswerCorrect");
                      double timeTaken = double.parse(_controller.getTime()!);
                      _predictionInput[0][0] = timeTaken;
                      _predictionInput[0][1] = _isAnswerCorrect;
                      int predictedDifficulty =
                          await predData(_predictionInput);
                      String nextQuestionDifficulty = hardness(
                          apiQuiz[_questionIndex].difficulty,
                          predictedDifficulty);

                      for (int i = 0; i < apiQuiz.length; i++) {
                        if (apiQuiz[i].difficulty == nextQuestionDifficulty &&
                            !_answeredQuestions.contains(apiQuiz[i].question)) {
print("answereed question: ${_answeredQuestions}");

                          _questionIndex = i;
                          print("question index: $i");
                          break;
                        }

                      }

                      if (!_isQuizAnswered) {
                        _userAnswers.add(_selectedOptionIndex);
                        //  setUsersAnswers(_userAnswers);

                        if (_answeredQuestions.length == apiQuiz.length) {
                          setState(() {
                            selectedOptionIndices = [];
                            _questionIndex = 0;
                            _isQuizAnswered = true;
                            _controller.pause();
                            _discoBtnText = "Finish Quiz";

                          });
                        } else {
                          setState(() {
                            timerEnded = true;
                            selectedOptionIndices = [];
                            _controller.restart(duration: 99999);
                          });
                        }
                      } else {
                        setState(() {
                          selectedOptionIndices = [];
                          _answeredQuestions
                              .add(apiQuiz[_questionIndex].question);
                          _questionIndex++;

                          if (_questionIndex == apiQuiz.length) {
                            setState(() {
                              _questionIndex = 0;
                            });
                          }
                        });
                      }
                    },
                    height: MediaQuery.of(context).size.height * 0.065,
                    width: MediaQuery.of(context).size.width * 0.335,
                    child:  Text(
                      _discoBtnText,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
      }

      return const Center(child: CircularProgressIndicator());
    });
  }
}
