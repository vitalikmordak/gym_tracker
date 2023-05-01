
import 'package:gym_tracker/services/dto/exercise_set_model.dart';
import 'dart:convert';

class RepsOnlySetModel with ExerciseSetModel {
  final int setNumber;
  int reps;

  RepsOnlySetModel({required this.setNumber, this.reps = 0});

  factory RepsOnlySetModel.fromRawJson(String str) =>
      RepsOnlySetModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RepsOnlySetModel.fromJson(Map<String, dynamic> json) =>
      RepsOnlySetModel(
          setNumber: json['setNumber'],
          reps: json['reps']
      );

  Map<String, dynamic> toJson() => {
    "setNumber": setNumber,
    "reps": reps,
  };
}