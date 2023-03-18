enum ApplicationState { waiting, underReview, accepted, denied }

extension ApplicationStateExtenstion on ApplicationState {
  String? get name {
    switch (this) {
      case ApplicationState.waiting:
        return 'Waiting';
      case ApplicationState.underReview:
        return 'Under review';
      case ApplicationState.accepted:
        return 'Accepted';
      case ApplicationState.denied:
        return 'Denied';
      default:
        return null;
    }
  }
}
