import 'dart:convert';

import '../storage/in_memory_storage.dart';
import 'dto/exercise_model.dart';
import 'networking_client.dart';
import 'package:collection/collection.dart';

class DataFetcher {
  static fetchAll() async {
    fetchExercises();
    fetchSetTypes();
    fetchCategories();
  }

  static fetchExercises() async {
    var uri = Uri.http("localhost:8080", "/api/v1/exercises");
    NetworkClient client = NetworkClient(uri);
    String response = await client.get();

    List parsed = jsonDecode(response);
    List<ExerciseModel> exercises =
        parsed.map((e) => ExerciseModel.fromJson(e)).toList();
    InMemoryStorage.exercisesByGroup = groupBy(exercises,
        (ExerciseModel em) => ExerciseModel.capitalize(em.groupName));
  }

  static fetchSetTypes() async {
    var uriSetTypes = Uri.http("localhost:8080", "/api/v1/exercises/sets/type");
    String responseSetTypes = await NetworkClient(uriSetTypes).get();
    List parsedSetTypes = jsonDecode(responseSetTypes);

    InMemoryStorage.setTypes = parsedSetTypes
        .map((e) => ExerciseModel.capitalize(e.toString()))
        .toList();
  }

  static fetchCategories() async {
    var uriSetTypes = Uri.http("localhost:8080", "/api/v1/exercises/groups");
    String responseSetTypes = await NetworkClient(uriSetTypes).get();
    List parsedSetTypes = jsonDecode(responseSetTypes);

    InMemoryStorage.categories = parsedSetTypes
        .map((e) => ExerciseModel.capitalize(e.toString()))
        .toList();
  }
}
