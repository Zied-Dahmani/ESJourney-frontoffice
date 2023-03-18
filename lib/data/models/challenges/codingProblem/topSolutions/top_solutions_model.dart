
import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_solutions_model.freezed.dart';
part 'top_solutions_model.g.dart';
@freezed
class TopSolutions with _$TopSolutions {
  const factory TopSolutions({
    required String memory,
    required String percentage,
  }) = _TopSolutions;

  factory TopSolutions.fromJson(Map<String, dynamic> json) => _$TopSolutionsFromJson(json);

}
