import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/components/editable_exercise_dialog.dart';
import 'package:gym_tracker/constants.dart' as constants;
import 'package:gym_tracker/screens/exercises_page.dart';
import 'package:gym_tracker/services/data_fetcher.dart';
import 'package:gym_tracker/services/dto/exercise_model.dart';
import 'package:gym_tracker/storage/in_memory_storage.dart';

class ExerciseCategoriesPage extends StatefulWidget {
  ExerciseCategoriesPage({
    Key? key,
    this.selectExercise = false,
    Map<String, List<ExerciseModel>>? selectedExercisesPerCategory,
  }) : super(key: key) {
    if (selectedExercisesPerCategory != null) {
      this.selectedExercisesPerCategory.clear();
      this.selectedExercisesPerCategory.addAll(selectedExercisesPerCategory);
    }
  }

  final bool selectExercise;

  /// selectedExercisesPerCategory - Map of selected exercises per category
  /// which propagates between screens to select/unselect exercises for current workout
  final Map<String, List<ExerciseModel>> selectedExercisesPerCategory = {};

  @override
  State<ExerciseCategoriesPage> createState() => _ExerciseCategoriesPageState();
}

class _ExerciseCategoriesPageState extends State<ExerciseCategoriesPage> {
  Map<String, int> selectedExerciseNumberPerCategory = {};
  List<ExerciseModel> _selectedExercises = [];
  late Map<String, List<ExerciseModel>> exercisesGroups;
  InMemoryStorage storage = InMemoryStorage();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    exercisesGroups = InMemoryStorage.exercisesByGroup;
    /// If we receive via constructor selectedExercisesPerCategory, need to set selectedExerciseNumberPerCategory
    widget.selectedExercisesPerCategory.forEach((key, value) {
      selectedExerciseNumberPerCategory[key] = value.length;
    });
    setState(() {
      if (exercisesGroups.isNotEmpty) {
        _isLoading = false;
      }
    });
  }

  /// Refreshes categories when add/edit exercise
  Future<void> refreshCategories() async {
    await DataFetcher.fetchExercises();
    setState(() {
      exercisesGroups = InMemoryStorage.exercisesByGroup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Exercises'),
          foregroundColor: constants.appBarForegroundColor,
          backgroundColor: constants.appBarBackgroundColor,
          elevation: constants.appBarElevation,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return EditableExerciseDialog(refreshCategories,
                          titleText: 'Create New Exercise');
                    });
              },
              icon: const Icon(Icons.add_box_outlined),
              color: Colors.black54,
              iconSize: 30,
            ),
          ]),
      floatingActionButton: Visibility(
        visible: widget.selectExercise,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                padding:
                    EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0)),
            icon: const Icon(Icons.keyboard_backspace_rounded),
            label: Text(
                'Select: ${selectedExerciseNumberPerCategory.values.fold(0, (a, b) => a + b)}'),
            onPressed: () {
              /// Returns to previous screen selected exercises
              Navigator.pop(context, widget.selectedExercisesPerCategory);
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: exercisesGroups.keys.length,
              itemBuilder: (context, index) {
                String _categoryName = exercisesGroups.keys.elementAt(index);
                // AssetImage _categoryIcon = storage.categories[index].categoryIcon;
                AssetImage _categoryIcon =
                    AssetImage('assets/exercise_icons/icons8-biceps-100.png');
                List<ExerciseModel> _categoryExercises =
                    exercisesGroups[_categoryName] as List<ExerciseModel>;
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  title: Text(_categoryName, style: TextStyle(fontSize: 20.0)),
                  leading: Image(height: 100, image: _categoryIcon),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          !selectedExerciseNumberPerCategory
                                  .containsKey(_categoryName)
                              ? '${_categoryExercises.length}'
                              : 'Selected: ${selectedExerciseNumberPerCategory[_categoryName]}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey,
                        size: 30.0,
                      ),
                    ],
                  ),
                  onTap: () async {
                    List<ExerciseModel>? selectedExercises = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExercisesPage(
                                  categoryIcon: _categoryIcon,
                                  isExerciseSelectable: widget.selectExercise,
                                  selectedExercises:
                                      widget.selectedExercisesPerCategory[_categoryName] ?? [],
                                  exercises: _categoryExercises,
                                )));
                    if (selectedExercises != null &&
                        selectedExercises.isNotEmpty) {
                      setState(() {
                        selectedExerciseNumberPerCategory[_categoryName] =
                            selectedExercises.length;
                        _selectedExercises.addAll(selectedExercises);
                        widget.selectedExercisesPerCategory[_categoryName] =
                            selectedExercises;
                      });
                    } else {
                      setState(() {
                        selectedExerciseNumberPerCategory.remove(_categoryName);
                      });
                    }
                  },
                );
              }),
    );
  }
}
