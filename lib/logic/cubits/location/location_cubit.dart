import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
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

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return emit(LocationTurnOffSuccess());
      }
    }

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
       return emit(LocationTurnOffSuccess());
      }
    }

    final myLocation = await location.getLocation();
    emit(LocationTurnOnSuccess(latLng: LatLng(myLocation.latitude!,myLocation.longitude!)));
  }
}
