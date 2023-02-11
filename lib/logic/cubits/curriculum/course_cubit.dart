import 'dart:developer' as developer;

import 'package:esjourney/data/repositories/curriculum/course_repository.dart';
import 'package:esjourney/logic/cubits/curriculum/course_state.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit() : super(CourseInitial());

  final _courseRepository = CourseRepository();

  Future<void> getAllCourses(String token) async {
    try {
      emit(CourseLoadInProgress());
      final result = await _courseRepository.getAllCourses(token);
      result != null
          ? emit(CourseSuccess(result))
          : emit(CourseIsFailure("error while getting data"));
    } catch (e) {
      developer.log(e.toString(), name: 'error course');
      emit(CourseIsFailure(kcheckInternetConnection));
    }
  }
}
