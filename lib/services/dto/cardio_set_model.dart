import 'package:gym_tracker/services/dto/exercise_set_model.dart';
import 'dart:convert';

class CardioSetModel with ExerciseSetModel {
  final int setNumber;
  Duration duration;
  double distanceInKm;

  CardioSetModel(
      {required this.setNumber,
       required this.duration,
       this.distanceInKm = 0,
      });

  factory CardioSetModel.fromRawJson(String str) =>
      CardioSetModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CardioSetModel.fromJson(Map<String, dynamic> json) => CardioSetModel(
      setNumber: json['setNumber'],
      distanceInKm: json['distanceInKm'],
      duration: json['duration']);

  Map<String, dynamic> toJson() => {
        "setNumber": setNumber,
        "distanceInKm": distanceInKm,
        "duration": duration,
      };
}
