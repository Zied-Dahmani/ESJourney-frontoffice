enum ClubEventType { all, teamBuilding, conference, charity, party }

extension ClubEventTypeExtension on ClubEventType {
  String? get name {
    switch (this) {
      case ClubEventType.all:
        return 'All';
      case ClubEventType.teamBuilding:
        return 'Team building';
      case ClubEventType.conference:
        return 'Conference';
      case ClubEventType.charity:
        return 'Charity';
      case ClubEventType.party:
        return 'Party';
      default:
        return null;
    }
  }
}
