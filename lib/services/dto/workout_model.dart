import 'dart:convert';

import 'package:gym_tracker/services/dto/exercise_history_model.dart';

class WorkoutModel {
  String? id;
  String? userId;
  String? createdAt;
  final List<ExerciseHistoryModel> exercises;

  WorkoutModel({this.id, this.userId, this.createdAt, required this.exercises});

  factory WorkoutModel.fromRawJson(String str) =>
      WorkoutModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkoutModel.fromJson(Map<String, dynamic> json) =>
      WorkoutModel(
        id: json['id'],
        userId: json['userId'],
        createdAt: json['createdAt'],
        exercises: List<dynamic>.from(json['exercises']).map((exerciseHistory) {
          return ExerciseHistoryModel.fromJson(exerciseHistory);
        }).toList(),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "userId": userId,
        "createdAt": createdAt,
        "exercises": exercises.map((history) => history.toJson()).toList()
      };
}
