import 'package:dio/dio.dart';

import 'package:nepatronix/model/courses_model.dart';

class CourseService {
  // final AppData _appData = AppData();

  final Dio dio = Dio();
  final String baseUrl = 'http://182.93.94.210:3064/api/v1/list-courses';

  Future<List<Data>?> fetchCourses({int? page}) async {
    try {
      final response = await dio.get('$baseUrl/$page',
          options: Options(headers: {
            'authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2ODA4ZTMzYjA0YjUzNmZiMWJjZDY2OGIiLCJlbWFpbCI6ImRlZXBzdWdhdXRhbUBnbWFpbC5jb20iLCJwaG9uZSI6Ijk4NDU3NjM0MzQiLCJpYXQiOjE3NDcyMTM2MjEsImV4cCI6MTc0NzMwMDAyMX0.pGPLOrPyaOwGvsxcyVCYPu6jtOut9093cTL_aFF37Uc'
          }));
      if (response.statusCode == 200) {
        final courses = Courses.fromJson(response.data);
        return courses.data;
      } else {
        throw Exception(
            'Failed to load courses. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching courses: $e');
    }
  }
}

//for whole course
// import 'package:dio/dio.dart';
// import 'package:nepatronix/model/courses_model.dart';

// class CourseService {
//   final Dio dio = Dio();
//   final String baseUrl = 'http://182.93.94.210:3064/api/v1/list-courses';
//   Future<Courses> fetchCourses({int? page}) async {
//     try {
//       final response = await dio.get('$baseUrl/$page',
//           options: Options(headers: {
//             'authorization':
//                 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2ODA4ZTMzYjA0YjUzNmZiMWJjZDY2OGIiLCJlbWFpbCI6ImRlZXBzdWdhdXRhbUBnbWFpbC5jb20iLCJwaG9uZSI6Ijk4NDU3NjM0MzQiLCJpYXQiOjE3NDY0MzkyMTMsImV4cCI6MTc0NjUyNTYxM30.ZJHv0Jgm9doXIZU7ck885Oc82ISB1JIJfoFyW37xjqo'
//           }));
//       if (response.statusCode == 200) {
//         final courses = Courses.fromJson(response.data);
//         return courses;
//       } else {
//         throw Exception(
//             'Failed to load courses. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching courses: $e');
//     }
//   }
// }
