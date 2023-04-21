import 'package:flutter/material.dart';
import 'package:gym_tracker/components/close_alert_dialog.dart';
import 'package:gym_tracker/components/exercise_set_component.dart';
import 'package:gym_tracker/screens/exercises_page.dart';

class CurrentWorkoutPage extends StatefulWidget {
  const CurrentWorkoutPage({Key? key}) : super(key: key);

  @override
  State<CurrentWorkoutPage> createState() => _CurrentWorkoutPageState();
}

class _CurrentWorkoutPageState extends State<CurrentWorkoutPage> {
  bool _workoutRunning = true;
  List<String> _selectedExercises = [];
  Map<String, List<Widget>> setByExercise = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Current Workout'),
          automaticallyImplyLeading: false,
          actions: [
            ElevatedButton(
              child: Text('Finish'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade400),
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
            ),
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
                          _selectedExercises[index], () => []);
                      return ExpansionTile(
                          maintainState: true,
                          expandedCrossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          title: Text(_selectedExercises[index]),
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
                              children:
                                  setByExercise[_selectedExercises[index]] ??
                                      [],
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    var listOfExerciseSets = setByExercise[
                                        _selectedExercises[index]];
                                    if (listOfExerciseSets != null) {
                                      listOfExerciseSets.add(
                                          ExerciseSetComponent(
                                              setNumber: listOfExerciseSets.length + 1));
                                    }
                                  });
                                },
                                child: Text('+ Add Set'))
                          ]);
                    }),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                List<String> selectedUserExercises = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExercisesPage(
                              selectExercise: true,
                            )));

                if (selectedUserExercises.isNotEmpty) {
                  setState(() {
                    _selectedExercises = selectedUserExercises;
                    print(_selectedExercises);
                  });
                }
              },
              child: Text('Add Exercises'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel Workout'),
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
