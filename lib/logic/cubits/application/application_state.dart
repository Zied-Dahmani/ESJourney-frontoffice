
import 'package:esjourney/data/models/application_model.dart';

abstract class ApplicationState {}

class ApplicationLoadInProgress extends ApplicationState {}

class ApplicationLoadSuccess extends ApplicationState {
  final List<Application> applications;
  ApplicationLoadSuccess(this.applications);
}

class ApplicationLoadFailure extends ApplicationState {
  final String error;
  ApplicationLoadFailure(this.error);
}
