import 'dart:convert';

import 'package:gym_tracker/services/dto/exercise_history_model.dart';
import 'package:gym_tracker/services/dto/exercise_model.dart';
import 'package:gym_tracker/services/dto/exercise_set_model.dart';
import 'package:gym_tracker/services/dto/workout_model.dart';
import 'package:gym_tracker/storage/in_memory_storage.dart';

import 'networking_client.dart';
import "package:collection/collection.dart";

class WorkoutClient {
  final String bathPath = "localhost:8080";

  Future<dynamic> getExercises() async {
    var uri = Uri.http(bathPath, "/api/v1/workouts");
    NetworkClient client = NetworkClient(uri);
    String response = await client.get();

    List parsed = jsonDecode(response);
    List<ExerciseModel> exercises =
        parsed.map((e) => ExerciseModel.fromJson(e)).toList();
    InMemoryStorage.exercisesByGroup =
        groupBy(exercises, (ExerciseModel em) => em.groupName);
  }

  void createWorkout(Map<ExerciseModel, List<ExerciseSetModel>> workout) async {
    var uri = Uri.http(bathPath, "/api/v1/workouts");
    NetworkClient client = NetworkClient(uri);

    var exerciseHistoryModels = workout.entries
        .map((workout) =>
            ExerciseHistoryModel(exercise: workout.key, sets: workout.value))
        .toList();

    await client.post(WorkoutModel(exercises: exerciseHistoryModels).toRawJson());
  }
}
