import 'package:flutter/cupertino.dart';
import 'package:gym_tracker/vo/excercise.dart';

class ExerciseCategory {
  final String categoryName;
  final List<Exercise> exercises;
  final AssetImage categoryIcon;

  ExerciseCategory(
      {required this.categoryName,
      required this.exercises,
      required this.categoryIcon});
}
