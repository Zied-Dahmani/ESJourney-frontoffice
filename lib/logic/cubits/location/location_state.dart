part of 'location_cubit.dart';

abstract class LocationState {}

class LocationLoadInProgress extends LocationState {}

class LocationTurnOnSuccess  extends LocationState {
  LatLng latLng;

  LocationTurnOnSuccess({required this.latLng});
}

class LocationTurnOffSuccess  extends LocationState {}
