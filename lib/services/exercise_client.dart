import 'dart:convert';

import 'package:gym_tracker/services/exercise_model.dart';
import 'package:gym_tracker/storage/in_memory_storage.dart';

import 'networking_client.dart';
import "package:collection/collection.dart";


class ExerciseClient {
  final String bathPath = "localhost:8080";
  final String exerciseGroupsPath = "/api/v1/exercises/groups";

  Future<dynamic> getExercises() async {
    var uri = Uri.http(bathPath, "/api/v1/exercises");
    NetworkClient client = NetworkClient(uri);
    String response = await client.getData();

    List parsed = jsonDecode(response);
    List<ExerciseModel> exercises = parsed.map((e) => ExerciseModel.fromJson(e)).toList();
    Map<String, List<ExerciseModel>> groupBy2 = groupBy(exercises, (ExerciseModel em)=> em.groupName);
    InMemoryStorage.exercisesByGroup = groupBy2;
  }
}
