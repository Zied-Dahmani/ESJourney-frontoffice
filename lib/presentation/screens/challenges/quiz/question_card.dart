import 'package:flutter/material.dart';


import '../../../../data/models/quiz/quiz_model.dart';
import 'option.dart';

class QuestionCard extends StatefulWidget {
  QuestionCard({
    Key? key,
    required this.quiz,
    required this.onOptionTap,
    required this.selectedOptionIndices,
    required this.correctOptionIndices,
    required this.isQuizAnswered,
  }) : super(key: key);
  final Quiz quiz;
  final Function onOptionTap;
  late List<int>  selectedOptionIndices;
  final int correctOptionIndices;
  final bool isQuizAnswered;

  @override
  _QuestionCardState createState() => _QuestionCardState();
}



class _QuestionCardState extends State<QuestionCard> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(35)),
      ),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.quiz.options.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (widget.isQuizAnswered==false) {
                    setState(() {
                      widget.selectedOptionIndices.clear();
                      widget.selectedOptionIndices.add(index);
                      widget.onOptionTap(widget.selectedOptionIndices);

                    });
                  }
                },
                child: Option(
                  isQuizAnswered: widget.isQuizAnswered,
                  isOptionCorrect: widget.correctOptionIndices == (index),
                  text: widget.quiz.options[index],
                  isOptionSelected:
                  widget.isQuizAnswered
                      ? (widget.correctOptionIndices == index ||
                          widget.selectedOptionIndices.contains(index) &&
                              widget.correctOptionIndices != (index))
                     :
                    widget.selectedOptionIndices.contains(index),


                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
