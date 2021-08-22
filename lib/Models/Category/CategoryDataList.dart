<<<<<<< HEAD
import 'package:troom/Models/Category/CategoryResData.dart';

class CategoryDataList{
  CategoryResData _categoryResData;

  CategoryDataList({ CategoryResData data}) : _categoryResData = data;

  int get key => _categoryResData.key;

  String get name => _categoryResData.name;

  String get slug => _categoryResData.slug;

  dynamic get image => _categoryResData.image;

  String get description => _categoryResData.description;
=======
import 'package:troom/Models/Category/CategoryResData.dart';

class CategoryDataList{
  CategoryResData _categoryResData;

  CategoryDataList({ CategoryResData data}) : _categoryResData = data;

  int get key => _categoryResData.key;

  String get name => _categoryResData.name;

  String get slug => _categoryResData.slug;

  dynamic get image => _categoryResData.image;

  String get description => _categoryResData.description;
>>>>>>> 8735c7c42bfa70f00bed54310f9a2134fdd3b0df
}