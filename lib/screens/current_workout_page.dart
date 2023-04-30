import 'package:flutter/material.dart';
import 'package:gym_tracker/components/close_alert_dialog.dart';
import 'package:gym_tracker/components/exercise_set_component.dart';
import 'package:gym_tracker/components/padding_elevated_button.dart';
import 'package:gym_tracker/constants.dart' as constants;
import 'package:gym_tracker/screens/exercise_categories_page.dart';
import 'package:gym_tracker/services/exercise_model.dart';

class CurrentWorkoutPage extends StatefulWidget {
  const CurrentWorkoutPage({Key? key}) : super(key: key);

  @override
  State<CurrentWorkoutPage> createState() => _CurrentWorkoutPageState();
}

class _CurrentWorkoutPageState extends State<CurrentWorkoutPage> {
  final List<ExerciseModel> _selectedExercises = [];
  Map<String, List<ExerciseModel>> _selectedExercisesPerCategory = {};
  Map<String, List<Widget>> setByExercise = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Current Workout'),
          foregroundColor: constants.appBarForegroundColor,
          backgroundColor: constants.appBarBackgroundColor,
          elevation: constants.appBarElevation,
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
                onPressed: () {
                  if (setByExercise.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CloseAlertDialog(
                            title: 'Cancel Workout?',
                            content:
                                'Are you sure you want to cancel this workout? \nAll progress will be lost.',
                            actionButtonText: 'Cancel Workout',
                            resumeButtonText: 'Resume',
                            actionButtonStyle: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CloseAlertDialog(
                            title: '💪',
                            content: 'Finish Workout?',
                            actionButtonText: 'Finish',
                            resumeButtonText: 'Cancel',
                            actionButtonStyle: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade400,
                            ),
                          );
                        });
                  }
                },
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    foregroundColor: Colors.green.shade400),
                child: const Text(
                  'Finish',
                  style: TextStyle(fontSize: 18),
                )),
          ]),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Visibility(
              visible: _selectedExercises.isNotEmpty,
              child: Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _selectedExercises.length,
                    itemBuilder: (context, index) {
                      setByExercise.putIfAbsent(
                          _selectedExercises[index].name, () => []);
                      return ExpansionTile(
                          maintainState: true,
                          expandedCrossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          title: Text(_selectedExercises[index].name),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                    width: 150,
                                    child: Text(
                                      'WEIGHT',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    )),
                                SizedBox(
                                    width: 150,
                                    child: Text(
                                      'REPS',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ))
                              ],
                            ),
                            Column(
                              children: setByExercise[
                                      _selectedExercises[index].name] ??
                                  [],
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    var listOfExerciseSets = setByExercise[
                                        _selectedExercises[index].name];
                                    if (listOfExerciseSets != null) {
                                      listOfExerciseSets.add(
                                          ExerciseSetComponent(
                                              setNumber:
                                                  listOfExerciseSets.length +
                                                      1));
                                    }
                                  });
                                },
                                child: Text('+ Add Set'))
                          ]);
                    }),
              ),
            ),
            PaddingElevatedButton(
              onPressed: () async {
                _selectedExercisesPerCategory = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExerciseCategoriesPage(
                              selectExercise: true,
                              selectedExercisesPerCategory:
                                  _selectedExercisesPerCategory,
                            )));

                if (_selectedExercisesPerCategory.isNotEmpty) {
                  setState(() {
                    List<ExerciseModel> selectedUserExercises =
                        _selectedExercisesPerCategory.values
                            .expand((element) => element)
                            .toList();
                    var newSelectedExercises = selectedUserExercises.where(
                        (element) => !_selectedExercises.contains(element));

                    /// Add to current workout newly selected exercises even it happens during workout
                    /// Delete if some exercises were deselected.
                    _selectedExercises.addAll(newSelectedExercises);
                    _selectedExercises.removeWhere(
                        (element) => !selectedUserExercises.contains(element));
                  });
                }
              },
              label: 'Add Exercises',
            ),
            PaddingElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              label: 'Cancel Workout',
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
