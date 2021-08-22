<<<<<<< HEAD
import 'package:troom/Models/Courses/CoursesResData.dart';

class CoursesDataList{
  CoursesResData _coursesResData;

  CoursesDataList({ CoursesResData data}) : _coursesResData = data;


  int get key => _coursesResData.key;

  dynamic get name => _coursesResData.name;

  String get teacherImg => _coursesResData.teacherImg;

  List<Teacher> get teacher => _coursesResData.teachers;

  int get discountPrice => _coursesResData.discountPrice;

  int get price=> _coursesResData.price;

  String get level => _coursesResData.level;

  String get shortDescription => _coursesResData.shortDescription;

  String get image => _coursesResData.image;

  String get slug => _coursesResData.slug;
=======
import 'package:troom/Models/Courses/CoursesResData.dart';

class CoursesDataList{
  CoursesResData _coursesResData;

  CoursesDataList({ CoursesResData data}) : _coursesResData = data;


  int get key => _coursesResData.key;

  dynamic get name => _coursesResData.name;

  String get teacherImg => _coursesResData.teacherImg;

  List<Teacher> get teacher => _coursesResData.teachers;

  int get discountPrice => _coursesResData.discountPrice;

  int get price=> _coursesResData.price;

  String get level => _coursesResData.level;

  String get shortDescription => _coursesResData.shortDescription;

  String get image => _coursesResData.image;

  String get slug => _coursesResData.slug;
>>>>>>> 8735c7c42bfa70f00bed54310f9a2134fdd3b0df
}