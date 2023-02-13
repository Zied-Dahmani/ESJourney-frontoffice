import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:esjourney/logic/cubits/challenges/quiz_cubit.dart';
import 'package:esjourney/logic/cubits/challenges/quiz_state.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/screens/challenges/quiz/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/quiz/quiz_model.dart';
import '../../../router/routes.dart';
import '../../../widgets/challenges/disco_button.dart';



class QuizScreen extends StatefulWidget {
  const QuizScreen({
    Key? key,
  }) : super(key: key);

//final String language;
//  required this.language
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

List<Quiz> quiz = [];
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
int _userScore = 0;

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    final getQuiz = BlocProvider.of<QuizCubit>(context);
    getQuiz.getQuiz("c");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserLogInSuccess) {
        final user = state.user;
        return BlocBuilder<QuizCubit, QuizState>(builder: (context, state) {
          if (state is QuizSuccess) {
            final quiz = state.quizzes;
            for (int i = 0; i < quiz.length; i++) {
              correctOptionIndices.add(quiz[i].answer);
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
                              value: (_questionIndex + 1) / quiz.length,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: Text(
                            "${_questionIndex + 1}/${quiz.length}",
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
                            quiz[_questionIndex].question,
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
                              duration: 50,
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
                                  if (_questionIndex < quiz.length) {
                                    if (!hasSetState) {
                                      setState(() {
                                        _questionIndex++;
                                        _isSelected = false;
                                        selectedOptionIndices = [];
                                        timerEnded =
                                            false; // set timerEnded to false
                                        hasSetState = true;
                                        _controller.reset();
                                        _controller.restart(duration: 50);
                                        _isAnswerAdded = false;
                                      });
                                      hasSetState = false;
                                    }
                                  } else {
                                    setState(() {
                                      _questionIndex = 0;
                                      _isQuizAnswered = true;
                                      _controller.pause();
                                      Navigator.of(context).pushNamed(
                                        AppRoutes.quizResult,
                                        arguments: _userScore,
                                      );
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
                    quiz: quiz[_questionIndex],
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
                    isActive: _isSelected || _isQuizAnswered,
                    onPressed: () {
                      if (!_isQuizAnswered) {
                        if (_selectedOptionIndex ==
                            correctOptionIndices[_questionIndex]) {
                          _userScore++; // Increase score if answer is correct
                        }

                        _userAnswers.add(_selectedOptionIndex);
                        //  setUsersAnswers(_userAnswers);

                        if (_questionIndex == quiz.length - 1) {
                          Navigator.of(context).pushNamed(
                            AppRoutes.quizResult,
                            arguments: _userScore,
                          );
                          setState(() {
                            selectedOptionIndices = [];
                            _questionIndex = 0;
                            _isQuizAnswered = true;
                            _controller.pause();
                          });
                        } else {
                          setState(() {
                            timerEnded = true;
                            selectedOptionIndices = [];
                            _questionIndex++;
                            _controller.restart(duration: 50);
                          });
                        }
                      } else {

                        setState(() {
                          selectedOptionIndices = [];
                          _questionIndex++;

                          if (_questionIndex == quiz.length) {
                            setState(() {
                              _questionIndex = 0;
                            });
                          }
                        });
                      }
                    },
                    height: MediaQuery.of(context).size.height * 0.065,
                    width: MediaQuery.of(context).size.width * 0.335,
                    child: const Text(
                      "Next",
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
