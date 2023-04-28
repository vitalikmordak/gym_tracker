import 'package:flutter/material.dart';
import 'package:gym_tracker/services/exercise_model.dart';
import 'package:gym_tracker/vo/excercise.dart';
import 'package:gym_tracker/vo/excercise_category.dart';

class InMemoryStorage {
  final List<Exercise> bicepExercises = [
    Exercise('Bicep Curl (Barbell)'),
    Exercise('Bicep Curl (Dumbbell)'),
    Exercise('Bicep Curl (Cable)'),
  ];

  final List<Exercise> tricepsExercises = [
    Exercise('Triceps Extension (Barbell)'),
    Exercise('Triceps Extension (Dumbbell)'),
    Exercise('Triceps Extension (Cable)'),
  ];

  final List<Exercise> chestExercises = [
    Exercise('Bench Press (Barbell)'),
    Exercise('Bench Press (Dumbbell)'),
    Exercise('Chest Fly'),
    Exercise('Chest Fly (Dumbbell)'),
    Exercise('Incline Bench Press (Barbell)'),
    Exercise('Incline Bench Press (Dumbbell)'),
  ];

  final List<Exercise> shoulderExercises = [
    Exercise('Arnold Press (Dumbbell)'),
    Exercise('Face Pull (Cable)'),
    Exercise('Lateral Raise (Dumbbell)'),
    Exercise('Lateral Raise (Machine)'),
    Exercise('Overhead Press (Barbell)'),
    Exercise('Overhead Press (Dumbbell)'),
    Exercise('Reverse Fly (Dumbbell)'),
    Exercise('Shoulder Press (Machine)'),
  ];

  final List<Exercise> coreExercises = [
    Exercise('Crunch'),
    Exercise('Crunch (Machine)'),
    Exercise('Hanging Knee Raise'),
  ];


  List<ExerciseCategory> categories = [];

  InMemoryStorage() {
    categories.add(ExerciseCategory(categoryName: 'Biceps',
        exercises: bicepExercises,
        categoryIcon: AssetImage('assets/exercise_icons/icons8-biceps-100.png')));
    categories.add(ExerciseCategory(categoryName: 'Triceps',
        exercises: tricepsExercises,
        categoryIcon: AssetImage('assets/exercise_icons/icons8-triceps-100.png')));

    categories.add(ExerciseCategory(categoryName: 'Chest',
        exercises: chestExercises,
        categoryIcon: AssetImage('assets/exercise_icons/icons8-chest-100.png')));
    categories.add(ExerciseCategory(categoryName: 'Shoulders',
        exercises: shoulderExercises,
        categoryIcon: AssetImage('assets/exercise_icons/icons8-shoulders-100.png')));
    categories.add(ExerciseCategory(categoryName: 'Core',
        exercises: coreExercises,
        categoryIcon: AssetImage('assets/exercise_icons/icons8-prelum-100.png')));
  }

  static Map<String, List<ExerciseModel>> exercisesByGroup = {};

}