import 'package:esjourney/data/models/club_event_model.dart';
import 'package:esjourney/data/providers/club_event_data_provider.dart';
import 'package:esjourney/data/repositories/club_event/club_event_repository_interface.dart';

class ClubEventRepository implements IClubEventRepository {
  final ClubEventDataProvider _clubEventDataProvider = ClubEventDataProvider();

  @override
  Future<dynamic> getAllClubEvents() async {
    final result = await _clubEventDataProvider.getAllClubEvents();
    return result.statusCode == 200
        ? result.data.map((clubEvent) => ClubEvent.fromJson(clubEvent)).toList()
        : null;
  }
}
