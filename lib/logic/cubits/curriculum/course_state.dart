abstract class CourseState {}

class CourseInitial extends CourseState {}

class CourseLoadInProgress extends CourseState {}

class CourseSuccess extends CourseState {
  final List<dynamic> courses;

  CourseSuccess(this.courses);
}

class CourseIsFailure extends CourseState {
  final String error;

  CourseIsFailure(this.error);
}
