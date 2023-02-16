import 'package:esjourney/data/models/curriculum/course_model.dart';
import 'package:esjourney/data/providers/curriculum/course_data_provider.dart';
import 'package:esjourney/data/repositories/curriculum/course_repository_interface.dart';

class CourseRepository implements ICourseRepository {
  final CourseDataProvider _courseDataProvider = CourseDataProvider();

  @override
  Future<dynamic> getAllCourses(String token) async {
    final result = await _courseDataProvider.getAllCourses(token);
    return result.statusCode == 200
        ? result.data.map((course) => Course.fromJson(course)).toList()
        : null;
  }
}
