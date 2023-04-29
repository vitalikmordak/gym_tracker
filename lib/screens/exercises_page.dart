import 'package:flutter/material.dart';
import 'package:gym_tracker/constants.dart' as constants;
import 'package:gym_tracker/services/exercise_model.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage(
      {Key? key,
      required this.selectExercise,
      required this.categoryExercises,
      required this.categoryIcon})
      : super(key: key);

  final bool selectExercise;
  final List<ExerciseModel> categoryExercises;
  final AssetImage categoryIcon;
//todo: need to provide for this page exercise
// which already selected for particular category
// if we turn back to select/unselect exercises.
  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {

  Map<int, ExerciseModel> _selectedExercise = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !widget.selectExercise,
        foregroundColor: constants.appBarForegroundColor,
        backgroundColor: constants.appBarBackgroundColor,
        elevation: constants.appBarElevation,
      ),
      floatingActionButton: Visibility(
        visible: widget.selectExercise,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                padding:
                    EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0)),
            icon: Icon(Icons.keyboard_backspace_rounded),
            label: Text('Select: ${_selectedExercise.length}'),
            onPressed: () {
              Navigator.pop(context, _selectedExercise.values.toList());
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: ListView.builder(
        itemCount: widget.categoryExercises.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding:
        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            title: Text(widget.categoryExercises[index].name,
        style: TextStyle(fontSize: 20.0)),
            leading: Image(
      height: 100,
      image: widget.categoryIcon,
            ),
            onTap: () {
      setState(() {
        if (widget.selectExercise) {
          if (_selectedExercise.containsKey(index)) {
      _selectedExercise.remove(index);
          } else {
      _selectedExercise.putIfAbsent(
        index,
        () => widget.categoryExercises[index],
      );
          }
        }
      });
            },
            trailing: Visibility(
      visible:
          widget.selectExercise && _selectedExercise.containsKey(index),
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
