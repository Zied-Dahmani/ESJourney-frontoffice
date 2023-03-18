part of 'connectivity_cubit.dart';

abstract class ConnectivityState {}

class ConnectivityLoadInProgress extends ConnectivityState {}

class ConnectivityConnectSuccess  extends ConnectivityState {
  final ConnectionType connectionType;

  ConnectivityConnectSuccess ({required this.connectionType});
}

class ConnectivityDisconnectSuccess  extends ConnectivityState {}
