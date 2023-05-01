
import 'package:gym_tracker/services/dto/exercise_set_model.dart';
import 'dart:convert';

class DurationSetModel with ExerciseSetModel {
  final int setNumber;
  Duration duration;

  DurationSetModel({required this.setNumber, required this.duration});

  factory DurationSetModel.fromRawJson(String str) =>
      DurationSetModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DurationSetModel.fromJson(Map<String, dynamic> json) =>
      DurationSetModel(
          setNumber: json['setNumber'],
          duration: Duration(milliseconds: json['duration'])
      );

  Map<String, dynamic> toJson() => {
    "setNumber": setNumber,
    "duration": duration.inMilliseconds,
  };

}