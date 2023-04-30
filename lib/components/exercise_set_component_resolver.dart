import 'package:flutter/cupertino.dart';
import 'package:gym_tracker/components/cardio_set_type_component.dart';
import 'package:gym_tracker/components/duration_set_type_component.dart';
import 'package:gym_tracker/components/reps_only_set_type_component.dart';
import 'package:gym_tracker/components/weight_set_type_component.dart';

/// Resolver for exercise's set type
class ExerciseSetComponentResolver {
  /// Return specific '...setTypeComponent' based on exercise's setType
  Widget resolve(String setType, int setNumber) {
    switch (setType) {
      case "WEIGHT":
        return WeightSetTypeComponent(setNumber: setNumber);
      case 'CARDIO':
        return CardioSetTypeComponent(setNumber: setNumber);
      case 'DURATION':
        return DurationSetTypeComponent(setNumber: setNumber);
      case 'REPS_ONLY':
        return RepsOnlySetTypeComponent(setNumber: setNumber);
      default:
        return Placeholder();
    }
  }
}
