import 'package:flutter/material.dart';
import 'package:gym_tracker/screens/current_workout_bottom_sheet_page.dart';
import 'package:gym_tracker/screens/exercise_category_page.dart';
import 'package:gym_tracker/storage/in_memory_storage.dart';
import 'package:gym_tracker/vo/excercise.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({Key? key, this.selectExercise = false})
      : super(key: key);

  final bool selectExercise;

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  Map<String, int> selectedExerciseNumberPerCategory = {};
  List<String> _selectedExercises = [];

  InMemoryStorage storage = InMemoryStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises'),
      ),
      floatingActionButton: Visibility(
        visible: widget.selectExercise,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                padding:
                    EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0)),
            icon: Icon(Icons.keyboard_backspace_rounded),
            label: Text(
                'Select: ${selectedExerciseNumberPerCategory.values.fold(0, (a, b) => a + b)}'),
            onPressed: () {
              Navigator.pop(context, _selectedExercises);
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: ListView.builder(
          itemCount: storage.categories.length,
          itemBuilder: (context, index) {
            String _categoryName = storage.categories[index].categoryName;
            AssetImage _categoryIcon = storage.categories[index].categoryIcon;
            List<Exercise> _categoryExercises =
                storage.categories[index].exercises;
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
                List<String>? selectedExercises = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        //todo: propagate selected if exist to ExerciseCategoryPage to have select/unselect ability
                        builder: (context) => ExerciseCategoryPage(
                              categoryIcon: _categoryIcon,
                              selectExercise: widget.selectExercise,
                              categoryExercises: _categoryExercises
                                  .map((e) => e.name)
                                  .toList(), //todo: change List<string> to List<Exercise>
                            )));
                if (selectedExercises != null && selectedExercises.isNotEmpty) {
                  setState(() {
                    selectedExerciseNumberPerCategory[_categoryName] =
                        selectedExercises.length;
                    _selectedExercises.addAll(selectedExercises);
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
