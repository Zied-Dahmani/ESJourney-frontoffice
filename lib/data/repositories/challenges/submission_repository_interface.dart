abstract class ISubmitRepository {
  Future<dynamic> submit(String problemId, String token, int memory);
}
