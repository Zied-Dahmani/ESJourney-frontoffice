
import 'package:freezed_annotation/freezed_annotation.dart';


part 'submission_model.freezed.dart';
part 'submission_model.g.dart';
@freezed
class Submission with _$Submission {
  const factory Submission({
    required String  problemId,
    required int memory,

  }) = _Submission;

  factory Submission.fromJson(Map<String, dynamic> json) => _$SubmissionFromJson(json);

}
