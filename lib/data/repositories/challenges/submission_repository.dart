import 'package:esjourney/data/models/challenges/submission/submission_model.dart';
import 'package:esjourney/data/providers/challenges/submission_data_provider.dart';
import 'package:esjourney/data/repositories/challenges/submission_repository_interface.dart';

class SubmitRepository implements ISubmitRepository {
  final SubmitDataProvider _submitDataProvider = SubmitDataProvider();

  @override
  Future submit(String problemId, String token, int memory) async {
    final result =
        await _submitDataProvider.submit(problemId, token, memory);
    return result.statusCode == 200 ? Submission.fromJson(result.data) : null;
  }
}
