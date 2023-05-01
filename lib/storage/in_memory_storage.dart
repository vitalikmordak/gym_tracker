import 'package:gym_tracker/services/dto/exercise_model.dart';

class InMemoryStorage {

  static Map<String, List<ExerciseModel>> exercisesByGroup = {};
  static List<String> getExerciseCategories() {
    return exercisesByGroup.keys.toList();
  }

  static List<String> setTypes = [];
  static List<String> categories = [];

}