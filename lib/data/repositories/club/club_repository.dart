import 'package:esjourney/data/models/club/application/application_model.dart';
import 'package:esjourney/data/models/club/event/club_event_model.dart';
import 'package:esjourney/data/models/club/club/club_model.dart';
import 'package:esjourney/data/providers/club_data_provider.dart';
import 'package:esjourney/data/repositories/club/club_repository_interface.dart';

class ClubRepository implements IClubRepository {
  final ClubDataProvider _clubDataProvider = ClubDataProvider();

  @override
  Future<dynamic> getAllClubs() async {
    final result = await _clubDataProvider.getAllClubs();
    return result.statusCode == 200
        ? result.data.map((club) => Club.fromJson(club)).toList()
        : null;
  }

  @override
  Future<dynamic> getAllClubEvents() async {
    final result = await _clubDataProvider.getAllClubEvents();
    print(result);
    return result.statusCode == 200
        ? result.data.map((clubEvent) => ClubEvent.fromJson(clubEvent)).toList()
        : null;
  }

  @override
  Future<dynamic> getAllApplications(String token) async {
    final result = await _clubDataProvider.getAllApplications(token);
    return result.statusCode == 200
        ? result.data
            .map((application) => Application.fromJson(application))
            .toList()
        : null;
  }

  @override
  Future<bool> apply(String token, String clubId, String? filePath, String fileName,String phoneNumber,String birthDate,String studyLevel,String speciality,List answers, String linkedInLink) async {
    final result = await _clubDataProvider.apply(token, clubId, filePath, fileName, phoneNumber, birthDate, studyLevel, speciality, answers,  linkedInLink);
    return result.statusCode == 201 ? true : false;
  }

  @override
  Future<bool> bookEvent(String token,String clubId, int ticketIndex) async {
    final result = await _clubDataProvider.bookEvent(token, clubId,ticketIndex);
    return result.statusCode == 200 ? true : false;
  }
}
