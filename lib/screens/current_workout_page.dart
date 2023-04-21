import 'package:flutter/material.dart';
import 'package:gym_tracker/components/close_alert_dialog.dart';
import 'package:gym_tracker/screens/exercises_page.dart';

class CurrentWorkoutPage extends StatefulWidget {
  const CurrentWorkoutPage({Key? key}) : super(key: key);

  @override
  State<CurrentWorkoutPage> createState() => _CurrentWorkoutPageState();
}

class _CurrentWorkoutPageState extends State<CurrentWorkoutPage> {
  bool _workoutRunning = true;
  List<String> _selectedExercises = [];

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
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CloseAlertDialog(
                        title: 'Cancel Workout?',
                        content:
                            'Are you sure you want to cancel this workout? \nAll progress will be lost.',
                        cancelButtonText: 'Cancel Workout',
                        resumeButtonText: 'Resume',
                        cancelAction: () => _workoutRunning = false,
                      );
                    });
              },
            ),
          ]),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _selectedExercises.isEmpty
                ? SizedBox(
                    height: 25.0,
                  )
                : Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _selectedExercises.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_selectedExercises[index]),
                          );
                        }),
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
