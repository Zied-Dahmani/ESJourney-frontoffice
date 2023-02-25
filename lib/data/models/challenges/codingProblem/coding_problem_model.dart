
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'coding_problem_model.freezed.dart';
part 'coding_problem_model.g.dart';
@freezed
class CodingProblem with _$CodingProblem {
  const factory CodingProblem({
    required dynamic  id,
    required String description,
    required String output,
  //  required DateTime createdAt,
  }) = _CodingProblem;

  factory CodingProblem.fromJson(Map<String, dynamic> json) => _$CodingProblemFromJson(json);
//  String convertDate() => DateFormat('MMM d, h:mm a').format(createdAt);
}
