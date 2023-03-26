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
    return result.statusCode == 200
        ? result.data.map((clubEvent) => ClubEvent.fromJson(clubEvent)).toList()
        : null;
  }

  @override
  Future getAllApplications() async {
    final result = await _clubDataProvider.getAllApplications();
    return result.statusCode == 200
        ? result.data.map((application) => Application.fromJson(application)).toList()
        : null;
  }


}
