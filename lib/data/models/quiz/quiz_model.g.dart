// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Quiz _$$_QuizFromJson(Map<String, dynamic> json) => _$_Quiz(
      question: json['question'] as String,
      language: json['language'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      answer: json['answer'] as int,
      difficulty: json['difficulty'] as String,
    );

Map<String, dynamic> _$$_QuizToJson(_$_Quiz instance) => <String, dynamic>{
      'question': instance.question,
      'language': instance.language,
      'options': instance.options,
      'answer': instance.answer,
      'difficulty': instance.difficulty,
    };
