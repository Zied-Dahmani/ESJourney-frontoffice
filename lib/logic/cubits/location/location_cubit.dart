import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'dart:developer' as developer;
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationLoadInProgress()) {
    currentLocation(true);
  }

  Future<void> currentLocation(bool isFirstTime) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    Location location = Location();

    if (!isFirstTime) {
      emit(LocationLoadInProgress());
    }

    try {

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return emit(LocationTurnOffSuccess());
        }
      }

      emit(LocationTurnOnSuccess(latLng: LatLng(36.898051,10.193847)));

      // TODO Device Memory, reduce the app size...
      /*serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return emit(LocationTurnOffSuccess());
        } else {
          final myLocation = await location.getLocation();
          emit(LocationTurnOnSuccess(latLng: LatLng(myLocation.latitude!, myLocation.longitude!)));
        }
      } else {
        final myLocation = await location.getLocation();
        emit(LocationTurnOnSuccess(latLng: LatLng(myLocation.latitude!, myLocation.longitude!)));
      }*/
    } catch (e) {
      developer.log(e.toString(), name: 'Catch location');
    }

  }
}
