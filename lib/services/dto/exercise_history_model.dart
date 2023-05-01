import 'package:gym_tracker/services/dto/cardio_set_model.dart';
import 'package:gym_tracker/services/dto/duration_set_model.dart';
import 'package:gym_tracker/services/dto/exercise_model.dart';
import 'package:gym_tracker/services/dto/exercise_set_model.dart';
import 'package:gym_tracker/services/dto/reps_only_set_model.dart';
import 'dart:convert';

import 'package:gym_tracker/services/dto/weighted_set_model.dart';

class ExerciseHistoryModel {
  final ExerciseModel exercise;

  final List<ExerciseSetModel> sets;

  ExerciseHistoryModel({required this.exercise, required this.sets});

  factory ExerciseHistoryModel.fromRawJson(String str) =>
      ExerciseHistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExerciseHistoryModel.fromJson(Map<String, dynamic> json) =>
      ExerciseHistoryModel(
        exercise: ExerciseModel.fromJson(json),
        sets: List<dynamic>.from(json['sets']).map((set) {
          if (set['reps'] != null) {
            if (set['weight'] != null) {
              return WeightedSetModel.fromJson(set);
            }
            return RepsOnlySetModel.fromJson(set);
          } else {
            if (set['distanceInKm'] != null) {
              return CardioSetModel.fromJson(set);
            }
            return DurationSetModel.fromJson(set);
          }
        }).toList(),
      );

  Map<String, dynamic> toJson() => {
        "exercise": exercise.toJson(),
        "sets": sets.map((set) {
          switch (set.runtimeType) {
            case WeightedSetModel:
              return (set as WeightedSetModel).toJson();
            case RepsOnlySetModel:
              return (set as RepsOnlySetModel).toJson();
            case DurationSetModel:
              return (set as DurationSetModel).toJson();
            case CardioSetModel:
              return (set as CardioSetModel).toJson();
          }
        }).toList(),
      };
}
