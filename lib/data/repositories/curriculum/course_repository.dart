import 'package:esjourney/data/models/curriculum/course_model.dart';
import 'package:esjourney/data/providers/curriculum/course_data_provider.dart';
import 'package:esjourney/data/repositories/curriculum/course_repository_interface.dart';

class CourseRepository implements ICourseRepository {
  final CourseDataProvider _courseDataProvider = CourseDataProvider();

  @override
  Future<dynamic> getAllCourses() async {
    final result = await _courseDataProvider.getAllCourses();
    print("result $result");
    print("result2 ${result.data}");
    return result.statusCode == 200
        ? result.data.map((course) => Course.fromJson(course)).toList()
        : null;  }
}
