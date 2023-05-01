import 'package:flutter/material.dart';
import 'package:gym_tracker/constants.dart' as constants;
import 'package:gym_tracker/services/dto/exercise_model.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({Key? key,
    required this.isExerciseSelectable,
    required this.exercises,
    required this.selectedExercises,
    required this.categoryIcon})
      : super(key: key);

  final bool isExerciseSelectable;
  final List<ExerciseModel> exercises;
  final List<ExerciseModel> selectedExercises;
  final AssetImage categoryIcon;

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !widget.isExerciseSelectable,
        foregroundColor: constants.appBarForegroundColor,
        backgroundColor: constants.appBarBackgroundColor,
        elevation: constants.appBarElevation,
      ),
      floatingActionButton: Visibility(
        visible: widget.isExerciseSelectable,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                padding:
                EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0)),
            icon: Icon(Icons.keyboard_backspace_rounded),
            label: Text('Select: ${widget.selectedExercises.length}'),
            onPressed: () {
              Navigator.pop(context, widget.selectedExercises);
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: ListView.builder(
        itemCount: widget.exercises.length,
        itemBuilder: (context, index) {
          ExerciseModel currentExercise = widget.exercises[index];

          return ListTile(
            contentPadding:
            EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            title: Text(widget.exercises[index].name,
                style: TextStyle(fontSize: 20.0)),
            leading: Image(
              height: 100,
              image: widget.categoryIcon,
            ),
            onTap: () {
              setState(() {
                if (widget.isExerciseSelectable) {
                  if (widget.selectedExercises.contains(currentExercise)) {
                    widget.selectedExercises.remove(currentExercise);
                  } else {
                    widget.selectedExercises.add(currentExercise);
                  }
                }
              });
            },
            trailing: Visibility(
              visible:
              widget.isExerciseSelectable &&
                  widget.selectedExercises.isNotEmpty && widget.selectedExercises.contains(currentExercise),
              child: Icon(
                Icons.check,
                size: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
          );
        },
      ),
    );
  }
}
