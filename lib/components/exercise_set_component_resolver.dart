import 'package:flutter/cupertino.dart';
import 'package:gym_tracker/components/cardio_set_type_component.dart';
import 'package:gym_tracker/components/duration_set_type_component.dart';
import 'package:gym_tracker/components/reps_only_set_type_component.dart';
import 'package:gym_tracker/components/weight_set_type_component.dart';
import 'package:gym_tracker/services/dto/exercise_model.dart';
import 'package:gym_tracker/services/dto/exercise_set_model.dart';

/// Resolver for exercise's set type
class ExerciseSetComponentResolver {
  final ExerciseModel exercise;
  final Map<ExerciseModel, List<ExerciseSetModel>> workout;


  ExerciseSetComponentResolver(this.exercise, this.workout) {
    workout.putIfAbsent(exercise, () => []);
  }

  /// Return specific '...setTypeComponent' based on exercise's setType
  Widget resolve(int setNumber) {
    switch (exercise.setCategoryType) {
      case "WEIGHT":
        return WeightSetTypeComponent(setNumber: setNumber, sets: workout[exercise]!);
      case 'CARDIO':
        return CardioSetTypeComponent(setNumber: setNumber, sets: workout[exercise]!,);
      case 'DURATION':
        return DurationSetTypeComponent(setNumber: setNumber, sets: workout[exercise]!);
      case 'REPS_ONLY':
        return RepsOnlySetTypeComponent(setNumber: setNumber, sets: workout[exercise]!);
      default:
        return Placeholder();
    }
  }
}
