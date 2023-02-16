
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_model.freezed.dart';
part 'quiz_model.g.dart';
@freezed
class Quiz with _$Quiz {
  const factory Quiz({
    required String question,
    required String language,
    required List<String> options,
    required int answer,
    required String difficulty,
  }) = _Quiz;

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
}
