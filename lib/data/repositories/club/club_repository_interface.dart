abstract class IClubRepository {
  Future<dynamic> getAllClubs();
  Future<dynamic> getAllClubEvents();
  Future<dynamic> getAllApplications(String token);
  Future<bool> apply(
      String token,
      String clubId,
      String? filePath,
      String fileName,
      String phoneNumber,
      String birthDate,
      String studyLevel,
      String specialty,
      List answers,
      String linkedInLink);
  Future<bool> bookEvent(String token,String clubId, int ticketIndex);

}
