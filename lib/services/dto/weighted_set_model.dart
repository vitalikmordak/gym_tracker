import 'package:gym_tracker/services/dto/exercise_set_model.dart';
import 'dart:convert';

class WeightedSetModel implements ExerciseSetModel {
  final int setNumber;
  double weight;
  int reps;

  WeightedSetModel({required this.setNumber, this.weight = 0, this.reps = 0});

  factory WeightedSetModel.fromRawJson(String str) =>
      WeightedSetModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeightedSetModel.fromJson(Map<String, dynamic> json) =>
      WeightedSetModel(
          setNumber: json['setNumber'],
          weight: json['weight'],
          reps: json['reps']);

  Map<String, dynamic> toJson() => {
        "setNumber": setNumber,
        "weight": weight,
        "reps": reps,
      };
}
