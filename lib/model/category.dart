import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  static final String tableName = 'category';

  static final String columnId = 'id';
  static final String columnName = 'name';

  static const String allLists = 'All Lists';
  static const String weight = 'Weight Track';
  static const String exercises = 'Exercises';
  static const String breakfast = 'Breakfast';
  static const String launch = 'Lunch';
  static const String dinner = 'Dinner';
  static const String finished = 'Finished';

  int id;
  String name;

  Category({this.id, @required this.name});

  Map toMap() {
    return <String, dynamic>{columnName: name};
  }

  Category.fromMap(Map map) {
    id = map[columnId];
    name = map[columnName];
  }

  IconData getIcon() {
    switch (name) {
      case exercises:
        return Icons.run_circle_outlined ;
      case breakfast:
        return Icons.breakfast_dining_outlined ;
      case launch:
        return Icons.food_bank_outlined;
      case dinner:
        return Icons.dinner_dining_outlined ;
      case finished:
        return Icons.check;
      case weight:
        return Icons.monitor_weight_outlined ;
      default:
        return Icons.list ;
    }
  }
}
